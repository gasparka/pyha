import glob
import inspect
import logging
import tempfile
import textwrap
import time
from pathlib import Path
from typing import List
from unittest.mock import MagicMock, patch
import os, shutil

import pyha
from pyha.common.context_managers import ContextManagerRefCounted
from pyha.common.core import PyhaFunc, Hardware
from pyha.common.util import tabber
from pyha.conversion.type_transforms import VHDLModule, VHDLList, init_vhdl_type
from pyha.conversion.redbaron_transforms import convert, file_header
from pyha.conversion.top_generator import TopGenerator

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger('conversion')


class Converter:
    def __init__(self, model, output_dir=None):
        self.model = model

        if output_dir is None or 'TRAVIS' in os.environ:
            self.output_dir = tempfile.TemporaryDirectory().name
        else:
            self.output_dir = str(Path(output_dir).expanduser())

        self.base_path = Path(self.output_dir).expanduser()
        self.src_path = self.base_path / 'src'
        self.quartus_path = self.base_path
        self.src_util_path = self.src_path / 'util'

    def to_vhdl(self):
        try:
            os.makedirs(self.output_dir)
        except:
            pass

        # clear contents
        files = glob.glob(self.output_dir + '/**/*')
        for f in files:
            try:
                os.remove(f)
            except:
                pass

        if not self.quartus_path.exists():
            os.makedirs(self.quartus_path)

        if not self.src_util_path.exists():
            os.makedirs(self.src_util_path)

        start = time.time()
        self.conv = RecursiveConverter(self.model)
        self.vhdl_sources = self.get_conversion_sources()
        end = time.time()
        logger.info(f'Took {end-start:.2f} seconds')
        return self

    def get_vhdl_sources_relative(self):
        return ['.' + str(path)[len(str(self.base_path)):] for path in self.vhdl_sources]

    def get_top_module_outputs(self):
        return self.conv.outputs

    def get_conversion_sources(self):
        # NB! order of files added to src matters!
        sim_inc = Path(pyha.__path__[0] + '/simulation/sim_include')
        shutil.copyfile(sim_inc / 'complex.vhdl', self.src_util_path / 'complex.vhdl')
        src = [self.src_util_path / 'complex.vhdl']

        # copy pyha_util to src dir
        shutil.copyfile(sim_inc / 'pyha_util.vhdl', self.src_util_path / 'pyha_util.vhdl')
        src += [self.src_util_path / 'pyha_util.vhdl']

        # write typedefs file
        src += [self.src_util_path / 'typedefs.vhdl']
        with src[-1].open('w') as f:
            f.write(self.conv.build_typedefs_package())

        # add all conversion files as src
        src += self.conv.write_vhdl_files(self.src_path)

        shutil.copyfile(sim_inc / 'fixed_pkg_c.vhdl', self.src_util_path / 'fixed_pkg_c.vhdl')
        shutil.copyfile(sim_inc / 'fixed_float_types_c.vhdl', self.src_util_path / 'fixed_float_types_c.vhdl')
        # src += [self.src_util_path / 'fixed_pkg_c.vhdl', self.src_util_path / 'fixed_float_types_c.vhdl']

        # copy cocotb simulation top file
        coco_py = pyha.__path__[0] + '/simulation/sim_include/cocotb_simulation_top.py'
        shutil.copyfile(coco_py, str(self.base_path / Path(coco_py).name))

        # copy cocotb makefile
        coco_py = pyha.__path__[0] + '/simulation/sim_include/Makefile'
        shutil.copyfile(coco_py, str(self.base_path / Path(coco_py).name))
        return src


def get_objects_rednode(obj):
    """
    Returns the RedBaron node for the class instance.
    This mocks the inspect module to improve the code search resolution (in general inspect finds all the classes from file that match the name and just returns the first)

    """
    from redbaron import RedBaron
    # walk til the first 'locals'
    # Example __qualname__: 'TestClassNodeConv.test_get_datamodel.<locals>.T'
    parent = inspect.getmodule(obj)
    for name in obj.__class__.__qualname__.split('.'):
        if name == '<locals>':
            break
        parent = getattr(parent, name)

    try:
        # try to find the source code with traditional means by using inspect, this may faile as it requires class to be defined in a file (not true fro REPL or Notebook)
        # if fails use IPYTHON history
        try:
            parent_code = inspect.getsourcelines(parent)[0]

            # monkeypatch the inspect module to use 'parent code' as input for searching the class code (else it searches full file)
            with patch('inspect.linecache.getlines', MagicMock(return_value=parent_code)):
                source = textwrap.dedent(inspect.getsource(obj.__class__))

            red_list = RedBaron(source)
            return red_list[0]

        except TypeError:
            # try finding the class from local IPYTHON input history
            from IPython import get_ipython
            ipython = get_ipython()
            ipython.run_cell_magic("capture", "out_var", "%history")
            out_var = str(ipython.ev('out_var'))

            # filter up to the last occurance of class def
            import re
            lines = str(out_var).splitlines()
            pat = re.compile(r'^(\s*)class\s*' + obj.__class__.__name__ + r'\b')

            last_match = -1
            for i in range(len(lines)):
                match = pat.match(lines[i])
                if match:
                    last_match = i

            if last_match == -1:
                raise Exception('Class was not found at all...')
            out_var = '\n'.join(lines[last_match:])

            with tempfile.NamedTemporaryFile(mode='w+') as temp:
                temp.write(out_var)
                temp.flush()
                with patch('inspect.getfile', MagicMock(return_value=temp.name)):
                    source = textwrap.dedent(inspect.getsource(obj.__class__))
                    red_list = RedBaron(source)
                    logger.warning(f'Found "{obj.__class__.__name__}" source from IPython history!')
                    return red_list[0]
    except:
        # This is due to the Inspect needing to open a file...
        # could be a bit relaxed with https://github.com/uqfoundation/dill/issues?utf8=%E2%9C%93&q=getsource, but this only works in regular REPL, not Ipython nor Notebook...
        raise Exception(f'Could not fetch "{obj.__class__}" source code (also tried loading from IPython history).')


