module multiplyanddivider(input [31:0] a, b,
				  input [2:0] sel,
				  output [31:0] out);

assign out = sel ? a*b : a/b;

endmodule 