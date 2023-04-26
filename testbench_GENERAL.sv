module testbench_GENERAL();
  logic clk, reset; // add the rest of the desired signals
  
  modulename DUT(PortListContents);
  
// pulse the reset signal
  initial begin
    reset = 1; #12; reset = 0;
  end

// create the clock
  always begin
    clk = 1; #5;
    clk = 0; #5;
  end
endmodule
