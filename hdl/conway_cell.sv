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

logic [3:0] sum;
eight_input_adder eight_input_adder_inst (.neighbors(neighbors), .sum(sum));

logic three_neighbors;
logic two_neighbors;
logic two_or_three_neighbors;

equality_comparator two_neighbors_comparator (.a(sum), .b(4'b0010), .out(two_neighbors));
equality_comparator three_neighbors_comparator (.a(sum), .b(4'b0011), .out(three_neighbors));

always_comb begin
	two_or_three_neighbors = three_neighbors | two_neighbors;

	//$display ("sum = %4b", sum);
	//$display ("three_neighbors = %1b", three_neighbors);
	//$display ("two_neighbors = %1b", two_neighbors);
	//$display ("two_or_three_neighbors = %1b", two_or_three_neighbors);
	//$display ("");

	state_d = (~ state_0 & three_neighbors) | (state_0 & two_or_three_neighbors);

	state_q = state_d;
end

//always_ff @(posedge clk) begin
//	state_q <= state_d;
//end 

endmodule