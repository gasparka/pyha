from test.dc_removal.average import Average


class DCRemoval(object):
    def __init__(self, window_pow):
        self.window_pow = window_pow
        self.i_avg = Average(window_pow)
        self.q_avg = Average(window_pow)
        self.clean_i = 0
        self.clean_q = 0

    def main(self, i, q):
        self.clean_i = i - self.i_avg.main(i)
        self.clean_q = q - self.q_avg.main(q)

        return self.clean_i, self.clean_q

    def abstract(self, i, q):
        clean_i = i - self.i_avg.abstract(i)[:len(i)]
        clean_q = q - self.q_avg.abstract(q)[:len(i)]
        return [(i, q) for i, q in zip(clean_i, clean_q)]


def test():
    import numpy as np
    import matplotlib.pyplot as plt
    inp_i = np.random.uniform(-1, 1, 1000)
    inp_q = np.random.uniform(-1, 1, 1000)
    # inp = range(128)
    av = DCRemoval(8)
    ab = av.abstract(inp_i, inp_q)

    rl = []
    for i, q in zip(inp_i, inp_q):
        rl.append(av.main(i, q))
    # plt.plot(ab)
    # plt.plot(rl)
    # plt.show()
    l = len(inp_i)
    np.testing.assert_almost_equal(ab[:l], rl[:l])

# test()
