module multiplyanddivider(input [31:0] a, b, 
				  input sel,
				  input wire clk, input wire we,
				  output reg[31:0] rHigh, rLow);

wire [63:0] result;
				  
assign result = sel ? a*b : a/b;

always@(posedge clk)
	if (we){rHigh, rLow} <= result;
	else {rHigh, rLow} <= {rHigh, rLow};
	
endmodule 
