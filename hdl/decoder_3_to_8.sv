module decoder_3_to_8(ena, in, out);

input wire ena;
input wire [2:0] in;
output logic [7:0] out;

logic in2, in1, in0;
logic [3:0] out1;
logic [3:0] out0;

logic in2_bar;
logic ena1;
logic ena0;

/* similarly to the 2:4 decoder, the last layer of the 3:8 decoder is decoders one level lower.
in[2] and ~in[2] act as the ena for the 2:4 decoders, and-ed with the overall ena.
in[1] and in[0] are the inputs to both decoders.
*/

decoder_2_to_4 D1(
				.ena(ena1), 
				.in({in1, in0}), 
				.out(out1)
				);
decoder_2_to_4 D0(
				.ena(ena0), 
				.in({in1, in0}), 
				.out(out0)
				);

always_comb begin

	in2_bar = ~ in2;
	ena0 = in2_bar & ena;
	ena1 = in2 & ena;

	in2 = in[2];
	in1 = in[1];
	in0 = in[0];
	out = {out1, out0};

end

endmodule
