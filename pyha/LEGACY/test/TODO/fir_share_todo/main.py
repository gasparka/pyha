from enum import Enum

from LEGACY.test.TODO import FIR


# see jookseb x2 clockinga, pole v6imalik liita teiste x1 komponentidega
# seda peab kasutama kanaliga avalon signaalidega...see tundub ainuke v6imalus
# TODO: hetkel j22b pooleli, liiga advanced feature (different clocks)
class ReuseFIR(object):
    def __init__(self):
        self.a = FIR(8)
        self.b = FIR(8)
        self.control = Enum('Control', 'ch1 ch2')

    def filter(self, x1, x2):
        if self.control == self.control.ch1:
            y = self.a.filter(x1)
            self.control = self.control.ch2
        else:
            y = self.b.filter(x2)
            self.control = self.control.ch1
        return y


tst = Enum('Animal', 'ant bee cat dog')
print(tst.ant)
