class ClassConv:
    init_prefix = 'init_reset'

    def __init__(self, obj, ref_node: ClassNode):
        self.name = NameNoneConv(None, None, explicit_name=obj.__class__.__name__)
        # logger.info('Converting class: {}'.format(self.name))

        self.ref_node = ref_node
        self.obj = obj

        self.registers = self.collect_self_t()
        self.functions = self.convert_functions()

    def collect_self_t(self):
        regs = []
        for key, val in self.obj.__dict__.items():
            if isinstance(val, Sfix):
                name = NameNoneConv(self, red_node=None, explicit_name=key)
                type = 'sfixed({} downto {})'.format(val.left, val.right)
                regs.append('{}: {};'.format(name, type))
            elif key in ['next']:
                continue
            else:
                raise Exception()

        return regs

    def convert_functions(self):
        # rst_func = self.make_reset_function()
        # funcs = [rst_func]
        funcs = []
        for func in self.ref_node('def'):
            if func.name == '__call__':
                funcs += [FuncConv(self, func)]

        return funcs

    def self_t_str(self):
        slots = {}
        slots['NAME'] = 'self_t'
        slots['MEMBERS'] = '\n'.join(tabber(x) for x in self.registers)
        return RECORD_TEMPLATE.format(**slots)

    def make_reset_function(self):
        tmpl = []
        for key, val in self.obj.__dict__.items():
            if isinstance(val, Sfix):
                value = 'to_sfixed({}, {}, {})'.format(val, val.left, val.right)
                tmpl += ['self.{} = {}'.format(key, value)]
            elif key in ['next']:
                continue
            else:
                raise Exception()

        slots = {}
        slots['NAME'] = 'reset'
        slots['ARGUMENTS'] = 'self'
        slots['BODY'] = '\n'.join(tabber(x) for x in tmpl)
        pyfun = RED_DEF_TEMPLATE.format(**slots)
        red = RedBaron(pyfun)
        return FuncConv(self, red.defnode)

    def __str__(self):
        slots = dict()
        slots['NAME'] = self.name
        slots['SELF_T'] = tabber(self.self_t_str())
        slots['HEADER'] = '\n'.join(tabber(x.get_prototype()) for x in self.functions)
        slots['BODY'] = '\n\n'.join(tabber(str(x)) for x in self.functions) + '\n'
        return PACKAGE_TEMPLATE.format(**slots)


def main(root_obj):
    assert isinstance(root_obj, HW)  # must derive from HW

    name = root_obj.__class__.__name__
    source_path = inspect.getsourcefile(type(r))
    content = open(source_path).read()
    red = RedBaron(content)

    cls = red('classnode')
    assert len(cls) == 1  # more than 1 class in file
    cls = cls[0]

    cls = ClassConv(root_obj, cls)
    print(cls)
    with open('converted.vhd', 'w') as f:
        print(cls, file=f)

    # slots = dict()
    # slots['NAME'] = name
    # slots['HEADER'] = 'head'
    # slots['BODY'] = 'body'
    # print(PACKAGE_TEMPLATE.format(**slots))

    pass


    # r = Register()
    # main(r)
    # path = '/home/gaspar/git/hwpy/components/register/model/hw_model.py'
    # file_content = open(path).read()
    #
    # red = RedBaron(file_content)
    #
    # cls = red('classnode')
    #
    # ret = convert_classnode(cls[0])
