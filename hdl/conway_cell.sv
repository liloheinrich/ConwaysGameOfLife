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

// these equality comparators return one bit which signifies whether the sum of the neighbors is equal to 2 or to 3
equality_comparator two_neighbors_comparator (.a(sum), .b(4'b0010), .out(two_neighbors));
equality_comparator three_neighbors_comparator (.a(sum), .b(4'b0011), .out(three_neighbors));

always_comb begin
	two_or_three_neighbors = three_neighbors | two_neighbors;

	/* state_0 isn't the input state, but rather the original starting state. 
	   state_q is both an input and an output; we are given the previous 
	   state_q and update it to be the current state_q
	*/

	/* here, state_d is being set to follow the rules of Conway's game:
	    - if the cell is dead and has 3 neighbors, it revives. 
	    - if the cell is alive and has 2 or 3 neighbors, it survives. 
	    - in all other cases the cell dies.
	*/
	state_d = (~ state_q & three_neighbors) | (state_q & two_or_three_neighbors);
end

always_ff @(posedge clk) begin : delay
	/* reset should have priority (be able to reset the circuit whether ena = 1 or not)
	   on the positive edge of the clock, state_q is set to:
	    - reset if rst is High
	    - state_d if ena is High
	    - state_q if ena is Low (maintain previous state_q)
	*/
	state_q <= rst ? state_0 : (ena ? state_d : state_q);
end 

endmodule
