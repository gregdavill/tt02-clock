`default_nettype none

module rise_edge (
    input i_clk,
    input i_dat,
    output reg o_dat
);
    reg dat_r;
    always @(posedge i_clk) begin
        dat_r <= i_dat;
        o_dat <= (i_dat & ~dat_r);
    end

endmodule

