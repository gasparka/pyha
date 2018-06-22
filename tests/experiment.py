from pyha.common.util import SignalTapParser, to_twoscomplement, to_signed_int

tap = SignalTapParser('debug.csv')

l = [x[1:] for x in tap.trans_data[1][1:]]
ll = [to_signed_int(int(x, 2), 12) for x in l]

r = [x[1:] for x in tap.trans_data[15][1:]]
rr = [to_signed_int(int(x, 2), 12) for x in r]
print(tap)