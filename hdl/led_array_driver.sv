`default_nettype none
`timescale 1ns/1ps

module led_array_driver(ena, x, cells, rows, cols);
// Module I/O and parameters
parameter N=8; // Size of Conway Cell Grid.
parameter ROWS=N;
parameter COLS=N;

// I/O declarations
input wire ena;
input wire [$clog2(N):0] x;
input wire [N*N-1:0] cells;
output logic [N-1:0] rows;
output logic [N-1:0] cols;

wire [N-1:0] x_decoded;
decoder_3_to_8 decoder_3_to_8_inst(.ena(ena), .in(x), .out(x_decoded));


// You can check parameters with the $error macro within initial blocks.
initial begin

  if ((N <= 0) || (N > 8)) begin
    $error("N must be within 0 and 8.");
  end
  if (ROWS != COLS) begin
    $error("Non square led arrays are not supported. (%dx%d)", ROWS, COLS);
  end
  if (ROWS < N) begin
    $error("ROWS/COLS must be >= than the size of the Conway Grid.");
  end
end


genvar i;
generate
  for (i = 0; i < N; i = i + 1) begin
    always_comb rows[i] = ~(|(x_decoded[N-1:0] & cells[(i+1)*N-1:i*N]));
  end
endgenerate 

always_comb cols = x_decoded;


endmodule
