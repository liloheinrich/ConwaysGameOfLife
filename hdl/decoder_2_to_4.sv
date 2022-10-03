module decoder_2_to_4(ena, in, out);

input wire ena;
input wire [1:0] in;
output logic [3:0] out;

logic in1, in0;
logic [1:0] out1;
logic [1:0] out0;

logic in1_bar;
logic ena1;
logic ena0;

decoder_1_to_2 D1(
				.ena(ena1), 
				.in(in0), 
				.out(out1)
				);
decoder_1_to_2 D0(
				.ena(ena0), 
				.in(in0), 
				.out(out0)
				);

always_comb begin

	in1_bar = ~ in1;
	ena0 = in1_bar & ena;
	ena1 = in1 & ena;

	in1 = in[1];
	in0 = in[0];
	out = {out1, out0};

end

endmodule