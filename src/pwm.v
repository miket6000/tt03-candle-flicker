/* out is high while the 8-bit counter is < value, low when above */
module pwm (
  input clk,
  input reset,
  input [7:0]value,
  output out );
  
  reg [7:0]count;
  
  initial begin
    count = 0;
  end
  
  assign out = (value > count);

  always @(posedge clk) begin
    count <= count + 1;
    if (reset) begin
      count <= 0;
    end
  end
endmodule
