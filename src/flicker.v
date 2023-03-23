module flicker (
    input clk,
    input [3:0]lfsr,
    output [7:0] brightness);
    
    reg [7:0]tap0, tap1, tap2, tmp;
    
    assign brightness = tmp;
    
    initial begin
        tap0 = 0;
        tap1 = 0;
        tap2 = 0;
        tmp = 0;
    end
    
    always @(posedge clk) begin
        if (lfsr[0]) begin
            if (tap0 < 8'h40) begin
                tap0 <= tap0 + 1;
            end else begin
                tap0 <= 8'h40;
            end
        end else begin
            if (tap0 > 8'h0) begin
                tap0 <= tap0 - 1;
            end else begin
                tap0 <= 0;
            end
        end
        if (lfsr[1]) begin
            if (tap0 < 8'h40) begin
                tap0 <= tap0 + 1;
            end else begin
                tap0 <= 8'h40;
            end
        end else begin
            if (tap0 > 8'h0) begin
                tap0 <= tap0 - 1;
            end else begin
                tap0 <= 0;
            end
        end
        if (lfsr[2]) begin
            if (tap0 < 8'h40) begin
                tap0 <= tap0 + 1;
            end else begin
                tap0 <= 8'h40;
            end
        end else begin
            if (tap0 > 8'h0) begin
                tap0 <= tap0 - 1;
            end else begin
                tap0 <= 0;
            end
        end
        tmp <= 8'h40 + tap0 + tap1 + tap2;     
    end
    


    
endmodule