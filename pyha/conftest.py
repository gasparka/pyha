"""
0x1 - skip MODEl
0x2 - skip HW_MODEL
0x4 - skip RTL
0x8 - skip GATE

can combine, 0x3 - skip MODEL and HW_MODEL
"""
import os
from contextlib import suppress

SKIP_ABOVE_HW_MODEL = 0x4 + 0x8
SKIP_ABOVE_RTL = 0x8

SKIP_SIMULATIONS_MASK = 0x0

# SKIP_SIMULATIONS_MASK = SKIP_ABOVE_RTL
SKIP_SIMULATIONS_MASK = SKIP_ABOVE_HW_MODEL

with suppress(KeyError):
    f = int(os.environ['SKIP_SIMULATIONS_MASK'], 16)
    SKIP_SIMULATIONS_MASK = f
