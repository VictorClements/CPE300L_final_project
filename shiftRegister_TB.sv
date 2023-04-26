// not quite working correctly with the testvectors file,
// but the shiftRegister module itself seems to be working according to waveforms
module shiftRegister_TB();

  logic       clk, reset; // add the rest of the desired signals
  logic       shiftEnable;
  logic [7:0] wordIn, wordOut, wordOutExpected;
  
  logic [31:0] vectornum, errors;
  logic [16:0] testvectors[10000:0];
  
  shiftRegister #(4, 8) DUT(clk, reset, shiftEnable, wordIn, wordOut);
  
// pulse the reset signal and load in test vectors
  initial begin
    $readmemh("shiftRegisterTestVectors.txt", testvectors);
    vectornum = 0; errors = 0;
    reset = 1; #17; reset = 0;
  end
  
always @(posedge clk) begin
  #1; {shiftEnable, wordIn, wordOutExpected} = testvectors[vectornum];
end

// create the clock
  always begin
    clk = 1; #5;
    clk = 0; #5;
  end
  
  // check results on falling edge of clk
  always @(negedge clk)
    if (~reset) begin // skip during reset
      if (wordOut !== wordOutExpected) begin  // check result
        $display("Error: shiftEnable = %b, wordIn = %h", shiftEnable, wordIn);
        $display("  outputs = %h (%h expected)", wordOut, wordOutExpected);
        errors = errors + 1;
      end
      vectornum = vectornum + 1;
      if (testvectors[vectornum] === 17'bx) begin 
        $display("%d tests completed with %d errors", 
	           vectornum, errors);
        $stop;
      end
    end
  
endmodule


