//EDITED
module aludec (input [5:0] funct,
input [1:0] aluop,
output reg [5:0] alucontrol);
always @ (*)

case (aluop)
2'b00: alucontrol <= 6'b01000; // add
2'b01: alucontrol <= 6'b11000; // sub
default: case(funct) // RTYPE
6'b100000: alucontrol <= 6'b010000; // ADD
6'b100010: alucontrol <= 6'b110000; // SUB
6'b100100: alucontrol <= 6'b000000; // AND
6'b100101: alucontrol <= 6'b001000; // OR
6'b101010: alucontrol <= 6'b111000; // SLT
6'b000000: alucontrol <= 6'b100000; //TODO: SLL
6'b000010: alucontrol <= 6'b101000; //TODO: SRL
6'b011000: alucontrol <= 6'b110000;  //TODO: MULT
6'b011010: alucontrol <= 6'b110100;  //TODO: div
6'b010000: alucontrol <= 6'b110000;  //TODO: movefromhigh
6'b010010: alucontrol <= 6'b110010; //TODO: movefromlow
default: alucontrol <= 6'b000001; // ???
endcase
endcase
endmodule