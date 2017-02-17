import numpy as np

from pyha.common.sfix import ComplexSfix
from pyha.components.util_complex import Conjugate, ComplexMultiply
from pyha.simulation.simulation_interface import assert_sim_match


def test_conjugate():
    inputs = [0.5 + 0.1j, -0.234 + 0.1j, 0.5 - 0.1j, 1 + 1j, 1 - 1j, -1 + 1j, -1 - 1j]
    expect = [0.5 - 0.1j, -0.234 - 0.1j, 0.5 + 0.1j, 1 - 1j, 1 + 1j, -1 - 1j, -1 + 1j]

    dut = Conjugate()

    assert_sim_match(dut, [ComplexSfix(left=0, right=-18)], expect, inputs)


def test_multiply_consept():
    a = 1 + 1j
    b = 1 - 1j
    y = (1 + 1) + (-1 + 1) * 1j
    y = 2 + 0j

    assert a * b == y

    a = 0.5 + 0.5j
    b = 0.5 - 0.5j
    y = 0.5 + 0j
    e = a * b
    assert a * b == y


def test_multiply():
    a = [0.123 + .492j, 0.444 - 0.001j, -0.5 + 0.432j, -0.123 - 0.334j]
    b = [0.425 + .445j, -0.234 - 0.1j, -0.05 + 0.32j, 0.453 + 0.5j]

    y = [-0.166665 + 0.263835j, -0.103996 - 0.044166j, -0.113240 - 0.1816j,
         0.111281 - 0.212802j]

    dut = ComplexMultiply()
    assert_sim_match(dut, [ComplexSfix(left=0, right=-17)] * 2, y, a, b, rtol=1e-4)


def test_multiply_harmonic():
    # 2hz signal
    t = np.linspace(0, 2, 1024)
    a = np.exp(1j * 2 * np.pi * 2 * t)

    # 4hz signal
    b = np.exp(1j * 2 * np.pi * 4 * t)

    dut = ComplexMultiply()
    assert_sim_match(dut, [ComplexSfix(left=0, right=-17)] * 2, a * b, a, b, rtol=1e-4, )
