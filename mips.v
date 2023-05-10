//EDITED
//instatiates modules in MIPS Processor
module mips (input clk, reset,
output [31:0] pc,
input [31:0] instr,
output memwrite,
output [31:0] aluout, writedata,
input [31:0] readdata);
wire memtoreg, branch, alusrc, regdst, regwrite, jump, jr, 
jal, sll, srl, lb, nop, mult, mflo, mfhi, div, alures, zero, pcsrc;
wire [2:0] alucontrol;
controller c(instr[31:26], instr[5:0], zero, memtoreg, memwrite, pcsrc,
 alusrc, regdst, regwrite, jump, jr, jal, sll, srl, lb, nop, mult, mflo, 
 mfhi, div,alures, alucontrol);
datapath dp(clk, reset, memtoreg, memwrite, pcsrc,
alusrc, regdst, regwrite, jump, jr, jal,
sll, srl, lb, nop, mult, mflo, mfhi, div, alures,
alucontrol,zero, pc, instr,
aluout, writedata, readdata);

endmodule
