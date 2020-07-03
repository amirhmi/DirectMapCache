module Cache(input clk, checkHit, readData, writeData, input [14:0] address, input [31:0] data0, data1, data2, data3, output reg hit, output reg [31:0] dataOut);
  reg [31:0] data [4095:0];
  reg valid [4095:0];
  reg [2:0] tag [4095:0];

  integer i;
  initial begin
    for (i=0;i<=4095;i=i+1)
      valid[i] = 0;
  end

  always @(posedge clk) begin
    if(checkHit) begin
      hit <= (valid[address[11:0]]) && (tag[address[11:0]] == address[14:12]);
    end
    else if(readData) begin
      dataOut <= data[address[11:0]];
    end
    else if(writeData) begin
      data[{address[11:2],2'b00}] = data0;
      valid[{address[11:2],2'b00}] = 1;
      tag[{address[11:2],2'b00}] = address[14:12];
      data[{address[11:2],2'b01}] = data1;
      valid[{address[11:2],2'b01}] = 1;
      tag[{address[11:2],2'b01}] = address[14:12];
      data[{address[11:2],2'b10}] = data2;
      valid[{address[11:2],2'b10}] = 1;
      tag[{address[11:2],2'b10}] = address[14:12];
      data[{address[11:2],2'b11}] = data3;
      valid[{address[11:2],2'b11}] = 1;
      tag[{address[11:2],2'b11}] = address[14:12];
    end
  end

endmodule
