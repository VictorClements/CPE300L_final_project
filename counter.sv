module counter #(parameter MIN = 5'd0, MAX = 5'd20, WIDTH = $clog2(MAX+1))
                (input  logic             clk, reset, up, enable,
                 output logic [WIDTH-1:0] count);
                 // if up = 1, we count up, if up = 0, we count down

  always_ff @(posedge clk)
    if(reset)                         count <= MIN;
    else if(enable) begin
        if(up & (count == MAX))       count <= MIN;
        else if(~up & (count == MIN)) count <= MAX;
        else if(up)                   count <= count + 1;
        else if(~up)                  count <= count - 1;
    end

endmodule
