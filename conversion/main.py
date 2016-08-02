from redbaron import RedBaron, ClassNode


def convert_classnode(node: ClassNode):
    assert type(node) == ClassNode
    pass




path = '/home/gaspar/git/hwpy/components/register/model/hw_model.py'
file_content = open(path).read()

red = RedBaron(file_content)

cls = red('classnode')

ret = convert_classnode(cls[0])

pass