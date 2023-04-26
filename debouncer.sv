module debouncer(input  logic slowClk, reset,
                 input  logic buttonPress,
                 output logic debouncedPress);

  logic [3:0] priorPresses

  always_ff @(posedge slowClk)
    if(reset) priorPresses <= 0;
    else      priorPresses <= {buttonPress, priorPresses[3:1]};

  assign debouncedPress = &priorPresses;

endmodule