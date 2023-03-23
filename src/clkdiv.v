module clkdiv (
    input clk,
    output out);

    parameter INDEX = 1;
    reg [32:0]count;
    assign out = count[INDEX];
    
    initial begin
        count = 0;
    end
    
    always @(posedge clk) begin
        count <= count + 1;
    end
endmodule