module Counter(input clk, countEnable, output reg [12:0] hitCount);
  initial begin
    hitCount = 0;
  end
  always @ (posedge clk) begin
    if(countEnable)
      hitCount <= hitCount + 1;
    else
      hitCount <= hitCount;
  end
endmodule
