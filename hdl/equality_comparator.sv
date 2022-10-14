// test if a = b

module equality_comparator(a, b, out);

input wire [3:0] a;
input wire [3:0] b;
output logic out;

logic [3:0] xor_out;

always_comb begin
    xor_out = a ^ b;
    out = ~xor_out[0] & ~xor_out[1] & ~xor_out[2] & ~xor_out[3];
end


endmodule