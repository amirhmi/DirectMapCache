module Controller(input clk, rst, hit, output reg checkHit, readCache, writeCache, readMem, hitCountEn, addressInc);
  parameter [3:0] GA=0, CH=1,CHA=2, RC=3, RM=4, WC=5, RC2=6;
  reg [3:0] ps, ns;
  always @(ps) begin
    ns = GA;
    case(ps)
      GA : ns = CH;
      CH : ns = CHA;
      CHA : ns = hit == 1 ? RC : RM;
      RC : ns = GA;
      RM : ns = WC;
      WC : ns = RC2;
      RC2 : ns = GA;
      default : ns = GA;
    endcase
  end
  always @(ps) begin
    checkHit = 0; readCache = 0; writeCache = 0; readMem = 0; hitCountEn = 0; addressInc = 0;
    case(ps)
      GA : addressInc = 1;
      CH : checkHit = 1;
      RC : begin readCache = 1; hitCountEn = 1; end
      RM : readMem = 1;
      WC : writeCache = 1;
      RC2 : readCache = 1;
      default : begin checkHit = 0; readCache = 0; writeCache = 0; readMem = 0; hitCountEn = 0; addressInc = 0; end
    endcase
  end
  always @ (posedge clk, posedge rst) begin
    if(rst) ps <= GA;
    else ps <= ns;
  end
endmodule
