module flicker (
    input clk,
    input enable, 
    input [3:0] lfsr,
    output [7:0] brightness);
    
    reg [7:0]r_tap0, r_tap1, r_tap2, c_tap0, c_tap1, c_tap2, tmp;
    
    assign brightness = tmp;
    
    initial begin
        r_tap0 = 0;
        r_tap1 = 0;
        r_tap2 = 0;
        tmp = 0;
    end
    
    always @(posedge clk) begin
        r_tap0 = c_tap0;
        r_tap1 = c_tap1;
        r_tap2 = c_tap2;
        tmp <= 8'h3F + r_tap0 + r_tap1 + r_tap2;
    end
    
    always @(*) begin
        c_tap0 = r_tap0;
        c_tap1 = r_tap1;
        c_tap2 = r_tap2;
        if (enable) begin
            if (lfsr[0]) begin
                if (c_tap0 < 8'h40) begin
                    c_tap0 = c_tap0 + 1;
                end else begin
                    c_tap0 = 8'h40;
                end
            end else begin
                if (c_tap0 > 8'h0) begin
                    c_tap0 = c_tap0 - 1;
                end else begin
                    c_tap0 = 0;
                end
            end
            if (lfsr[1]) begin
                if (c_tap1 < 8'h40) begin
                    c_tap1 = c_tap1 + 1;
                end else begin
                    c_tap1 = 8'h40;
                end
            end else begin
                if (c_tap1 > 8'h0) begin
                    c_tap1 = c_tap1 - 1;
                end else begin
                    c_tap1 = 0;
                end
            end
            if (lfsr[2]) begin
                if (c_tap2 < 8'h40) begin
                    c_tap2 = c_tap2 + 1;
                end else begin
                    c_tap2 = 8'h40;
                end
            end else begin
                if (c_tap2 > 8'h0) begin
                    c_tap2 = c_tap2 - 1;
                end else begin
                    c_tap2 <= 0;
                end
            end
        end
    end
    


    
endmodule