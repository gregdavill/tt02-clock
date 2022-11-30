`default_nettype none

module output_sr (
    input i_clk,
    input i_rst,
    input i_load,
    input [7:0] i_data,
    output o_bit,
    output o_clk,
    output o_busy
);
    reg [4:0] counter;
    reg [7:0] sr;

    assign o_clk = counter[0];
    assign o_bit = sr[7];
    assign o_busy = (counter != 0);
    

    always @(posedge i_clk) begin
        if(o_clk)
            sr <= {sr[6:0], 1'b0};

        if (counter)
            counter <= counter - 5'd1;

        if(i_load) begin
            sr <= i_data;
            counter <= 5'd16;
        end

        if(i_rst) begin
            sr <= 8'd0;
            counter <= 5'd0;
        end
    end

endmodule

