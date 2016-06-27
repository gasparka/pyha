import numpy as np

from common.register import disable_reg_delay
from test.TODO.fir.main import FIR

disable_reg_delay()
dut = FIR(32)
inp = np.random.uniform(-1, 1, 1000)
rl = [dut.filter(x) for x in inp]
pass
