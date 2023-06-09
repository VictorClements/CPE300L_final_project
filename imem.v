//64 word memory is defined here
// .dat. file has a hexadecimal code of instructions

module imem (input [5:0] a, output [31:0] rd);
reg [31:0] RAM[123:0]; // limited memory
initial
begin
$readmemh ("memfile.dat",RAM);//lines of test code in hex
end
assign rd = RAM[a]; // word aligned
endmodule
