from contextlib import suppress

import numpy as np

from common.sfix import Sfix


class Testing(object):
    def __init__(self, request, model, hw_model, coco_sim):

        self.coco_sim = coco_sim
        self.request = request
        self.hw_model = hw_model
        self.model = model

        self.original_input = []
        self.original_output = []

    def __call__(self, *args, **kwargs):

        # self.original_input = np.copy(args)
        if self.request.param == 'MODEL':
            # trans = np.transpose(args)
            # is_singe_call = len(trans.shape) == 1
            # if is_singe_call:
            #     trans = [trans]
            # outl = []
            # for x in trans:
            #     out = self.model(*x, **kwargs)
            #     outl.append(out)
            out = self.model(*args, **kwargs)

            self.original_output = np.copy(out)
            return np.transpose(out)

        elif self.request.param == 'HW-MODEL':
            with suppress(Exception):
                args = self.hw_model.test_adaptor(*args, **kwargs)
            # flush pipeline
            args = self.add_dummy_pipeline_samples(args)


            # fixed conversion
            for i, (values, type) in enumerate(zip(args, self.hw_model.input_sfix)):
                args[i] = [Sfix(x, type.left, type.right) for x in values]

            # Sfix.set_float_mode(True)
            trans = np.transpose(args)
            outl = []
            for x in trans:
                out = self.hw_model(*x, **kwargs)
                outl.append([float(x) for x in out])

            # self.original_output = np.copy(outl)

            # remove pipeline flush samples
            outl = outl[self.hw_model.delay:]
            return np.transpose(outl)


        elif self.request.param in ('HW-RTL', 'HW-GATE'):

            args = self.add_dummy_pipeline_samples(args)

            # fixed conversion
            for i, (values, type) in enumerate(zip(args, self.hw_model.input_sfix)):
                args[i] = [Sfix(x, type.left, type.right).fixed_value() for x in values]

            args = np.transpose(args)
            out = self.coco_sim.run(args)
            self.original_output = np.copy(out)

            out = out[self.hw_model.delay:]
            out = np.transpose(out)

            # convert fixed values to float
            out = out.astype(float)
            for i, (values, type) in enumerate(zip(out, self.hw_model.input_sfix)):
                out[i] = (values * 2 ** type.right)

            return out

    def add_dummy_pipeline_samples(self, args):
        if len(np.array(args).shape) == 1:
            args = [[x] for x in args]
        args = [np.append(x, [0.0] * self.hw_model.delay) for x in args]
        return args
