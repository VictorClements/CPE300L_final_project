module clockDivider_TB();
  logic       clk, reset; // add the rest of the desired signals
  logic       slowClk;
  clockDivider #(64'd32, 64'd50000000, 64'd30000000) DUT(clk, reset, slowClk);
  
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
