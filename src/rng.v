/* returns a psudorandom 8-bit number which changes every 8 clk cycles so long as run is high */
module lfsr(
  input clk,
  input reset,
  input enable,
  output [3:0]out);
  
  reg [15:0]r_lfsr, c_lfsr;
  assign out = r_lfsr[3:0];
  
  initial begin
    r_lfsr = 16'hbeef;
    c_lfsr = 16'hbeef;
  end

  always @(posedge clk) begin
    r_lfsr <= c_lfsr;
  end

  always @(*) begin
    c_lfsr = r_lfsr;
    if (reset) begin
      c_lfsr = 16'hbeef;
    end else if (enable) begin
      c_lfsr = {r_lfsr[14:0], r_lfsr[10] ^ r_lfsr[12] ^ r_lfsr[13] ^ r_lfsr[15]};
    end
  end
endmodule