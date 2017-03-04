from contextlib import suppress

import numpy as np

class SignalTapParser:
    def __init__(self, file: str):
        import csv

        self.labels = []
        self.data = []
        with open(file) as csvfile:
            reader = csv.reader(csvfile)
            for x in reader:
                if len(x) and x[0] == 'Data:':
                    self.labels = next(reader)
                    self.data = [x for x in reader]

        self.trans_data = np.array(self.data).T

    def __getitem__(self, item: str):
        i = self.labels.index(item)
        return self.trans_data[i]

    def to_int(self, data, bits):
        r = []
        for x in data:
            with suppress(ValueError):
                new = int(x, 16)
                if new >= 2**(bits-1): #conv to signed
                    new -= 2**(bits)
                r.append(new)
        return r

    # NB! these wont work if you export sfixed signal( has negative bounds in name )
    # need to invert msb or something
    def to_float(self, data, bits):
        """ assume 1 sign others fractional"""
        ints = self.to_int(data, bits)
        return np.array(ints) / 2 ** (bits-1)

    def to_bladerf(self, data):
        """ assume 5 bit is for integer(1 bit is sign) and others for fractional part
         This is used in bladeRF """
        ints = self.to_int(data, 16)
        return np.array(ints) / 2 ** (11)




