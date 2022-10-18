	
`timescale 1ns/1ps
`default_nettype none
/*
  Making 4 different inputs is annoying, so I use python:
  print(", ".join([f"in{i:02}" for i in range(4)]))
  The solutions will include comments for where I use python-generated HDL.
*/

module mux8(
  in00, in01, in02, in03, 
  in04, in05, in06, in07, 
  select, out
);

	//parameter definitions
	parameter N = 1;

	//port definitions
  // python: print(", ".join([f"in{i:02}" for i in range(4)]))
	input  wire [(N-1):0] in00, in01, in02, in03, in04, in05, in06, in07;
	input  wire [2:0] select;
	output logic [(N-1):0] out;

  logic [(N-1):0] in;

logic [(N-1):0] intm_out0, intm_out1;

mux4 mux4_0(
  .in00(in00), 
  .in01(in01), 
  .in02(in02), 
  .in03(in03), 
  .select(select[1:0]),
  .out(intm_out0)
);
mux4 mux4_1(
  .in00(in04), 
  .in01(in05), 
  .in02(in06), 
  .in03(in07), 
  .select(select[1:0]),
  .out(intm_out1)
);

always_comb begin
  out[(N-1):0] = select[2] ? intm_out1 : intm_out0;
end


  //generate
  //  genvar i;
  //  for(i = 0; i < N; i++) begin
  //    out[i] = select ? in[i];
  //  end
  //endgenerate

endmodule
