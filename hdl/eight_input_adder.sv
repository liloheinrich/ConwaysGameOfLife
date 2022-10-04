`timescale 1ns/1ps
`default_nettype none

module eight_input_adder(neighbors, sum);

input  wire [7:0] neighbors;
output logic [3:0] sum;

logic [3:0] a;
logic [3:0] b; 
logic c_in;
logic [7:0] c_out;
logic [4*8-1:0] intermediate_sum;
logic [3:0] empty;

always_comb begin
  c_in = 0;
  empty = 0000;
  sum = intermediate_sum[31:28]; // set the final sum here. gives warning but works still
end

generate
  // fencepost problem
  adder_n #(.N(4)) ADDER (
    .a(neighbors[0]),
    .b(empty),
    .c_in(c_in),
    .sum(intermediate_sum[3:0]),
    .c_out(c_out[0])
  );

  genvar i;
  for(i = 1; i < 8; i++) begin
    adder_n #(.N(4)) ADDER (
      .a(neighbors[i]),
      .b(intermediate_sum[4*(i)-1:4*(i-1)]),
      .c_in(c_in),
      .sum(intermediate_sum[4*(i+1)-1:4*(i)]),
      .c_out(c_out[i])
    );
  end
endgenerate

endmodule