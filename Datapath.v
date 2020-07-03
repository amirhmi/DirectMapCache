module Datapath(input clk, checkHit, readCache, writeCache, readMem, hitCountEn, input [14:0] address, output hit, output [31:0] dataOut, output [12:0] hitCount);
  wire [31:0] data0, data1, data2, data3;
  Counter hitCounter(clk, hitCountEn, hitCount);
  Cache cache(clk, checkHit, readCache, writeCache, address, data0, data1, data2, data3, hit, dataOut);
  Memory memory(clk, readMem, address, data0, data1, data2, data3);
endmodule
