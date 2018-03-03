from pyha import Hardware


class Stream(Hardware):
    def __init__(self, data, valid, package_start, package_end):
        self.data = data
        self.valid = valid
        self.package_start = package_start
        self.package_end = package_end


def packetize(data):
    """ Turn 2D arrays into 1D lists of stream objects, each subarray is wrapped in start/end events """
    ret = []
    for packet in data:
        ret.append(Stream(packet[0], valid=True, package_start=True, package_end=False))
        for elem in packet[1:]:
            ret.append(Stream(elem, valid=True, package_start=False, package_end=False))
        ret[-1].package_end = True

    return ret


def unpacketize(list_data):
    ret = []
    package = []
    for x in list_data:
        if not x.valid:
            continue

        if not x.package_start and not x.package_end:
            package.append(x.data)
        elif not x.package_start and x.package_end:
            package.append(x.data)
            ret.append(package)
            package = []
        elif x.package_start and not x.package_end:
            package = [x.data]
        elif x.package_start and x.package_end:
            package = []
            ret.append(x.data)

    return ret
