import inspect
import textwrap
from pathlib import Path
from typing import List
from unittest.mock import MagicMock, patch

from redbaron import RedBaron

from pyha.common.util import tabber
from pyha.conversion.python_types_vhdl import VHDLModule, VHDLList
from pyha.conversion.redbaron_mods import convert, file_header
from pyha.conversion.top_generator import TopGenerator


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

    # get sourcecode of the parent
    parent_code = inspect.getsourcelines(parent)[0]

    # monkeypatch the inspect module to use 'parent code' as input for searching the class code (else it searches full file)
    with patch('inspect.linecache.getlines', MagicMock(return_value=parent_code)):
        source = textwrap.dedent(inspect.getsource(obj.__class__))

    red_list = RedBaron(source)
    return red_list[0]


def get_conversion(obj):
    red_node = get_objects_rednode(obj)
    conv = convert(red_node, obj)
    return conv


class Conversion:
    converted_names = []
    typedefs = []
    in_progress = 0

    def __init__(self, obj, datamodel=None):
        """ Recursively (if object has children 'Hardware' members) converts object to VHDL """
        self.obj = obj
        self.class_name = obj.__class__.__name__
        Conversion.in_progress += 1
        self.datamodel = datamodel
        self.is_root = datamodel is None
        if self.is_root:
            Conversion.converted_names = []
            Conversion.typedefs = []
            self.datamodel = VHDLModule('-', obj)

        # recursively convert all child modules
        self.childs = []

        def conv(self, node):
            if isinstance(node, VHDLList) and isinstance(node.elems[0], VHDLModule):
                if node.elems[0]._pyha_module_name() in self.converted_names:
                    return
                self.childs.append(Conversion(node.elems[0].current, node.elems[0]))
            elif isinstance(node, VHDLModule):
                if node._pyha_module_name() in self.converted_names:
                    return
                self.childs.append(Conversion(node.current, node))

        if self.is_root:
            self.top_vhdl = TopGenerator(obj)

            # maybe some input/output is a convertable module?
            for node in self.inputs:
                conv(self, node)

            for node in self.outputs:
                conv(self, node)

        # convert instance elements before the instance itself, recursive
        for node in self.datamodel.elems:
            conv(self, node)

        self.red_node = get_objects_rednode(obj)
        self.conv = convert(self.red_node, obj) # actual conversion happens here

        self.vhdl_conversion = str(self.conv)
        Conversion.converted_names += [self.datamodel._pyha_module_name()]
        Conversion.typedefs.extend(self.conv.build_typedefs())
        Conversion.in_progress -= 1

    @property
    def inputs(self) -> List[object]:
        return self.top_vhdl.get_object_inputs()

    @property
    def outputs(self) -> List[object]:
        return self.top_vhdl.get_object_return()

    def write_vhdl_files(self, base_dir: Path) -> List[Path]:
        Conversion.in_progress += 1
        # todo: makedirs
        paths = []
        for x in self.childs:
            paths.extend(x.write_vhdl_files(base_dir))  # recusion here

        # paths.append(base_dir / '{}.vhd'.format(self.class_name))
        paths.append(base_dir / '{}.vhd'.format(self.datamodel._pyha_module_name()))
        with paths[-1].open('w') as f:
            f.write(str(self.vhdl_conversion))

        # add top_generator file
        if self.is_root:
            paths.append(base_dir / 'top.vhd')
            with paths[-1].open('w') as f:
                f.write(self.top_vhdl.make())

            paths.insert(0, base_dir / 'typedefs.vhd')
            with paths[0].open('w') as f:
                f.write(self.build_typedefs_package())

        Conversion.in_progress -= 1
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
                use work.PyhaUtil.all;
                use work.all;

            package Typedefs is
            {TYPES}
            end package;
            """)
        self.typedefs = list(dict.fromkeys(self.typedefs))  # remove duplicates
        return template.format(FILE_HEADER=file_header(),
                               TYPES=tabber('\n'.join(self.typedefs)))
