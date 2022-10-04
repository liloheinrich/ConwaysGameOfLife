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
eight_input_adder eight_input_ADDER (.neighbors(neighbors), .sum(sum));

logic more_than_three_neighbors;
logic exactly_three_neighbors;
logic two_or_three_neighbors;
always_comb begin
	more_than_three_neighbors = sum[3] | sum[2];
	exactly_three_neighbors = ~ more_than_three_neighbors & sum[1] & sum[0];
	two_or_three_neighbors = ~ more_than_three_neighbors & sum[1];

	state_d = (~ state_0 & exactly_three_neighbors) | (state_0 & two_or_three_neighbors);

	state_q = clk & state_d;
	// didn't properly deal with state_q or rst or clk or ena etc...
end

endmodule