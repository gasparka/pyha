import inspect
import logging
import tempfile
import textwrap
from pathlib import Path
from typing import List
from unittest.mock import MagicMock, patch

from redbaron import RedBaron

from pyha.common.context_managers import ContextManagerRefCounted
from pyha.common.core import PyhaFunc, Hardware
from pyha.common.util import tabber
from pyha.conversion.python_types_vhdl import VHDLModule, VHDLList, init_vhdl_type, TypeAppendHack
from pyha.conversion.redbaron_mods import convert, file_header
from pyha.conversion.top_generator import TopGenerator

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger('conversion')


def convertToVHDL(simulated_object, output_dir):
    from pyha.simulation.vhdl_simulation import VHDLSimulation
    return VHDLSimulation(Path(output_dir), simulated_object, 'GATE', make_files_only=True)


def get_objects_rednode(obj):
    """
    Returns the RedBaron node for the class instance.
    This mocks the inspect module to improve the code search resolution (in general inspect finds all the classes from file that match the name and just returns the first)

    """

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


class Conversion:
    converted_names = []
    typedefs = []
    in_progress = ContextManagerRefCounted()

    def __init__(self, obj, datamodel=None):
        """ Recursively (if object has children 'Hardware' members) converts object to VHDL """
        with Conversion.in_progress:
            self.obj = obj
            self.class_name = obj.__class__.__name__
            self.datamodel = datamodel
            self.is_root = datamodel is None
            if self.is_root:
                Conversion.converted_names = []
                Conversion.typedefs = []
                self.datamodel = VHDLModule('-', obj)

            # recursively convert all child modules
            self.childs = []

            def conv(self, node):
                if isinstance(node, VHDLList):
                    if node.elements_compatible_typed:
                        if isinstance(node.elems[0], VHDLModule):
                            if node.elems[0]._pyha_module_name() in self.converted_names:
                                return
                            self.childs.append(Conversion(node.elems[0].current, node.elems[0]))

                    else:
                        # dynamic list..need to convert all modules
                        for x in node.elems:
                            if isinstance(x, VHDLModule):
                                if x._pyha_module_name() in self.converted_names:
                                    return
                                self.childs.append(Conversion(x.current, x))
                elif isinstance(node, VHDLModule):
                    if node._pyha_module_name() in self.converted_names:
                        return
                    self.childs.append(Conversion(node.current, node))

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
            Conversion.converted_names += [self.datamodel._pyha_module_name()]
            Conversion.typedefs.extend(self.conv.build_typedefs())

    @property
    def inputs(self) -> List[object]:
        return self.top_vhdl.get_object_inputs()

    @property
    def outputs(self) -> List[object]:
        return self.top_vhdl.get_object_return()

    def write_vhdl_files(self, base_dir: Path) -> List[Path]:
        with Conversion.in_progress:
            paths = []
            for x in self.childs:
                paths.extend(x.write_vhdl_files(base_dir))  # recursion here

            paths.append(base_dir / '{}.vhd'.format(self.datamodel._pyha_module_name()))
            with paths[-1].open('w') as f:
                f.write(str(self.vhdl_conversion))

            # add top_generator file
            if self.is_root:
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
