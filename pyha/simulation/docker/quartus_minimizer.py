import os
import os.path
import subprocess
import glob
import shutil
import time
import numpy as np
from scipy import signal
from pyha import simulate, hardware_sims_equal, get_resource_usage, Complex
from pyha.cores.fft import BitreversalFFTshiftAVGPool
from pyha.cores.filter import FIR, MovingAverage
from pyha.simulation import vhdl_simulation

source_path = '/home/gaspar/intelFPGA_lite/18.0'
reduced_path = '/home/gaspar/intelFPGA_lite/reduced'

# MOCK simulation calls to the reduced version
vhdl_simulation.quartus_map = lambda cwd: subprocess.run([reduced_path + '/quartus/bin/quartus_map', 'quartus_project'],
                                                         cwd=cwd)
vhdl_simulation.quartus_eda = lambda cwd: subprocess.run([reduced_path + '/quartus/bin/quartus_eda', 'quartus_project'],
                                                         cwd=cwd)


def test_mac():
    np.random.seed(0)
    taps = signal.remez(16, [0, 0.1, 0.2, 0.5], [1, 0])
    dut = FIR(taps)
    inp = np.random.uniform(-1, 1, 64)

    sims = simulate(dut, inp, simulations=['PYHA', 'GATE'])
    assert hardware_sims_equal(sims)

    lut, mem, mul = get_resource_usage()
    try:
        assert lut == 313
        assert mem == 0
        assert mul == 16
    except:
        exit(0)
        assert 0


def test_shr():
    np.random.seed(0)
    dut = MovingAverage(window_len=16, dtype=Complex)
    N = 64
    x = (np.random.normal(size=N) + np.random.normal(size=N) * 1j) * 0.25
    sims = simulate(dut, x, simulations=['PYHA', 'GATE'])
    assert hardware_sims_equal(sims)

    lut, mem, mul = get_resource_usage()
    try:
        assert lut == 139
        assert mem == 468
        assert mul == 0
    except:
        exit(0)
        assert 0


def test_ram():
    np.random.seed(0)
    input_power = 0.5
    fft_size = 64
    avg_freq_axis = 2
    avg_time_axis = 1
    packets = avg_time_axis * 2

    orig_inp = np.random.uniform(-1, 1, size=(packets, fft_size)) * input_power
    dut = BitreversalFFTshiftAVGPool(fft_size, avg_freq_axis, avg_time_axis)
    sims = simulate(dut, orig_inp, simulations=['PYHA', 'GATE'])
    assert hardware_sims_equal(sims)

    lut, mem, mul = get_resource_usage()
    try:
        assert lut == 319
        assert mem == 2304
        assert mul == 0
    except:
        exit(0)
        assert 0


def get_size_sorted_files(path):
    def path_bytes(path='.'):
        total = 0
        if os.path.isfile(path):
            return os.stat(path).st_size
        if os.path.islink(path):  # dont mess with links
            return 0
        for entry in os.scandir(path):
            if entry.is_file():
                total += entry.stat().st_size
            elif entry.is_dir():
                total += path_bytes(entry.path)
        return total

    files = glob.glob(f'{path}/**/*', recursive=True)
    sizes = [(x, path_bytes(x)) for x in files]
    sorted_dir = sorted(sizes, key=lambda x: x[1], reverse=True)
    return sorted_dir[1:]


def main():
    print(f'Copy {source_path} to {reduced_path}...')
    subprocess.run(['rm', '-rf', reduced_path])
    subprocess.run(['cp', '-r', source_path, reduced_path])

    # need to remove this file or crash takes so long time...
    try:
        os.remove(reduced_path + "/quartus/linux64/crashreporter")
    except:
        pass

    print(f'Start minimizing...')
    known_failures = []
    while True:
        folders = get_size_sorted_files(reduced_path)

        target = None
        for x in folders:
            if x[0] not in known_failures:
                if '.so' in x[0]: # dont mess with .so files.. BUT around 1GB could be saved here!
                    continue

                if x[1] < 1000:  # smaller than 1kB
                    exit(0)
                target = x[0]
                print(f'{x[0]} size: {x[1]/1024/1024} MB')
                break

        dest = target + '_deleted'
        os.rename(target, dest)
        try:
            test_mac()
            test_shr()
            test_ram()
            subprocess.run(['rm', '-rf', dest])
            print('OK!')
        except:
            print('Failed!')
            known_failures.append(target)
            os.rename(dest, target)


if __name__ == '__main__':
    main()
