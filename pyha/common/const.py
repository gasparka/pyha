class Const:
    def __init__(self, value):
        self.value = value

    # satesfy linters
    def __len__(self):
        assert 0

    def __getitem__(self, item):
        assert 0