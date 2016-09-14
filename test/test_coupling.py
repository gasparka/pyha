import textwrap

import pytest
from redbaron import RedBaron

from conversion.converter import red_to_conv_hub, VHDLType, convert
from conversion.coupling import UndefinedVariables
from conversion.extract_datamodel import DataModel


@pytest.fixture
def converter():
    class Conv:
        def __call__(self, code, datamodel=None):
            red = RedBaron(code)
            return convert(red[0], self, datamodel)

    return Conv()


def test_add_duplicate():
    VHDLType('lol', None)
    with pytest.raises(Exception):
        VHDLType('lol', None)


def test_var_discovery(converter):
    code = textwrap.dedent("""\
        def a(b):
            pass""")

    converter(code)
    assert len(UndefinedVariables.get()) == 1
    assert 'b' in UndefinedVariables.get()


def test_typed_def_argument(converter):
    code = textwrap.dedent("""\
        def a(b):
            pass""")

    datamodel = DataModel(locals={'a': {'b': 12}})
    expect = textwrap.dedent("""\
        procedure a(b: integer) is

        begin

        end procedure;""")
    conv = converter(code, datamodel)
    assert str(conv) == expect
