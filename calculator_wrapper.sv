module calculator_wrapper(input  logic       CLOCK_50,
                          input  logic [9:0] SW,
                          input  logic [3:0] KEY,
                          output logic       VGA_CLK,
                          output logic       VGA_HS, VGA_VS,
                          output logic       VGA_SYNC_N, VGA_BLANK_N,
                          output logic [7:0] VGA_R, VGA_G, VGA_B);
  logic vgaclk, sync_b, blank_b;
  vga(CLOCK_50, SW[0], VGA_CLK, VGA_HS, VGA_VS,
      VGA_SYNC_N, VGA_BLANK_N, VGA_R, VGA_G, VGA_B);
endmodule
