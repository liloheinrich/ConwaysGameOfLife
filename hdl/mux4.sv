	
`timescale 1ns/1ps
`default_nettype none
/*
  Making 4 different inputs is annoying, so I use python:
  print(", ".join([f"in{i:02}" for i in range(4)]))
  The solutions will include comments for where I use python-generated HDL.
*/

module mux4(
  in00, in01, in02, in03, 
  select, out
);

	//parameter definitions
	parameter N = 1;

	//port definitions
  // python: print(", ".join([f"in{i:02}" for i in range(4)]))
	input  wire [(N-1):0] in00, in01, in02, in03;
	input  wire [1:0] select;
	output logic [(N-1):0] out;

  logic [(N-1):0] in;

logic [(N-1):0] intm_out0, intm_out1;

always_comb begin
  intm_out0 = select[0] ? in01 : in00;
  intm_out1 = select[0] ? in03 : in02;
  out[(N-1):0] = select[1] ? intm_out1 : intm_out0;
end


  //generate
  //  genvar i;
  //  for(i = 0; i < N; i++) begin
  //    out[i] = select ? in[i];
  //  end
  //endgenerate

endmodule
