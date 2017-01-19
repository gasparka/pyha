import logging
import textwrap

import numpy as np

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

fixed_truncate = 'fixed_truncate'
fixed_round = 'fixed_round'

fixed_saturate = 'fixed_saturate'
fixed_wrap = 'fixed_wrap'

class ComplexSfix:
    def __init__(self, val=0.0 + 0.0j, left=0, right=0, overflow_style=fixed_saturate):
        if type(val) is Sfix and type(left) is Sfix:
            self.init_val = val.init_val + left.init_val * 1j
            self.real = val
            self.imag = left
        else:
            self.init_val = val
            self.real = Sfix(val.real, left, right, overflow_style=overflow_style)
            self.imag = Sfix(val.imag, left, right, overflow_style=overflow_style)

    @property
    def left(self):
        assert self.real.left == self.imag.left
        return self.real.left

    @property
    def right(self):
        assert self.real.right == self.imag.right
        return self.real.right

    def __eq__(self, other):
        if type(other) is type(self):
            return self.__dict__ == other.__dict__
        return False

    def __call__(self, x):
        return ComplexSfix(x, self.left, self.right)

    def __str__(self):
        return '{:.2f}{}{:.2f}j [{}:{}]'.format(self.real.val, '' if self.imag.val < 0.0 else '+', self.imag.val,
                                                self.left, self.right)

    def __repr__(self):
        return str(self)

    def has_same_bounds(self, other):
        if self.left == other.left and self.right == other.right:
            return True
        return False

    def bitwidth(self):
        return (self.left + abs(self.right)) * 2 + 2

    def to_stdlogic(self):
        return 'std_logic_vector({} downto 0)'.format(self.bitwidth() - 1)

    def vhdl_reset(self):
        return '(real=>{}, imag=>{})'.format(self.real.vhdl_reset(), self.imag.vhdl_reset())

    def fixed_value(self):
        assert self.bitwidth() <= 64  # must fit into numpy int, this is cocotb related?
        real = self.real.fixed_value()
        imag = self.imag.fixed_value()
        mask = (2 ** (self.bitwidth() // 2)) - 1
        return ((real & mask) << (self.bitwidth() // 2)) | (imag & mask)

    def vhdl_type_name(self):
        from pyha.conversion.coupling import pytype_to_vhdl
        return pytype_to_vhdl(self)

    def vhdl_type_define(self):
        template = textwrap.dedent("""\
            type {NAME} is record
                real: {DTYPE};
                imag: {DTYPE};
            end record;
            function ComplexSfix(a, b: sfixed({LEFT} downto {RIGHT})) return {NAME};
            """)

        return template.format(**{'NAME': self.vhdl_type_name(),
                                  'DTYPE': 'sfixed({} downto {})'.format(self.left, self.right),
                                  'RIGHT': self.right,
                                  'LEFT': self.left})

    def vhdl_init_function(self):
        template = textwrap.dedent("""\
            function ComplexSfix(a, b: sfixed({LEFT} downto {RIGHT})) return {NAME} is
            begin
                return (a, b);
            end function;
            """)

        return template.format(**{'NAME': self.vhdl_type_name(),
                                  'RIGHT': self.right,
                                  'LEFT': self.left})


# TODO: Verify stuff against VHDL library
class Sfix:
    # original idea was to use float for internal computations, now it has turned out that\
    # it is hard to match VHDL fixed point library outputs, thus in the future it may be better
    # to implement stuff as integer arithmetic

    # Disables all quantization and saturating stuff
    _float_mode = False

    @staticmethod
    def auto_size(val, bits):
        # FIXME: int_bits possibly not correct, since we cannot reporesent max positive value, actuall maximum value is (max_int) - (frac_min)
        # calculates for signed type
        if type(val) is list:
            maxabs = max(abs(x) for x in val)
            int_bits = np.floor(np.log2(np.abs(maxabs))) + 1
            fract_bits = -bits + int_bits + 1
            ret = [Sfix(x, int_bits, fract_bits) for x in val]
            return [Sfix(x, int_bits, fract_bits) for x in val]
        else:
            int_bits = np.floor(np.log2(np.abs(val))) + 1
            fract_bits = -bits + int_bits + 1
            return Sfix(val, int_bits, fract_bits)

    @staticmethod
    def set_float_mode(x):
        Sfix._float_mode = x

    def __init__(self, val=0.0, left=0, right=0, init_only=False, overflow_style=fixed_saturate,
                 round_style=fixed_round):
        self.round_style = round_style
        assert left >= right
        # if left == None:
        #     raise Exception('Left bound for Sfix is None!')
        #
        # if right == None:
        #     raise Exception('Right bound for Sfix is None!')
        val = float(val)
        if type(val) not in [float, int]:
            raise Exception('Value must be float or int!')
        self.right = right
        self.left = left
        self.val = val
        self.init_val = val

        # FIXME: This sucks, init should not call these anyways, make to_sfixed function
        if init_only or Sfix._float_mode:
            return

        if overflow_style is fixed_saturate:
            if self.overflows() and overflow_style:
                self.saturate()
            else:
                self.quantize()
        elif overflow_style is fixed_wrap:  # TODO: add tests
            self.quantize()
            self.wrap()
        else:
            raise Exception('Wtf')

    def __eq__(self, other):
        if type(other) is type(self):
            return self.__dict__ == other.__dict__
        return False

    # FIXME: THESE ARE FUCKED UP
    def max_representable(self):
        if self.left < 0:
            # FIXME: I am not sure how to handle this when negative index
            assert 0

            if self.right == 0:
                return 2 ** self.left
            else:
                return 2 ** self.left - 2 ** self.right
        else:
            return 2 ** self.left - 2 ** self.right

    def min_representable(self):
        return -2 ** self.left

    def overflows(self):
        return self.val < self.min_representable() or \
               self.val > self.max_representable()

    def is_lazy_init(self):
        return self.left == 0 and self.right == 0

    def saturate(self):
        old = self.val
        if self.val > self.max_representable():
            self.val = self.max_representable()
        elif self.val < self.min_representable():
            self.val = self.min_representable()
        else:
            assert False
        if not self.is_lazy_init() and not old == 1.0:
            logger.warning('Saturation {} -> {}'.format(old, self.val))

            # TODO: tests break
            # raise Exception('Saturation {} -> {}'.format(old, self.val))

    # TODO: add tests
    def wrap(self):
        fmin = self.min_representable()
        fmax = 2 ** self.left # no need to substract minimal step, 0.9998... -> 1.0 will still be wrapped as max bit pattern
        self.val = (self.val - fmin) % (fmax - fmin) + fmin

    def quantize(self):
        fix = self.val / 2 ** self.right

        if self.round_style is fixed_round:
            fix = np.round(fix)
        else:
            fix = int(fix)

        self.val = fix * 2 ** self.right

    # TODO: test, rounding not needed?
    def fixed_value(self):
        return int(np.round(self.val / 2 ** self.right))

    # def from_fixed(self, val, right):
    #     return (val * 2 ** self.outputs[i].right)

    def __str__(self):
        return '{} [{}:{}]'.format(str(self.val), self.left, self.right)

    def __repr__(self):
        return self.__str__()

    def __float__(self):
        return float(self.val)

    def resize(self, left=0, right=0, type=None, overflow_style=fixed_saturate, round_style=fixed_round):
        if type is not None:  # TODO: add tests
            left = type.left
            right = type.right
        return Sfix(self.val, left, right, overflow_style=overflow_style, round_style=round_style)

    def __add__(self, other):
        if type(other) == float:
            other = Sfix(other, self.left, self.right)
        return Sfix(self.val + other.val,
                    max(self.left, other.left) + 1,
                    min(self.right, other.right),
                    init_only=True)

    def __sub__(self, other):
        # TODO: why only float?
        if type(other) == float:
            other = Sfix(other, self.left, self.right)
        return Sfix(self.val - other.val,
                    max(self.left, other.left) + 1,
                    min(self.right, other.right),
                    init_only=True)

    def __mul__(self, other):
        # TODO: why only float?
        if type(other) == float:
            other = Sfix(other, self.left, self.right)
        return Sfix(self.val * other.val,
                    self.left + other.left + 1,
                    self.right + other.right,
                    init_only=True)

    def sign_bit(self):
        s = np.sign(self.val)
        if s in [0, 1]:
            return 0
        return 1

    def __rshift__(self, other):
        o = int(self.val / 2 ** self.right)
        o = (o >> other) * 2 ** self.right
        return Sfix(o,
                    self.left,
                    self.right,
                    init_only=True)

    def __lshift__(self, other):
        o = int(self.val / 2 ** self.right)
        o = (o << other) * 2 ** self.right
        return Sfix(o,
                    self.left,
                    self.right,
                    overflow_style=fixed_wrap)

    def __abs__(self):
        return Sfix(abs(self.val),
                    self.left + 1,
                    self.right,
                    init_only=True)

    # TODO: add tests
    def __lt__(self, other):
        return bool(self.val < other)

    # TODO: add tests
    def __gt__(self, other):
        return bool(self.val > other)

    # TODO: add tests
    def __neg__(self):
        return Sfix(-self.val,
                    self.left + 1,
                    self.right,
                    init_only=True)

    # TODO: add tests
    def __len__(self):
        assert self.left >= 0
        return -self.right + self.left + 1

    def __call__(self, x: float):
        return Sfix(x, self.left, self.right)

    def to_stdlogic(self):
        return 'std_logic_vector({} downto 0)'.format(self.left + abs(self.right))

    def vhdl_reset(self):
        return 'to_sfixed({}, {}, {})'.format(self.init_val, self.left, self.right)


def resize(fix, left_index=0, right_index=0, size_res=None, overflow_style=fixed_saturate, round_style=fixed_round):
    return fix.resize(left_index, right_index, size_res, overflow_style=overflow_style, round_style=round_style)


def left_index(x: Sfix):
    return x.left


def right_index(x: Sfix):
    return x.right
