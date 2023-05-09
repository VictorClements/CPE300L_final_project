//EDITED
//got all control signals
module datapath (input clk, reset,
input memtoreg, pcsrc,
input alusrc, regdst,
input regwrite, jump,
input jr, jal, sll, srl,
input lb, nop, mult, 
input mflo, mfhi, div, alures,
input [2:0] alucontrol,
output zero,
output [31:0] pc,
input [31:0] instr,
output [31:0] aluout, writedata,
input [31:0] readdata); //TODO: included new instructions

//defines all internal wires
wire [4:0] writereg;
wire [31:0] pcnext, pcnextbr, pcplus4, pcbranch, nextpcbranch; //TODO: new wire for jr
wire [31:0] signimm, signimmsh, muxout4, signex4, r1, r2;
wire [31:0] srca, srcb;
wire [31:0] result, operout, muxreg2, muxnext, lbmuxout, finalout;
wire [31:0] wdmuxout, jalmuxout, muxpcout;

// next PC logic. Instantiates PC and adders
flopr #(32) pcreg(clk, reset, pcnext, pc);
adder pcadd1 (pc, 32'b100, pcplus4);
sl2 immsh(signimm, signimmsh); 

adder pcadd2(pcplus4, signimmsh, pcbranch);
mux2 #(32) pcnexmux( readdata ,pcplus4,jal,jalmuxout); //TODO: includes the jal instruction
mux2 #(32) pcbrmux(pcplus4, pcbranch, pcsrc, pcnextbr);
mux2 #(32) pcmux(nextpcbranch, {pcplus4[31:28], instr[25:0], 2'b00},jump, pcnext); //TODO: altered for jr
mux2 #(32) muxthree(pcnextbr, srca, jr, nextpcbranch); //TODO: new mux for jr

// register file logic; instatiates RF
regfile rf(clk, regwrite, instr[25:21],
instr[20:16], writereg, wdmuxout, srca, writedata); 
multiplyanddivider mad(srca, srcb, mult, operout); //TODO: picks between multiply and divide
mux2 #(32) regsel(r1, r2, mfhi, muxreg2); //TODO: selects which register to use 


//instatiates the number of multiplexers
mux2 #(5) wrmux(instr[20:16], muxpcout, regdst, writereg); //TODO: edited
mux2 #(5) wrpre(instr[15:11], pcplus4[31], jal, muxpcout ); //TODO: new mux for jal
//mux2 #(32) resmux(aluout, jalmuxout, memtoreg, result); //TODO: edited
mux4 lbmux4(readdata[7:0], readdata[15:8], readdata[23:16], readdata[31:24], {aluout[31:2], 2'b00}, muxout4); //TODO: lb instruction
signext se2(muxout4, signex4); //TODO: lb instruction
mux2 lbmux(readdata, signex4, lb, lbmuxout); //TODO: readdata or lb
mux2 lbnextmux(lbmuxout, muxreg2, lb, muxnext); //TODO: decides between lb and register
mux2 finalmux(muxnext, aluout, alures, finalout); //TODO: FINAL mux
signext se(instr[15:0], signimm); ///TODO: lb instruction

// ALU logic: defines inputs and instatiates Alu
mux2 #(32) srcbmux(writedata, signimm, alusrc, srcb);
alu alu(srca, srcb, alucontrol, aluout, zero);

endmodule