import os
import subprocess


def test_hdl():
    window_pow = 0
    data_width = 0
    folder = "sim_envs/{}{}".format(window_pow, data_width)
    cwd = os.path.dirname(os.path.realpath(__file__))
    myDir = '{}/{}'.format(cwd, folder)
    try:
        os.remove(myDir + '/results.xml')
    except OSError:
        pass

    if not os.path.exists(myDir):
        os.makedirs(myDir)
    # os.chdir(os.path.dirname(os.path.realpath(__file__)))
    my_env = os.environ.copy()
    my_env["SIM_BUILD"] = folder

    # for some reason i needed this shit (cocotb needs to load the py test file)
    my_env["PYTHONPATH"] = "/home/gaspar/git/hwpy/test_1/dcrem/hdl/test:" + my_env["PYTHONPATH"]
    my_env["PYTHONPATH"] = "/home/gaspar/git/hwpy/:" + my_env["PYTHONPATH"]
    # my_env["PYTHONPATH"] = "/home/gaspar/git/hwpy/test_1/avg/:" + my_env["PYTHONPATH"]
    my_env["PYTHONHOME"] = "/home/gaspar/programs/anaconda2_32"
    my_env["PATH"] = "/home/gaspar/programs/anaconda2_32/bin:" + my_env["PATH"]

    # NEED TO RUN IN CORRECT DIR
    make_process = subprocess.call("make", env=my_env, cwd=cwd)
    assert make_process == 0
    # assert make_process.wait() == 0

    # test that all tests passed
    with open(myDir + '/results.xml', 'r') as myfile:
        assert myfile.read().find('failure') == -1


if __name__ == "__main__":
    test_hdl()
