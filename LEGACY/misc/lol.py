from common.sfix import Sfix


class Counter():
    def __init__(self, step):
        self.step = Sfix(step, 0, -8)
        self.counter = Sfix(0, 0, -8)

    def run(self):
        self.counter = self.counter + self.step
        return self.counter


dut = Counter(0.1)

res = []
for _ in range(128):
    res.append(dut.run())

plt.plot(res)
