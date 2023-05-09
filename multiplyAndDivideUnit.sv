module multiplyAndDivideUnit(input  logic [31:0] A, B,
                             input  logic        selectLine
                             output logic [63:0] result);
  result = selectline ? A*B : A/B;
endmodule
