`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_comparator;

  logic [3:0] a;
  logic [3:0] b;
  wire out;

  comparator UUT(
    .a(a), 
    .b(b), 
    .out(out)
  );

  initial begin
    // $dumpfile("comparator.fst");
    // $dumpvars(0, UUT);
    
    b = 3;
    $display("a b | out");
    for (int i = 0; i < 16; i = i + 1) begin
      a = i;
      #1 $display("%4b %4b | %1b", a, b, out);
    end

    b = 7;
    for (int i = 0; i < 16; i = i + 1) begin
      a = i;
      #1 $display("%4b %4b | %1b", a, b, out);
    end

    b = 0;
    for (int i = 0; i < 16; i = i + 1) begin
      a = i;
      #1 $display("%4b %4b | %1b", a, b, out);
    end
        
    $finish;      
	end

endmodule
