import numpy as np

from pyha.common.fixed_point import Sfix, left_index, right_index
from pyha.common.fixed_point import resize
from pyha.common.hwsim import Hardware
from pyha.simulation.legacy import assert_sim_match


# integers into resize functions must be constant or quartus fails
# it fails to derive constantness from register values
class ResizeBoundNotConstant(Hardware):
    def __init__(self, window_len):
        self.window_len = window_len
        self.window_pow_const = int(np.log2(window_len))

        # registers
        self.out = Sfix()

    def main(self, x):
        self.next.out = resize(x,
                               left_index=self.window_pow_const + left_index(x),
                               right_index=right_index(x))
        return self.out


def test_bug():
    mov = ResizeBoundNotConstant(window_len=2)
    x = [0., 1., 2., 3., 4.]
    expected = [0., 0., 1., 2., 3.]
    assert_sim_match(mov, [Sfix(left=4, right=-18)], expected, x,
                     simulations=['PYHA', 'RTL', 'GATE'])



    # .PHONY: analyse
    #
    # # Compilation phase
    # analyse: $(VHDL_SOURCES) $(SIM_BUILD)
    # 	cd $(SIM_BUILD) && $(CMD) -a $(GHDL_OPTIONS) --work=$(RTL_LIBRARY) $(VHDL_SOURCES) && $(CMD) -e $(GHDL_OPTIONS) --ieee=synopsys --work=$(RTL_LIBRARY) $(TOPLEVEL)
    #
    # results.xml: analyse  $(COCOTB_LIBS) $(COCOTB_VPI_LIB)
    # 	cd $(SIM_BUILD); \
    # 	PYTHONPATH=$(LIB_DIR):$(SIM_ROOT):$(PWD):$(PYTHONPATH) LD_LIBRARY_PATH=$(LIB_DIR):$(LD_LIBRARY_PATH) MODULE=$(MODULE) \
    #         TESTCASE=$(TESTCASE) TOPLEVEL=$(TOPLEVEL) TOPLEVEL_LANG=$(TOPLEVEL_LANG) \
    # 	$(CMD) -r $(GHDL_OPTIONS) --ieee=synopsys $(TOPLEVEL) --vpi=$(LIB_DIR)/libvpi.$(LIB_EXT) $(SIM_ARGS)
    #
    # clean::
    # 	-@rm -rf $(SIM_BUILD)
    # endif
