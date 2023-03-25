module counter(
    input clk,
    input reset,
    output out
    );
    
    parameter DIVIDER = 16'd1;
    
    reg r_out, c_out;
    reg [15:0] r_count, c_count;
    assign out = r_out;
        
    initial begin
        r_count = 0;
    end    
        
     
    always @(posedge clk or negedge clk) begin
        r_out <= c_out;
        r_count <= c_count;    
    end
    
    always @(*) begin
        c_count = r_count + 1;
        c_out = 0;
        if (reset) begin
            c_count = 0;
            c_out = 1;
        end else begin
            if (c_count > DIVIDER) begin
                c_count = 0;
                c_out = 1;
            end
        end
    end
    
endmodule
