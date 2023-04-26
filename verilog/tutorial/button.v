
// DELAY = 0.1s with a 27MHz clock
module debounce #(
  parameter DELAY = 270000 - 1;
) (
  input reset, clock, bouncey,
  output reg steady
);

  reg [18:0] count;
  reg old;

  always @(posedge clock)
    if (reset) // reset to initial state
      begin
        count <= 0;
        old <= bouncey;
        steady <= bouncey;
      end
    else if (bouncey != old) // changed input
      begin
        old <= bouncey;
        count <= 0;
      end
    else if (count == DELAY) // stable input
      steady <= old;
    else
      count <= count + 1;
  end
    
endmodule

module onoff_sync (
  input clk, reset, button_in,
  output reg light
);

  // syncrhonizer
  reg button, btemp;
  always @(posedge clk)
    {button, btemp} <= {btemp, button_in};

  // debounce
  wire bpressed;
  debounce db1(.clock(clk), .reset(reset), .bouncey(button), .steady(bpressed));

  reg old_bpressed;
  always @(posedge clk) begin
    if (reset)
      begin light <= 0;
      old_bpressed <= 0;
      end;
    else if (old_bpressed == 0 && bpressed == 1)
      // button changed from 0 to 1
      light <= ~light;
      old_bpressed <= bpressed;
  end;
  
endmodule
