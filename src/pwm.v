/* out is high while the 8-bit counter is < value, low when above */
module pwm (
  input clk,
  input reset,
  input enable,
  input [7:0]value,
  output out );
  
  reg [7:0]c_count, r_count;
  
  initial begin
    r_count = 0;
  end
  
  assign out = (value > r_count);
  
  always @(posedge clk) begin
    r_count <= c_count;
  end

  always @(*) begin
    c_count = r_count;
    if (reset) begin
      c_count = 0;
    end else if (enable) begin
      c_count = r_count + 1;
    end
  end
endmodule
