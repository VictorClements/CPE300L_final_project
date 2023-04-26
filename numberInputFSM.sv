module numberInputFSM #()
                       (input  logic clk, reset,
                        input  logic );

  typedef enum logic [1:0] {SR, S1, S2} statetype;
  statetype state, nextstate;

  // state register
  always_ff @(posedge clk, posedge reset)
    if (reset) state <= SR;
    else       state <= nextstate;

  // next state combinational logic
  always_comb
    case(state)

    endcase

  // output logic 

endmodule