def get_conversion(obj):
    red_node = get_objects_rednode(obj)
    conv = convert(red_node, obj)
    return conv


class RecursiveConverter:
    converted_modules = {}
    typedefs = [] # will be used to build typedefs package (all new types in the design)
    in_progress = ContextManagerRefCounted()

    @classmethod
    def is_compatible_with_converted_module(cls, module):
        for name, converted_module in cls.converted_modules.items():
            if module._pyha_type_is_compatible(converted_module[0]):
                return name
        return False

    @classmethod
    def get_module_converted_name(cls, module):
        name = cls.is_compatible_with_converted_module(module)
        if not name:
            return '{}_{}'.format(type(module.current).__name__, len(cls.converted_modules))
        return name

    def __init__(self, obj, datamodel=None):
        """ Convert object and all childs to VHDL """
        with RecursiveConverter.in_progress:
            self.obj = obj
            self.class_name = obj.__class__.__name__
            self.datamodel = datamodel
            self.is_root = datamodel is None
            if self.is_root:
                RecursiveConverter.converted_modules = {}
                RecursiveConverter.typedefs = []
                self.datamodel = VHDLModule('-', obj)

            # recursively convert all child modules
            self.childs = []

            def conv(self, node):
                if isinstance(node, VHDLList):
                    if node.elements_compatible_typed:
                        if isinstance(node.elems[0], VHDLModule):
                            if self.is_compatible_with_converted_module(node.elems[0]):
                                return
                            self.childs.append(RecursiveConverter(node.elems[0].current, node.elems[0]))

                    else:
                        # dynamic list..need to convert all modules
                        for x in node.elems:
                            if isinstance(x, VHDLModule):
                                if self.is_compatible_with_converted_module(x):
                                    return
                                self.childs.append(RecursiveConverter(x.current, x))
                elif isinstance(node, VHDLModule):
                    if self.is_compatible_with_converted_module(node):
                        return
                    self.childs.append(RecursiveConverter(node.current, node))

            if self.is_root:
                logger.info(f'Creating top.vhd ...')
                self.top_vhdl = TopGenerator(obj)

                # maybe some input/output is a convertible module?
                for node in self.inputs:
                    conv(self, node)

                for node in self.outputs:
                    conv(self, node)

            # iterate all functions and discover local variables that may need to be converted
            for x in self.obj.__dict__.values():
                if isinstance(x, PyhaFunc):
                    for key, val in x.get_local_types().items():
                        if isinstance(val, Hardware):
                            node = init_vhdl_type(key, val)
                            conv(self, node)

            # convert instance elements before the instance itself, recursive
            for node in self.datamodel.elems:
                conv(self, node)

            self.red_node = get_objects_rednode(obj)
            logger.info(f'{self.class_name} to VHDL ...')
            self.conv = convert(self.red_node, obj)  # actual conversion happens here

            self.vhdl_conversion = str(self.conv)
            RecursiveConverter.converted_modules[self.get_module_converted_name(self.datamodel)] = (self.datamodel, self.vhdl_conversion)
            RecursiveConverter.typedefs.extend(self.conv.build_typedefs())

    @property
    def inputs(self) -> List[object]:
        return self.top_vhdl.get_object_inputs()

    @property
    def outputs(self) -> List[object]:
        return self.top_vhdl.get_object_return()

    def write_vhdl_files(self, base_dir: Path) -> List[Path]:
        paths = []
        for name, value in self.converted_modules.items():
            paths.append(base_dir / '{}.vhd'.format(name))
            with paths[-1].open('w') as f:
                f.write(value[1]) # [1] is vhdl_conversion

        # add top_generator file
        paths.append(base_dir / 'top.vhd')
        with paths[-1].open('w') as f:
            f.write(self.top_vhdl.make())

        return paths

    def build_typedefs_package(self):
        template = textwrap.dedent("""\
            {FILE_HEADER}
            library ieee;
                use ieee.std_logic_1164.all;
                use ieee.numeric_std.all;
                use ieee.fixed_float_types.all;
                use ieee.fixed_pkg.all;
                use ieee.math_real.all;
                
            library work;
                use work.complex_pkg.all;
                use work.PyhaUtil.all;
                use work.all;

            package Typedefs is
            {TYPES}
            end package;
            """)
        self.typedefs = list(dict.fromkeys(self.typedefs))  # remove duplicates

        return template.format(FILE_HEADER=file_header(),
                               TYPES=tabber('\n'.join(self.typedefs)))
