from contextlib import AbstractContextManager


class ContextManagerRefCounted(AbstractContextManager):
    def __init__(self):
        self.enabled = 0

    def __enter__(self):
        self.enabled += 1

    def __exit__(self, type, value, traceback):
        self.enabled -= 1


class RegisterBehaviour:
    """ This controls the 'implicit next' feature i.e. the hardware register behaviour """
    _enable = ContextManagerRefCounted()
    _force_disable = ContextManagerRefCounted()

    @staticmethod
    def enable():
        return RegisterBehaviour._enable

    @staticmethod
    def force_disable():
        return RegisterBehaviour._force_disable

    @staticmethod
    def is_enabled():
        return False if RegisterBehaviour._force_disable.enabled else RegisterBehaviour._enable.enabled

    @staticmethod
    def is_force_disabled():
        return RegisterBehaviour._force_disable.enabled

class AutoResize:
    """ Controls if assignments to Sfix registers should be resized """
    _enable = ContextManagerRefCounted()
    _force_disable = ContextManagerRefCounted()



    @property
    def enabled(self):
        return False if RegisterBehaviour._force_disable.enabled else RegisterBehaviour._enable.enabled


