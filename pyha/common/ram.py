from copy import deepcopy
from pyha import Hardware


# todo: add getitem / setitem overloads and replace them with correct code in VHDL?
class RAM(Hardware):
    """
    Inital values works. No LUTs used if init is all 0, if init is omited some LUTs will be strangely used.

    """
    def __init__(self, items):
        self.data = deepcopy(items)
        self.write_value = deepcopy(items[0])
        self.write_enable = False
        self.write_address = 0
        self.read_reg = deepcopy(items[0])
        self.read_address = 0

    def delayed_read(self, address):
        self.read_address = address
        return self.read_reg

    def delayed_write(self, address, value):
        self.write_address = address
        self.write_enable = True
        self.write_value = value

    def get_readregister(self):
        return self.read_reg

    def __setattr__(self, key, value):
        self.__dict__[key] = value

    def _pyha_update_registers(self):
        try:
            self.read_reg = self.data[self.read_address]
        except:
            pass

        if self.write_enable:
            self.data[self.write_address] = self.write_value
            self.write_enable = False



