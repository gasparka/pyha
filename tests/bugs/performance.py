import cProfile

import numpy as np

from pyha.common.sfix import Sfix
from pyha.components.blade_demod.blade_receiver import Phantom2ReceiverBlade
from pyha.conversion.conversion import Conversion
from pyha.simulation.simulation_interface import debug_assert_sim_match, SIM_HW_MODEL

dut = Phantom2ReceiverBlade()
path = '/home/gaspar/git/pyha/tests/components/blade_demod/data/blade_signaltap.npy'
data = np.load(str(path))

from datetime import datetime

r = debug_assert_sim_match(dut, [Sfix(left=0, right=-15)] * 2, None, data.real, data.imag
                           , simulations=[SIM_HW_MODEL])
startTime = datetime.now()
profile = cProfile.Profile()
profile.enable()
conv = Conversion(dut)
profile.disable()
profile.print_stats(sort='tottime')
print(datetime.now() - startTime)

# SIM_HW run
# new_clocking : 14 (no checks)
# old: 22 (all checks)
# old: 14 (no checks)

# conversion
# new_clocking: 8
# old: 8
