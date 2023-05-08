module register #(parameter WIDTH = 8, RESET_VALUE = 0)
  (input  logic clk, reset, enable,
   input  logic [WIDTH-1:0] d,
   output logic [WIDTH-1:0] q);
  
  always_ff @(posedge clk)
    if(reset)   q <= RESET_VALUE;
    else if(en) q <= d;
    else        q <= q;
  
endmodule
