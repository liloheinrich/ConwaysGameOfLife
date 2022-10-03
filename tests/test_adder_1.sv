`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_adder_1;
  logic a;
  logic b; 
  logic c_in;
  wire c_out;
  wire sum;

  adder_1 UUT(
    // way to make explicit the args by name rather than order
    .a(a),
    .b(b),
    .c_in(c_in),
    .c_out(c_out),
    .sum(sum)
  );

  initial begin
    // Collect waveforms
    $dumpfile("test_adder_1.fst");
    $dumpvars(0, UUT);
    
    $display("a b c_in | sum c_out");
    for (int i = 0; i < 8; i = i + 1) begin
      //in = i[2:0];
      a = i[0];
      b = i[1];
      c_in = i[2];
      #1 $display("%1b %1b %1b | %1b %1b", a, b, c_in, sum, c_out);
    end

    $finish;      
	end

endmodule
