module miket6000_top(
    input [7:0] io_in,
    output [7:0] io_out,
    );
    
    parameter HW_CLK_SPEED = 125000;
    parameter PWM_CLK_SPEED = 125000;
    parameter FLKR_CLK_SPEED = 1024;
    parameter LFSR_CLK_SPEED = FLKR_CLK_SPEED / 4;

    assign clk = io_in[0];
    assign rst = io_in[1];
    assign out_0 = io_out[0];


    wire clk;
    wire flkr_en, lfsr_en, pwm_en;
    wire [7:0]flkr;
    wire [3:0]lfsr_output;

    //assign clk = clk_in_1;
    //clk_wiz_0 c(.clk_in1(clk_in_1), .reset(1'b0), .clk_out1(clk));
    // this is to get us an ~12.5khz clock, just like tinytapeout
    
    
    counter #(.DIVIDER(HW_CLK_SPEED / PWM_CLK_SPEED)) cnt_pwm(.clk(clk), .reset(rst), .out(pwm_en));
    counter #(.DIVIDER(HW_CLK_SPEED / FLKR_CLK_SPEED)) cnt_flkr(.clk(clk), .reset(rst), .out(flkr_en));    
    counter #(.DIVIDER(HW_CLK_SPEED / LFSR_CLK_SPEED)) cnt_lfsr(.clk(clk), .reset(rst), .out(lfsr_en));    
    
    lfsr r0(.clk(clk), .reset(rst), .enable(lfsr_en), .out(lfsr_output));
    
    flicker f0(.clk(clk), .enable(flkr_en), .lfsr(lfsr_output), .brightness(flkr));
    
    pwm p0(.clk(clk), .reset(rst), .enable(pwm_en), .value(flkr), .out(out_0));


endmodule
