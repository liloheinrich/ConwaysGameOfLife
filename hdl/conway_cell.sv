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

	// turns out state_0 isn't the input state, but rather the original starting state. 
	// state_q is both an input and an output; we are given the previous state_q and update it to be the current state_q
	state_d = (~ state_q & three_neighbors) | (state_q & two_or_three_neighbors);
end

always_ff @(posedge clk) begin : delay
	// reset should have priority generally, and be able to reset the circuit whether ena = 1 or not. 
	// but this is a design decision that is sort of up to us. whatever makes the tests pass.
	// also we are not allowed to use if-else statements in this assignent, use ternary a?b:c instead.
	state_q <= rst ? state_0 : (ena & state_d);
end 

endmodule