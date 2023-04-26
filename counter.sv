module counter #(parameter MIN = 5'd0, MAX = 5'd20, WIDTH = 5)
                (input  logic             clk, reset,
                 output logic [WIDTH-1:0] count);

  always_ff @(posedge clk)
    if(reset | count == MAX)  count <= MIN;
    else                      count <= count + 1;

endmodule