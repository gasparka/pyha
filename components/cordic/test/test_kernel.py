import numpy as np
import pytest

from components.cordic.hw.kernel import CORDICKernel


@pytest.fixture(scope='function', params=['MODEL', 'HW-MODEL'])
def kernel(request):
    iterations = 18
    if request.param == 'MODEL':
        from components.cordic.model.cordic import CORDIC
        cord = CORDIC(iterations)
        return cord.kernel
    elif request.param == 'HW-MODEL':
        cord = CORDICKernel(iterations)
        return cord.test_interface


def test_delay():
    # TODO: make this use kernel object
    from common.sfix import Sfix

    def report_delay(cord):
        x = Sfix(0.5, 2, -17)
        y = Sfix(0.5, 2, -17)
        phase = Sfix(0.5, 2, -17)

        i = 0
        while True:
            rx, ry, rphase = cord(x, y, phase)
            i += 1
            if float(rx) != 0.0 and float(ry) != 0.0 and float(rphase) != 0.0:
                return i

    cord = CORDICKernel(18)
    assert report_delay(cord) == cord.delay

    cord = CORDICKernel(12)
    assert report_delay(cord) == cord.delay

    cord = CORDICKernel(9)
    assert report_delay(cord) == cord.delay


def test_kernel_first_out_rot(kernel):
    rx, ry, rphase = kernel(1, 1, 0, mode='ROTATE')
    assert np.isclose(rx, [1.6467515412835914], atol=1e-3)
    assert np.isclose(ry, [1.6467689748804477], atol=1e-3)
    assert np.isclose(rphase, [-5.2933e-6], atol=1e-3)


def test_kernel_first_out_rot2(kernel):
    rx, ry, rphase = kernel(0.2, -0.01, np.pi, mode='ROTATE')
    assert np.isclose(rx, [-0.0403], atol=1e-3)
    assert np.isclose(ry, [0.3272], atol=1e-3)
    assert np.isclose(rphase, [1.3983], atol=1e-3)


def test_kernel_first_out_vec(kernel):
    rx, ry, rphase = kernel(1, 1, 0, mode='VECTOR')
    assert np.isclose(rx, [2.3288], atol=1e-3)
    assert np.isclose(ry, [1.7139e-05], atol=1e-3)
    assert np.isclose(rphase, [0.7853], atol=1e-3)


def test_kernel_first_out_vec2(kernel):
    rx, ry, rphase = kernel(-0.456, -0.89, -np.pi / 2, mode='VECTOR')
    assert np.isclose(rx, [1.5727], atol=1e-3)
    assert np.isclose(ry, [-0.4882], atol=1e-3)
    assert np.isclose(rphase, [-3.31407], atol=1e-3)


def test_kernel_rot(kernel):
    x = 1 / 1.646760
    y = 0
    phase = 0.5
    ref = np.exp(phase * 1j)

    rx, ry, rphase = kernel(x, y, phase, mode='ROTATE')
    # print(ref, x, y)
    np.testing.assert_almost_equal(rx, np.cos(phase), decimal=3)
    np.testing.assert_almost_equal(ry, np.sin(phase), decimal=3)


def test_kernel_vec(kernel):
    x = 0.3
    y = 1.0
    phase = 0
    inp = x + y * 1j
    rx, ry, rphase = kernel(x, y, phase, mode='VECTOR')

    # print(x,y,phase)
    np.testing.assert_almost_equal(1 / 1.646760 * rx, np.abs(inp), decimal=3)
    np.testing.assert_almost_equal(rphase, np.angle(inp), decimal=3)
