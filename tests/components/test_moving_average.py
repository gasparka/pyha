import pytest

from pyha.common.sfix import Sfix
from pyha.components.moving_average import MovingAverage
from pyha.simulation.simulation_interface import assert_sim_match


def test_window1():
    with pytest.raises(AttributeError):
        mov = MovingAverage(window_len=1)


def test_window2():
    mov = MovingAverage(window_len=2)
    x = [0., 1., 2., 3., 4.]
    expected = [0.0, 0.5, 1.5, 2.5, 3.5]
    assert_sim_match(mov, [Sfix(left=4, right=-18)], expected, x,
                     dir_path='/home/gaspar/git/pyha/playground/conv')


def test_window3():
    mov = MovingAverage(window_len=4)
    x = [-0.2, 1.05, 2, -1.9571, 1.0987]
    expected = [-0.05, 0.2125, 0.7125, 0.223225, 0.5479]
    assert_sim_match(mov, [Sfix(left=1, right=-18)], expected, x, rtol=1e-4)


def test_max():
    mov = MovingAverage(window_len=4)
    x = [2., 2., 2., 2., 2., 2.]
    expected = [0.5, 1., 1.5, 2., 2., 2.]
    assert_sim_match(mov, [Sfix(left=1, right=-18)], expected, x)


def test_min():
    mov = MovingAverage(window_len=8)
    x = [-1, -1, -1, -1, -1, -1, -1, -1, -1]
    expected = [-0.125, -0.25, -0.375, -0.5, -0.625, -0.75, -0.875, -1., -1.]
    assert_sim_match(mov, [Sfix(left=0, right=-18)], expected, x)
