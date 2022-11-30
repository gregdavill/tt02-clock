`default_nettype none

module bcd_counter_8b (
    input i_clk,
    input i_rst,
    input i_en,
    output [7:0] o_bcd,
    input [7:0] i_max,
    output o_carry
);
    wire carry;

    bcd_counter_4b nibble_low(
        .i_clk(i_clk),
        .i_rst(i_rst),
        .i_en(i_en),
        .o_bcd(o_bcd[3:0]),
        .i_max(i_max[3:0]),
        .o_carry(carry)
    );    

    bcd_counter_4b nibble_high(
        .i_clk(i_clk),
        .i_rst(i_rst),
        .i_en(carry),
        .o_bcd(o_bcd[7:4]),
        .i_max(i_max[7:4]),
        .o_carry(o_carry)
    );    
endmodule


module bcd_counter_4b (
    input i_clk,
    input i_rst,
    input i_en,
    output reg [3:0] o_bcd,
    input [3:0] i_max,
    output o_carry
);
    wire [4:0] next;

    assign next = (o_bcd + 4'd1);
    assign o_carry = (next > i_max) & i_en;

    always @(posedge i_clk) begin
        if(i_en) begin
            o_bcd <= next;
            if(next > i_max)
                o_bcd <= 4'd0;    
        end

        if(i_rst) begin
            o_bcd <= 4'd0;
        end
    end

endmodule

