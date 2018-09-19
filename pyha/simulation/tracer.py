import time
import numpy as np


class Tracer:
    traced_objects = []

    @staticmethod
    def is_enabled():
        return len(Tracer.traced_objects)

    def __init__(self, func, tracer_type, owner=None, label=None):
        self.label = label
        self.owner = owner
        self.tracer_type = tracer_type
        self.func = func

        self.input = []
        self.last_pyha_input = None
        self.output = []
        self.last_pyha_output = None
        self.return_time = None
        self.call_time = None
        if owner not in Tracer.traced_objects:
            Tracer.traced_objects.append(owner)

    def __call__(self, *args, **kwargs):
        if self.call_time is None:
            self.call_time = time.time()

        res = self.func(*args, **kwargs)

        if self.return_time is None:
            self.return_time = time.time()

        try:
            if self.tracer_type == 'model':
                self.input = np.array(args[0])
                self.output = np.array(res)
                self.return_time = time.time()
            elif self.tracer_type == 'main':
                if args[0].valid:
                    self.input.append(args[0].data._pyha_to_python_value())
                    self.last_pyha_input = args[0].data

                if res.valid:
                    self.output.append(res.data._pyha_to_python_value())
                    self.last_pyha_output = res.data
        except IndexError:
            pass
        return res

    @classmethod
    def get_sorted_traces(cls):
        class Tmp:
            def __init__(self, data_model, data_pyha, label, time):
                self.type = type
                self.data_model = data_model
                self.data_pyha = data_pyha[:len(data_model)]
                self.dir = dir
                self.time = time
                self.label = label

        tmp = []
        for x in cls.traced_objects:
            try:
                model = x.model
                main = x.main
                if not model.call_time or not main.call_time:
                    continue

                type_in = f'{len(main.last_pyha_input)} bits {"-" if main.last_pyha_input.signed else ""}[{main.last_pyha_input.left}:{main.last_pyha_input.right}]'
                type_out = f'{len(main.last_pyha_output)} bits {"-" if main.last_pyha_input.signed else ""}[{main.last_pyha_output.left}:{main.last_pyha_output.right}]'
                name_in = 'Input' if model.label == 'self' else f'In: {model.label}'
                name_out = 'Output' if model.label == 'self' else f'Out: {model.label}'
                tmp.append(Tmp(model.input, main.input, f'{name_in} | {type_in}', model.call_time))
                tmp.append(Tmp(model.output, main.output, f'{name_out} | {type_out}', model.return_time))
            except AttributeError as e:
                print(e)
                continue

        time_sorted = sorted(tmp, key=lambda x: x.time)

        # remove duplicate traces e.g. input of a block is same as previous output!
        tmp = [time_sorted[0]]  # always include first input
        for x in time_sorted:
            if not np.array_equal(x.data_model, tmp[-1].data_model) or not np.array_equal(x.data_pyha,
                                                                                          tmp[-1].data_pyha):
                tmp.append(x)

        ret = {x.label: {'MODEL': x.data_model, 'HARDWARE': x.data_pyha} for x in tmp}
        return ret
