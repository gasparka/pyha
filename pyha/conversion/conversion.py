import inspect
import textwrap
from pathlib import Path
from typing import List
from unittest.mock import MagicMock, patch

from redbaron import RedBaron

from pyha.conversion.conversion_types import VHDLModule, VHDLList
from pyha.conversion.converter import convert
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

    def __init__(self, obj, datamodel=None):
        self.datamodel = datamodel
        self.is_root = datamodel is None
        if self.is_root:
            self.datamodel = VHDLModule('-', obj)

        self.obj = obj
        self.class_name = obj.__class__.__name__
        self.red_node = get_objects_rednode(obj)
        self.conv = convert(self.red_node, obj)

        self.vhdl_conversion = str(self.conv)
        self.converted_names += [self.datamodel._pyha_module_name()]
        if self.is_root:
            self.top_vhdl = TopGenerator(obj)

        # recursively convert all child modules
        self.childs = []

        for node in self.datamodel.elems:
            if isinstance(node, VHDLList) and isinstance(node.elems[0], VHDLModule):
                self.childs.append(Conversion(node.elems[0], node))
            elif isinstance(node, VHDLModule):
                if node._pyha_module_name() in self.converted_names:
                    continue
                self.childs.append(Conversion(node.current, node))
            else:
                continue

    @property
    def inputs(self) -> List[object]:
        return self.top_vhdl.get_object_inputs()

    @property
    def outputs(self) -> List[object]:
        return self.top_vhdl.get_object_return()

    def write_vhdl_files(self, base_dir: Path) -> List[Path]:

        # todo: makedirs
        paths = []
        for x in self.childs:
            paths.extend(x.write_vhdl_files(base_dir))  # recusion here

        # paths.append(base_dir / '{}.vhd'.format(self.class_name))
        mod = VHDLModule('-', self.obj)
        fname = mod._pyha_module_name()
        paths.append(base_dir / f'{fname}.vhd')
        with paths[-1].open('w') as f:
            f.write(str(self.vhdl_conversion))

        # add top_generator file
        if self.is_root:
            paths.append(base_dir / 'top.vhd')
            with paths[-1].open('w') as f:
                f.write(self.top_vhdl.make())

        return paths
