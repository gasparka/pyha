import textwrap

import pytest

from pyha.common.hwsim import HW
from pyha.conversion.conversion import get_objects_datamodel_conversion


@pytest.fixture
def simple():
    class A(HW):
        def __init__(self):
            self.reg = 0

    class B(HW):
        def __init__(self):
            self.sublist = [A(), A()]

    dut = B()
    conv, datamodel = get_objects_datamodel_conversion(dut)
    return conv, datamodel


def test_simple_datamodel(simple):
    conv, datamodel = simple
    assert 'sublist' in datamodel.self_data

    expect = ['type A_0_list_t is array (natural range <>) of A_0;']
    assert expect == conv.get_typedefs()

    data_conversion = conv.get_datamodel()
    expect = textwrap.dedent("""\
                type register_t is record
                    sublist: A_0_list_t(0 to 1);
                end record;

                type self_t is record
                    sublist: A_0_list_t(0 to 1);
                    \\next\\: register_t;
                end record;""")

    assert expect == data_conversion





    # def test_class_datamodel_submodule_list(converter):
    #     code = textwrap.dedent("""\
    #             class Tc(HW):
    #                 pass""")
    #
    #     datamodel = DataModel(self_data={'a': [Register(), Register()]})
    #
    #     expect = textwrap.dedent("""\
    #             type register_t is record
    #                 a: Register_0_list_t(0 to 11);
    #             end record;
    #
    #             type self_t is record
    #                 a: Register_0_list_t(0 to 11);
    #                 \\next\\: register_t;
    #             end record;""")
    #
    #     conv = converter(code, datamodel)
    #     assert expect == str(conv.get_datamodel())
    #
    #     expect = textwrap.dedent("""\
    #         procedure reset(self_reg: inout register_t) is
    #         begin
    #             self_reg.a := (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
    #         end procedure;""")
    #
    #     assert expect == str(conv.get_reset_str())
    #
    #     expect = ['type integer_list_t is array (natural range <>) of integer;']
    #     assert expect == conv.get_typedefs()
