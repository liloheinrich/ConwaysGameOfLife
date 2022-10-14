// test if a <= b

module comparator(a, b, out);

input wire [3:0] a;
input wire [3:0] b;
output logic out;

// test if a = b
logic equals;
logic [3:0] xor_out;

always_comb begin
    xor_out = a ^ b;
    equals = ~xor_out[0] & ~xor_out[1] & ~xor_out[2] & ~xor_out[3];
end

// test if a < b
logic less_than;
logic [3:0] and_out;

always_comb begin
    and_out[0] = ~a[3] & b[3];
    and_out[1] = ~(a[3]^b[3]) & ~a[2] & b[1];
    and_out[2] = ~(a[3]^b[3]) & ~(a[2]^b[2]) & ~a[1] & b[1];
    and_out[3] = ~(a[3]^b[3]) & ~(a[2]^b[2]) & ~(a[1]^b[1]) & ~a[0] & b[0];

    less_than = and_out[0] | and_out[1] | and_out[2] | and_out[3];
end

always_comb out = less_than | equals;

endmodule