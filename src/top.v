module miket6000_top(
    input [7:0]io_in,
    output [7:0]io_out);

    wire clk = io_in[0];
    wire rst = in_in[1];

    wire fast_clk, clk, flkr_clk, lfsr_clk, pwm_clk;
    wire [7:0]flkr;
    wire [3:0]lfsr_output;

    //assign clk = clk_in_1;
    //clk_wiz_0 c(.clk_in1(clk_in_1), .reset(1'b0), .clk_out1(fast_clk));
    // this is to get us an ~12.5khz clock, just like tinytapeout
    //clkdiv #(.INDEX(12)) cd0(.clk(fast_clk), .out(clk));
    clkdiv #(.INDEX(5)) cd1(.clk(clk), .out(lfsr_clk));
    clkdiv #(.INDEX(2)) cd2(.clk(clk), .out(flkr_clk));
        
    lfsr r0(.clk(lfsr_clk), .reset(rst), .run(1'b1), .out(lfsr_output));
    
    flicker f0(.clk(flkr_clk), .lfsr(lfsr_output), .brightness(flkr));
    
    pwm p0(.clk(clk), .reset(rst), .value(flkr), .out(io_out[0]));


endmodule
