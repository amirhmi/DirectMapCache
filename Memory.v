module Memory (input clk, readData, input [14:0] address, output reg [31:0] data0, data1, data2, data3);
  reg [31:0] Memory [0:32767];

  integer i;
  initial begin
    for (i=1024;i<=9216;i=i+1)
      Memory[i] = i;
  end

	always @ (posedge clk) begin
		if (readData == 1) begin
      data0 <= Memory[{address[14:2],2'b00}];
      data1 <= Memory[{address[14:2],2'b01}];
      data2 <= Memory[{address[14:2],2'b10}];
      data3 <= Memory[{address[14:2],2'b11}];
    end
    else begin
      data0 <= data0;
      data1 <= data1;
      data2 <= data2;
      data3 <= data3;
    end
	end
endmodule
