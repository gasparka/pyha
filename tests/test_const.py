import textwrap

import pytest


@pytest.fixture
def t0():
    class T0(HW):
        def __init__(self):
            self.mode = Const(1)

        def main(self, a):
            if a:
                return a
            else:
                return 0

    dut = T0()
    dut.main(1)
    dut.main(2)
    return dut


def test_datamodel(t0):
    datamodel = DataModel(t0)
    assert datamodel.self_data['much_dummy_very_wow'] == 0  # dummy because constants are not added to VHDL self
    assert datamodel.constants['mode'] == Const(1)


def test_vhdl_datamodel(t0):
    conv = get_conversion(t0)

    expect = textwrap.dedent("""\
            type register_t is record
                much_dummy_very_wow: integer;
            end record;

            type self_t is record
                mode: integer;
                \\next\\: register_t;
            end record;""")
    dm = conv.get_datamodel()
    assert expect == dm

# todo: for lists of submodules constants must match!