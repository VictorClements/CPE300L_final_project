//takes opcode and produces control signals except branch (this //is done by controller module as an outside logic)

module maindec (input [5:0] op, input [5:0] funct, output memtoreg, memwrite, output branch, alusrc,
output regdst, regwrite, output jump, output jr, output jal, output sll, output srl, output lb, 
output nop, output mult, output mflo, output mfhi, output div, output alures, output [1:0] aluop);
reg [19:0] controls;
assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, jr, jal, sll, srl, lb, nop, mult, mflo, mfhi, div, alures, aluop}  = controls;
//TODO: included more signals 
// checks the opcode and produces 9 control signals as in the //control word table

always @ (* )
 case(op)
6'b100011 :  controls <= 20'b10100100000000000100; 		// LW
6'b101011 :  controls <= 20'b00101000000000000100; 		// SW
6'b000100 :  controls <= 20'b00010000000000000101; 		// BEQ
6'b001000 :  controls <= 20'b10100000000000000000; 		// ADDI
6'b000010 :  controls <= 20'b00000010000000000100; 		// J
6'b000011 :  controls <= 20'b01000010000000000100;  		// JAL
6'b000101 :  controls <= 20'b11000100010000000000;  		// SLL
6'b000110 :  controls <= 20'b11000100001000000000;  		// SRL                    
6'b000111 :  controls <= 20'b01100000000100000100;  		// LB
6'b001001 :  controls <= 20'b00000000000000000000;  		// NOP
6'b001010 :  controls <= 20'b01100000000001010000;  		// MULT
6'b001011 :  controls <= 20'b01100000000000101001;  		// MFLO
6'b001100 :  controls <= 20'b01100000000001010000;  		// MFHI
6'b001101 :  controls <= 20'b01100000000000101001;  		// DIV

default:  	if(funct == 6'b001000)  controls <= 20'b10000010000000000110; //TODO: JR INCLUDED TO ASSIGN CONTROLS
        	else controls <= 20'b11000000000000000110; 	// Rtyp
endcase
endmodule



