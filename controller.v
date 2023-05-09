//EDITED
//instantiates both maind ecoder and ALU decoder
module controller (input [5:0] op, funct,
input zero,
output memtoreg, memwrite,
output pcsrc, alusrc,
output regdst, regwrite,
output jump, jr, jal,
output sll, srl, lb, nop, mult,
output mflo, mfhi, div, alures,
output [2:0] alucontrol); //TODO: included more signals
wire [1:0] aluop;
wire branch;
maindec md(op, funct, memtoreg, memwrite, branch,
alusrc, regdst, regwrite, jump, jr, jal, sll, srl,
lb, nop, mult, mflo, mfhi, div, alures,
aluop);
aludec ad (funct, aluop, alucontrol);
assign pcsrc = branch & zero; //does it here because the logic is outside of main decoder and ALU decoder
endmodule