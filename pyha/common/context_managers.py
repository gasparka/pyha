""" This file exsists mainly because i had troubles with circular imports """
import sys


PYHA_DISABLE_PROFILE_HACKS = False


class ContextManagerRefCounted:
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
    """ This controls the sfix automatic resize feature """
    _enable = ContextManagerRefCounted()
    _force_disable = ContextManagerRefCounted()

    @staticmethod
    def enable():
        return AutoResize._enable

    @staticmethod
    def force_disable():
        return AutoResize._force_disable

    @staticmethod
    def is_enabled():
        return False if AutoResize._force_disable.enabled else AutoResize._enable.enabled


class SimulationRunning:
    """ Indicates ongoing simulation, this is used to mark Hardware objects that are created as 'locals',
    for locals the register and sfix autoresize effects are disabled."""
    _enable = ContextManagerRefCounted()

    @staticmethod
    def enable():
        return SimulationRunning._enable

    @staticmethod
    def is_enabled():
        return SimulationRunning._enable.enabled


class SimulationPath:
    def __init__(self):
        self.fifo = []

    def __enter__(self):
        pass

    def __call__(self, name):
        self.fifo.append(name)
        return self

    def __exit__(self, type, value, traceback):
        self.fifo.pop()

    def __str__(self):
        return '-'.join(x for x in self.fifo)

SimPath = SimulationPath()