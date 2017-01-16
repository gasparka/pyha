import inspect
import textwrap
from pathlib import Path
from typing import List

from redbaron import RedBaron

from pyha.common.hwsim import HW
from pyha.common.util import get_iterable
from pyha.conversion.converter import convert
from pyha.conversion.coupling import get_instance_vhdl_name, VHDLType
from pyha.conversion.extract_datamodel import DataModel
from pyha.conversion.top_generator import TopGenerator


def get_objects_rednode(obj):
    source_path = inspect.getsourcefile(type(obj))
    source = open(source_path).read()
    red_list = RedBaron(source)('class', name=obj.__class__.__name__)
    if len(red_list) != 1:
        raise MultipleNodesError('Found {} definitions of "{}" class'.
                                 format(len(red_list), obj.__class__.__name__))

    return red_list[0]


def get_conversion_datamodel(obj):
    red_node = get_objects_rednode(obj)
    datamodel = DataModel(obj)
    conv = convert(red_node, caller=None, datamodel=datamodel)
    return conv, datamodel


def get_conversion(obj):
    conv, _ = get_conversion_datamodel(obj)
    return conv


class MultipleNodesError(Exception):
    pass


class Conversion:
    """
    input: stimulated object
    outputs:
        *comonent vhdl files
        *top file
        *top input types
        *top output types
    """
    # collect all complex types in the design
    complex_types = []
    def __init__(self, obj, is_child=False):

        self.is_child = is_child
        self.obj = obj
        self.class_name = obj.__class__.__name__
        self.conv, self.datamodel = get_conversion_datamodel(obj)

        self.vhdl_conversion = str(self.conv)
        if not is_child:
            self.top_vhdl = TopGenerator(obj)
            Conversion.complex_types = []
        Conversion.complex_types.append(VHDLType.get_complex_vars())

        # recursively convert all child modules
        self.childs = []
        for x in self.datamodel.self_data.values():
            if isinstance(x, HW):
                self.childs.append(Conversion(x, is_child=True))
            elif isinstance(x, list) and isinstance(x[0], HW):
                self.childs.append(Conversion(x[0], is_child=True))  # in case of list of submodules

    @property
    def inputs(self) -> List[object]:
        return self.top_vhdl.get_object_inputs()

    @property
    def outputs(self) -> List[object]:
        return self.top_vhdl.get_object_return()

    def write_vhdl_files(self, base_dir: Path) -> List[Path]:

        paths = []
        for x in self.childs:
            paths.extend(x.write_vhdl_files(base_dir))  # recusion here

        # paths.append(base_dir / '{}.vhd'.format(self.class_name))
        fname = get_instance_vhdl_name(self.obj)
        paths.append(base_dir / '{}.vhd'.format(fname))
        with paths[-1].open('w') as f:
            f.write(str(self.vhdl_conversion))

        # add top_generator file
        if not self.is_child:
            paths.append(base_dir / 'top.vhd')
            with paths[-1].open('w') as f:
                f.write(self.top_vhdl.make())

            paths.insert(0, base_dir / 'complex_types.vhd')
            with paths[0].open('w') as f:
                f.write(self.make_vhdl_complex_types())

        return paths


        # def get_objects_source_path(self, obj) -> str:
        #     return inspect.getsourcefile(type(obj))

    def make_vhdl_complex_types(self):
        template = textwrap.dedent("""\
            library ieee;
                use ieee.fixed_pkg.all;

            package ComplexTypes is
            {TYPES}
            end package;

            package body ComplexTypes is
            {FUNCTIONS}
            end package body;
            """)

        types = []
        functions = []
        for x in self.complex_types:
            for xx in get_iterable(x):
                new_type = xx.vhdl_type_define()
                new_function = xx.vhdl_init_function()
                if new_type not in types:
                    types.append(new_type)
                    functions.append(new_function)

        return template.format(TYPES='\n'.join(x for x in types),
                               FUNCTIONS='\n'.join(x for x in functions))
