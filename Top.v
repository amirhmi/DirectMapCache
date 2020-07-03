module Top(input clk, rst, output [31:0] dataOut, output [12:0] hitCount);
  reg [14:0] address, addressIn;
  wire checkHit, readCache, writeCache, readMem, hitCountEn, addressInc, hit;
  initial address = 1024;
  always @ (posedge addressInc) begin
    addressIn = address;
    address <= address + 1;
  end
  Datapath datapath(clk, checkHit, readCache, writeCache, readMem, hitCountEn, addressIn, hit, dataOut, hitCount);
  Controller controller(clk, rst, hit, checkHit, readCache, writeCache, readMem, hitCountEn, addressInc);
endmodule

module TB();
  reg clk = 0, rst = 1;
  wire[31:0] dataOut;
  wire[12:0] hitCount;
  Top top(clk, rst, dataOut, hitCount);

  initial repeat (73749) #50 clk = ~clk;
  initial  #70 rst = 0;
endmodule
