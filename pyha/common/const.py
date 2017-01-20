class Const:
    def __init__(self, x):
        self.x = x

    def __eq__(self, other):
        if type(other) is type(self):
            return self.__dict__ == other.__dict__
        return False