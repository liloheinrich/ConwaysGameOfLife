`timescale 1ns/1ps
`default_nettype none
/*
  a 1 bit addder that we can daisy chain for 
  ripple carry adders
*/

module adder_1(a, b, c_in, sum, c_out);

input wire a, b, c_in;
output logic sum, c_out;

logic sum0;
logic sum1;
logic carry0;
logic carry1;

always_comb begin
  sum0 = a ^ b;
  sum = sum0 ^ c_in;
  carry0 = a & b;
  carry1 = sum0 & c_in;
  c_out = carry1 | carry0; 

end

endmodule