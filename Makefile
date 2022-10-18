# -Wall turns on all warnings
# -g2012 selects the 2012 version of iVerilog
IVERILOG=iverilog -g2012 -Wall -y ./hdl -I ./hdl
IVERILOG_SIM_ARGS= -y ./tests -I ./tests
VVP=vvp
VVP_POST=-fst
VIVADO=vivado -mode batch -source


CONWAY_SRCS=hdl/conway_cell.sv hdl/adder_1.sv hdl/adder_n.sv hdl/eight_input_adder.sv hdl/equality_comparator.sv
DECODER_SRCS=hdl/decoder*.sv
LED_ARRAY_SRCS=${DECODER_SRCS} hdl/led_array_driver.sv
MAIN_SRCS=${CONWAY_SRCS} ${LED_ARRAY_SRCS} hdl/main.sv 

# Look up .PHONY rules for Makefiles
.PHONY: clean submission remove_solutions

test_decoders: tests/test_decoders.sv ${DECODER_SRCS}
	${IVERILOG} $^ -o test_decoders.bin && ${VVP} test_decoders.bin ${VVP_POST}

test_decoder_1_to_2: tests/test_decoder_1_to_2.sv ${DECODER_SRCS}
	${IVERILOG} $^ -o test_decoder_1_to_2.bin && ${VVP} test_decoder_1_to_2.bin ${VVP_POST}

test_decoder_2_to_4: tests/test_decoder_2_to_4.sv ${DECODER_SRCS}
	${IVERILOG} $^ -o test_decoder_2_to_4.bin && ${VVP} test_decoder_2_to_4.bin ${VVP_POST}

test_decoder_3_to_8: tests/test_decoder_3_to_8.sv ${DECODER_SRCS}
	${IVERILOG} $^ -o test_decoder_3_to_8.bin && ${VVP} test_decoder_3_to_8.bin ${VVP_POST}

test_adder_1: tests/test_adder_1.sv ${CONWAY_SRCS}
	${IVERILOG} $^ -o test_adder_1.bin && ${VVP} test_adder_1.bin ${VVP_POST}

test_adder_n: tests/test_adder_n.sv ${CONWAY_SRCS}
	${IVERILOG} $^ -o test_adder_n.bin && ${VVP} test_adder_n.bin ${VVP_POST}

test_eight_input_adder: tests/test_eight_input_adder.sv ${CONWAY_SRCS}
	${IVERILOG} $^ -o test_eight_input_adder.bin && ${VVP} test_eight_input_adder.bin ${VVP_POST}

test_comparator: tests/test_comparator.sv hdl/comparator.sv 
	${IVERILOG} $^ -o test_comparator.bin && ${VVP} test_comparator.bin ${VVP_POST}

test_equality_comparator: tests/test_equality_comparator.sv hdl/equality_comparator.sv 
	${IVERILOG} $^ -o test_equality_comparator.bin && ${VVP} test_equality_comparator.bin ${VVP_POST}

test_conway_cell: tests/test_conway_cell.sv ${CONWAY_SRCS}
	${IVERILOG} $^ -o test_conway_cell.bin && ${VVP} test_conway_cell.bin ${VVP_POST}

test_conway_cell_simple: tests/test_conway_cell_simple.sv ${CONWAY_SRCS}
	${IVERILOG} $^ -o test_conway_cell_simple.bin && ${VVP} test_conway_cell_simple.bin ${VVP_POST}

test_led_array_driver: tests/test_led_array_driver.sv tests/led_array_model.sv ${LED_ARRAY_SRCS}
	${IVERILOG} $^ -o test_led_array_driver.bin && ${VVP} test_led_array_driver.bin ${VVP_POST}

test_main: tests/test_main.sv tests/led_array_model.sv ${MAIN_SRCS}
	@echo "This might take a while, we're testing a lot of clock cycles!"
	${IVERILOG} $^ -o test_main.bin && ${VVP} test_main.bin ${VVP_POST}

main.bit: $(MAIN_SRCS)
	@echo "########################################"
	@echo "#### Building FPGA bitstream        ####"
	@echo "########################################"
	${VIVADO} build.tcl

program_fpga_vivado: main.bit
	@echo "########################################"
	@echo "#### Programming FPGA (Vivado)      ####"
	@echo "########################################"
	${VIVADO} program.tcl

program_fpga_digilent: main.bit
	@echo "########################################"
	@echo "#### Programming FPGA (Digilent)    ####"
	@echo "########################################"
	djtgcfg enum
	djtgcfg prog -d CmodA7 -i 0 -f main.bit


# Call this to clean up all your generated files
clean:
	rm -f *.bin *.vcd *.fst vivado*.log *.jou vivado*.str *.log *.checkpoint *.bit *.html *.xml
	rm -rf .Xil

# Call this to generate your submission zip file.
submission:
	zip submission.zip Makefile *.sv README.md docs/* *.tcl *.xdc *.fst
