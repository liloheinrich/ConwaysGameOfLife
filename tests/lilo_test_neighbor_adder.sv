`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module lilo_test_neighbor_adder;
  parameter N = 8;

  logic [N-1:0] a;
  logic [N-1:0] b; 
  logic c_in;
  wire c_out;
  wire [N-1:0]sum;



  adder_n #(.N(N)) UUT(
    // way to make explicit the args by name rather than order
    .a(a),
    .b(b),
    .c_in(c_in),
    .c_out(c_out),
    .sum(sum)
  );


  initial begin
    // Collect waveforms
    $dumpfile("lilo_test_neighbor_adder.fst");
    $dumpvars(0, UUT);
    
    $display("a b c_in | c_out sum");
    for (int i = 0; i < N; i = i + 1) begin // N*N is enumerating the possibilities for 'a', multiply by N*N again to enumerate the possibilities for 'b', then by N to enumerate the possibilities for 'c_in'
      a = i[N-1:0];
      b = 00000000;
      c_in = 0;
      #1 $display("%1b %1b %1b | %1b %1b", a, b, c_in, c_out, sum);
    end

    $finish;      
  end

endmodule
