from enum import Enum

import pytest

from pyha.common.hwsim import HW
from pyha.conversion.extract_datamodel import DataModel


class TestEnum(Enum):
    ENUM0, ENUM1, ENUM2, ENUM3 = range(4)

@pytest.fixture
def t0():
    class T0(HW):
        def __init__(self, mode):
            self.mode = mode

        def main(self):
            pass
    dut = T0(TestEnum.ENUM1)
    dut.main()
    dut.main()
    return dut


def test_enum_datamodel(t0):
    datamodel = DataModel(t0)
    assert datamodel.self_data['mode'] == TestEnum.ENUM1
    pass
