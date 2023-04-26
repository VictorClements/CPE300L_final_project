module shiftRegister #(parameter REGISTER_COUNT = 21, WIDTH = 8)
                      (input  logic clk, reset, shiftEnable,
                       input  logic [WIDTH-1:0] wordIn,
                       output logic [WIDTH-1:0] wordOut);
  
  logic [WIDTH-1:0] registers [REGISTER_COUNT-1:0];
  
  always_ff @(posedge clk)
    if(reset)             registers <= '{default:0}; 
    else if(shiftEnable)  registers <= {registers[REGISTER_COUNT-2:0], wordIn};
  
endmodule

