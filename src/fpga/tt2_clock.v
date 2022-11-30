module top (
	input  CLK,
    input BTN_N,

	input BTN1,
	input BTN2,

	output P1A1, P1A2, P1A3
);

    wire tt_clk;
    wire tt_rst;

    assign tt_clk = CLK;
    assign tt_rst = BTN_N;

clock clock_top (
    .i_clk(tt_clk),
    .i_rst(tt_rst),
    .i_min_up(BTN1),
    .i_hour_up(BTN2),
    .o_clk(P1A1),
    .o_latch(P1A2),
    .o_bit(P1A3)
);


endmodule
