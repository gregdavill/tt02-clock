PROJ = tt2_clock

PIN_DEF = icebreaker.pcf
DEVICE = up5k
PACKAGE = sg48


VERILOG_SRC = \
	bcd_counter.v \
	clock.v \
	output_sr.v \
	bcd_decoder.v \
	ctrl.v \
	mux_6_4b.v \
	rise_edge.v
VERILOG_SRC_DIR = ../rtl/
ADD_SRC := $(addprefix $(VERILOG_SRC_DIR), $(VERILOG_SRC))

prog: iceprog

include main.mk
