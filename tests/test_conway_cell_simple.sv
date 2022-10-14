`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_conway_cell;

logic clk, rst, ena, state_0;
logic [7:0] neighbors;
wire state_d, state_q;

conway_cell UUT(
  .clk(clk), .rst(rst), .ena(ena),
  .neighbors(neighbors),
  .state_0(1'b0), .state_d(state_d), .state_q(state_q) 
);

initial begin
  // Initialize modules input.
  clk = 0;
  rst = 1; // Start reset in active state.
  ena = 1; // Not testing the ena function in this example (though you should try!)
  state_0 = 0;
  
  // Collect all internal variables for waveforms.
  $dumpfile("test_conway_cell_simple.fst");
  $dumpvars(0, UUT);
  
  
  #1 $display("neighbors : state_0 : d");

  neighbors = 8'b01010100;
  #1 $display("%b : %b: %b", neighbors, state_0, state_d);

  $finish; // End the simulation.
end

endmodule
