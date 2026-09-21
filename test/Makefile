# Makefile
# See https://docs.cocotb.org/en/stable/quickstart.html for more info

# defaults
SIM ?= icarus
FST ?= -fst # Use more efficient FST format
TOPLEVEL_LANG ?= verilog
SRC_DIR = $(PWD)/../src

ifneq ($(COUNTER),)

# Direct digital_counter leaf (no Tiny Tapeout wrapper, no analog stub):
#   make COUNTER=1
SIM_BUILD		= sim_build/counter
VERILOG_SOURCES		+= $(SRC_DIR)/counter.v
VERILOG_SOURCES		+= $(PWD)/counter_tb.v
TOPLEVEL		= counter_tb
COCOTB_TEST_MODULES	= test_counter

else ifneq ($(GATES),yes)

# RTL simulation of the Tiny Tapeout top:
SIM_BUILD		= sim_build/rtl
PROJECT_SOURCES		= project.v counter.v pll_div_n.v pll_digital.v
VERILOG_SOURCES		+= $(addprefix $(SRC_DIR)/,$(PROJECT_SOURCES))
# Analog leaves are GDS blackboxes; use behavioral stubs for simulation.
VERILOG_SOURCES		+= $(PWD)/ring_oscillator_sim.v
VERILOG_SOURCES		+= $(PWD)/ring_oscillator_500mhz_sim.v
VERILOG_SOURCES		+= $(PWD)/chips_art_sim.v

else

# Gate level simulation:
SIM_BUILD		= sim_build/gl
COMPILE_ARGS		+= -DGL_TEST
COMPILE_ARGS		+= -DFUNCTIONAL
COMPILE_ARGS		+= -DSIM
COMPILE_ARGS		+= -DUSE_POWER_PINS
VERILOG_SOURCES		+= $(PDK_ROOT)/ihp-sg13g2/libs.ref/sg13g2_io/verilog/sg13g2_io.v
VERILOG_SOURCES		+= $(PDK_ROOT)/ihp-sg13g2/libs.ref/sg13g2_stdcell/verilog/sg13g2_stdcell.v

# this gets copied in by the GDS action workflow
VERILOG_SOURCES		+= $(PWD)/gate_level_netlist.v
VERILOG_SOURCES		+= $(PWD)/ring_oscillator_sim.v
VERILOG_SOURCES		+= $(PWD)/ring_oscillator_500mhz_sim.v
VERILOG_SOURCES		+= $(PWD)/chips_art_sim.v

endif

# Allow sharing configuration between design and testbench via `include`:
COMPILE_ARGS += -I$(SRC_DIR)

ifeq ($(COUNTER),)
# Include the Tiny Tapeout testbench sources:
VERILOG_SOURCES += $(PWD)/tb.v
TOPLEVEL = tb
COCOTB_TEST_MODULES = test
endif

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
