module vga(input  logic clk, reset, 
           output logic vgaclk,          // used on DE2 board
           output logic hsync, vsync, 
           output logic sync_b, blank_b, // used on DE2 board
           output logic [7:0] r, g, b);

  logic [9:0] x, y; 
  
  // divide 50 MHz input clock by 2 to get 25 MHz clock
  always_ff @(posedge clk, posedge reset)
    if (reset)  vgaclk = 1'b0;
    else        vgaclk = ~vgaclk;
		
  // generate monitor timing signals 
  vgaController vgaCont(vgaclk, reset, hsync, vsync, sync_b, blank_b, x, y); 

  // user-defined module to determine pixel color 
  videoGen videoGen(x, y,/*include any desired signals for video gen here*/ r, g, b); 
  
endmodule 
//================================================================================================================================//
module vgaController #(parameter HBP     = 10'd48,   // horizontal back porch
                                 HACTIVE = 10'd640,  // number of pixels per line
                                 HFP     = 10'd16,   // horizontal front porch
                                 HSYN    = 10'd96,   // horizontal sync pulse = 96 to move electron gun back to left
                                 HMAX    = HBP + HACTIVE + HFP + HSYN, //48+640+16+96=800: number of horizontal pixels (i.e., clock cycles)
                                 VBP     = 10'd32,   // vertical back porch
                                 VACTIVE = 10'd480,  // number of lines
                                 VFP     = 10'd11,   // vertical front porch
                                 VSYN    = 10'd2,    // vertical sync pulse = 2 to move electron gun back to top
                                 VMAX    = VBP + VACTIVE + VFP  + VSYN) //32+480+11+2=525: number of vertical pixels (i.e., clock cycles)                      

     (input  logic vgaclk, reset,
      output logic hsync, vsync, sync_b, blank_b, 
      output logic [9:0] hcnt, vcnt); 

      // counters for horizontal and vertical positions 
      always @(posedge vgaclk, posedge reset) begin 
        if (reset) begin
          hcnt <= 0;
          vcnt <= 0;
        end
        else  begin
          hcnt++; 
      	   if (hcnt == HMAX) begin 
            hcnt <= 0; 
  	        vcnt++; 
  	        if (vcnt == VMAX) 
  	          vcnt <= 0; 
          end 
        end
      end 
	  
      // compute sync signals (active low)
      assign hsync  = ~( (hcnt >= (HBP + HACTIVE + HFP)) & (hcnt < HMAX) ); 
      assign vsync  = ~( (vcnt >= (VBP + VACTIVE + VFP)) & (vcnt < VMAX) ); 

      // assign sync_b = hsync & vsync; 
      assign sync_b = 1'b0;  // this should be 0 for newer monitors

      // force outputs to black when not writing pixels
      assign blank_b = (hcnt > HBP & hcnt < (HBP + HACTIVE)) & (vcnt > VBP & vcnt < (VBP + VACTIVE)); 
endmodule 
//================================================================================================================================//
module videoGen(input logic [9:0] x, y,
                output logic [7:0] r, g, b); 
  
  //for displaying TOTAL : 
  logic pixel7, pixel8, pixel9, pixel10, pixel11, pixel12;

  //for displaying WATER REMINDER (t because title)
  logic t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12;

letterGen letter7 (x, y, 10'd440, 10'd150, 10'd455, 10'd170, 6'd19, pixel7);   // T
letterGen letter8 (x, y, 10'd460, 10'd150, 10'd475, 10'd170, 6'd14, pixel8);   // O
letterGen letter9 (x, y, 10'd480, 10'd150, 10'd495, 10'd170, 6'd19, pixel9);   // T
letterGen letter10(x, y, 10'd500, 10'd150, 10'd515, 10'd170, 6'd0,  pixel10);   // A
letterGen letter11(x, y, 10'd520, 10'd150, 10'd535, 10'd170, 6'd11, pixel11);   // L
letterGen letter12(x, y, 10'd540, 10'd150, 10'd555, 10'd170, 6'd27, pixel12);   // :

//letters to display title of project
letterGen title0 (x, y, 10'd230, 10'd50, 10'd245, 10'd70, 6'd22, t0); // W
letterGen title1 (x, y, 10'd250, 10'd50, 10'd265, 10'd70, 6'd0,  t1); // A
letterGen title2 (x, y, 10'd270, 10'd50, 10'd285, 10'd70, 6'd19, t2); // T
letterGen title3 (x, y, 10'd290, 10'd50, 10'd305, 10'd70, 6'd4 , t3); // E
letterGen title4 (x, y, 10'd310, 10'd50, 10'd325, 10'd70, 6'd17, t4); // R
                                                                      // space
letterGen title5 (x, y, 10'd350, 10'd50, 10'd365, 10'd70, 6'd17, t5); // R
letterGen title6 (x, y, 10'd370, 10'd50, 10'd385, 10'd70, 6'd4,  t6); // E
letterGen title7 (x, y, 10'd390, 10'd50, 10'd405, 10'd70, 6'd12, t7); // M
letterGen title8 (x, y, 10'd410, 10'd50, 10'd425, 10'd70, 6'd8 , t8); // I
letterGen title9 (x, y, 10'd430, 10'd50, 10'd445, 10'd70, 6'd13, t9); // N
letterGen title10(x, y, 10'd450, 10'd50, 10'd465, 10'd70, 6'd3 , t10);// D
letterGen title11(x, y, 10'd470, 10'd50, 10'd485, 10'd70, 6'd4 , t11);// E
letterGen title12(x, y, 10'd490, 10'd50, 10'd505, 10'd70, 6'd17, t12);// R

always_comb
  if(pixel7 | pixel8 | pixel9 | pixel10 | pixel11 | pixel12 | t0 | t1 | t2 | t3 | t4 | t5 | t6 | t7 | t8 | t9 | t10 | t11 | t12) {r, g, b} = 24'hFFFFFF;
  else  {r,g,b} = 24'h000000;
endmodule
//====================================================================================================================================//
module rectgen(input  logic [9:0] x, y, left, top, right, bot, 
               output logic inrect);
  assign inrect = (x >= left & x < right & y >= top & y < bot); 
endmodule 
