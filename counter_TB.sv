module counter_TB();
  logic       clk, reset; // add the rest of the desired signals
  logic       up, enable;
  logic [4:0] count;
  counter #(3,27) DUT(clk, reset, up, enable, count);
  
// pulse the reset signal
  initial begin
    reset = 1; #12; reset = 0;
  end
  
// initialize the enable and up values
  initial begin
    up = 1; enable = 1; #400;
    enable = 0; #400;
    up = 0; enable = 1; #400;
    enable = 0; #400;
  end

// create the clock
  always begin
    clk = 1; #5;
    clk = 0; #5;
  end
endmodule
