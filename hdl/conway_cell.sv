`default_nettype none
`timescale 1ns/1ps

module conway_cell(clk, rst, ena, state_0, state_d, state_q, neighbors);
input wire clk;
input wire rst;
input wire ena;

input wire state_0;
output logic state_d;
output logic state_q;

input wire [7:0] neighbors;



logic [7:0] empty;
logic no_carry;
//logic [7:0] output_sum; 
logic output_sum; 
logic output_carry;

parameter N = 8;

adder_1 adder_1_obj(
						.a(0), 
						.b(1), 
						.c_in(0), 
						.sum(output_sum), 
						.c_out(output_carry)
						);


initial begin
$dumpfile("test_conway_cell.fst");
$dumpvars(0, adder_1_obj);

$display("adder_1_obj.a adder_1_obj.b | output_sum output_carry");
  #1 $display("%1b %1b %1b", adder_1_obj.a, adder_1_obj.b, output_sum, output_carry);
$finish;    

end


endmodule