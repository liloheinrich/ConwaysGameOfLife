`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_adder_n;
  parameter N = 1;

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
    $dumpfile("test_adder_n.fst");
    $dumpvars(0, UUT);
    
    $display("a b c_in | c_out sum");
    for (int i = 0; i < N*N*N*N*N; i = i + 1) begin // N*N is enumerating the possibilities for 'a', multiply by N*N again to enumerate the possibilities for 'b', then by N to enumerate the possibilities for 'c_in'
      a = i[N-1:0];
      b = i[2*N-1:N];
      c_in = i[2*N+1:2*N];
      #1 $display("%1b %1b %1b | %1b %1b", a, b, c_in, c_out, sum);
    end

    $finish;      
	end

endmodule
