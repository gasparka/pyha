import logging

from redbaron import RedBaron, ClassNode, inspect

from common.sfix import Sfix
from conversion.templates import PACKAGE_TEMPLATE
from misc.metaclass.hwsim import HW
from register.model.hw_model import Register

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class ClassConv:
    def __init__(self, obj, ref_node: ClassNode):
        self.name = obj.__class__.__name__
        logger.info('Converting class: {}'.format(self.name))

        self.ref_node = ref_node
        self.obj = obj

        self.self_t = []
        self.collect_self_t()
        self.get_vhdl_self_t()
        self.convert_functions()

    def collect_self_t(self):
        for key, val in self.obj.__dict__.items():
            if isinstance(val, Sfix):
                self.self_t.append([key, 'sfixed({} downto {})'.format(val.left, val.right), val])
            else:
                logger.info('self_t ignoring {}:{}, not convertable'.format(key, val))

        logger.info('self_t collected following registers:{}'.format(self.self_t))

    def get_vhdl_self_t(self):
        for x in self.self_t:
            key, type, _ = x
            pass

    def convert_functions(self):
        pass


def convert_class(node: ClassNode):
    pass
    # functions =


def main(root_obj):
    assert isinstance(root_obj, HW)  # must derive from HW

    name = root_obj.__class__.__name__
    source_path = inspect.getsourcefile(type(r))
    content = open(source_path).read()
    red = RedBaron(content)

    cls = red('classnode')
    assert len(cls) == 1  # more than 1 class in file
    cls = cls[0]

    cls = ClassConv(root_obj, cls)

    slots = dict()
    slots['NAME'] = name
    slots['HEADER'] = 'head'
    slots['BODY'] = 'body'
    print(PACKAGE_TEMPLATE.format(**slots))

    pass


r = Register()
main(r)
# path = '/home/gaspar/git/hwpy/components/register/model/hw_model.py'
# file_content = open(path).read()
#
# red = RedBaron(file_content)
#
# cls = red('classnode')
#
# ret = convert_classnode(cls[0])

pass