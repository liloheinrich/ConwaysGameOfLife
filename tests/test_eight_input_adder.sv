`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_eight_input_adder;
  logic [7:0] neighbors;
  //wire [3:0] sum;
  //wire [31:0] sum;
  wire [3:0] sum;

  eight_input_adder UUT(
    // way to make explicit the args by name rather than order
    .neighbors(neighbors),
    .sum(sum)
  );


  initial begin
    // Collect waveforms
    $dumpfile("test_eight_input_adder.fst");
    $dumpvars(0, UUT);
    
    $display("neighbors | sum");
    for (int i = 0; i < 2*2*2*2*2*2*2*2; i = i + 1) begin
      neighbors = i[7:0];
      #1 $display("%1b | %1b", neighbors, sum);
    end

    $finish;      
	end
  

endmodule
