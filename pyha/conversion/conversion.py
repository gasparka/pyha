import inspect

from redbaron import RedBaron


class Conversion:
    """
    input: stimulated object
    outputs:
        *comonent vhdl files
        *top file
        *top input types
        *top output types
    """

    def __init__(self, main_obj):
        self.main_obj = main_obj
        self.main_red = self.get_objects_rednode(main_obj)

    def discover_child_entities(self):
        # TODO: future
        pass

    def get_objects_rednode(self, obj):
        source_path = self.get_objects_source_path(obj)
        source = open(source_path).read()
        red_list = RedBaron(source)('class', name=obj.__class__.__name__)
        assert len(red_list) == 1

        return red_list[0]

    def get_objects_source_path(self, obj):
        return inspect.getsourcefile(type(obj))
