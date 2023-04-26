module clockDivider #(parameter WIDTH = 32, FREQUENCY_IN = 50000000, FREQUENCY_OUT = 1, 
                                MULTIPLIER = ((2**WIDTH)*FREQUENCY_OUT - {{(WIDTH-1){1'b0}}, 1'b1})/FREQUENCY_IN + {{(WIDTH-1){1'b0}}, 1'b1})
                     (input  logic clk, reset,
                      output logic slowClk);

  logic [WIDTH-1:0] count;

  always_ff @(posedge clk, posedge reset)
    if (reset)  count <= '0;
    else        count <= count + MULTIPLIER;
  
  assign slowClk = count[WIDTH-1];

endmodule
