import numpy as np
from pyha.common.sfix import Sfix


class Testing(object):
    def __init__(self, request, model, hw_model, coco_sim):

        self.coco_sim = coco_sim
        self.request = request
        self.hw_model = hw_model
        self.model = model

        self.original_input = []
        self.pure_output = []

    def __call__(self, *args, **kwargs):

        if self.request.param == 'MODEL':
            out = self.model(*args, **kwargs)
            self.pure_output = np.copy(out)
            return np.transpose(out)

        # flush pipeline
        args = self.add_dummy_pipeline_samples(args)

        # fixed conversion
        for i, (values, type) in enumerate(zip(args, [Sfix(left=0, right=-27)] * 1)):
            args[i] = [Sfix(x, type.left, type.right) for x in values]

        trans = np.transpose(args)

        if self.request.param == 'HW-MODEL':
            out = [self.hw_model(*x, **kwargs) for x in trans]
        elif self.request.param in ('HW-RTL', 'HW-GATE'):
            out = self.coco_sim.run(trans)
        self.pure_output = np.copy(out)

        out = out[self.hw_model.get_delay():]
        out = np.transpose(out)
        out = out.astype(float)
        return out

    def output_type_conversion(self):
        pass

    def add_dummy_pipeline_samples(self, args):
        if len(np.array(args).shape) == 1:
            args = [[x] for x in args]
        args = [np.append(x, [0.0] * self.hw_model.get_delay()) for x in args]
        return args
