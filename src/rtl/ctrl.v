`default_nettype none

module ctrl (
    input i_clk,
    input i_rst,
    output [2:0] o_muxsel,
    input i_srrdy,
    output o_srload,
    output reg o_latch,
    output o_cnt_en
);
    localparam SET_SR = 2'd0;
    localparam CLEAR_SR = 2'd1;
    localparam LATCH = 2'd2;
    localparam WAIT = 2'd3;

    reg [1:0] state;
    reg [2:0] counter;
    reg [6:0] scaler;

    assign o_cnt_en = (scaler == 7'd0);
    assign o_muxsel = counter;
    assign o_srload = i_srrdy & (state == SET_SR);
        
    always @(posedge i_clk) begin
        scaler <= scaler + 7'd1; /* Rollover after 128 counts */
        
        case (state)
            SET_SR: begin
                if(i_srrdy) begin
                    state <= CLEAR_SR;
                    counter <= counter + 3'd1;
                end
            end 
            CLEAR_SR: begin
                state <= SET_SR;
                if(counter == 3'd6) begin
                    state <= CLEAR_SR;
                    if(i_srrdy && !o_srload) begin
                        state <= LATCH;
                    end
                end
            end 

            LATCH: begin
                state <= WAIT;
                o_latch <= 1'b1;
            end
            
            WAIT: begin
                o_latch <= 1'b0;
                counter <= 3'd0;
                if(o_cnt_en) begin
                    state <= CLEAR_SR;
                end
            end 

            default: state <= WAIT;
        endcase

        if(i_rst) begin
            state <= WAIT;
            counter <= 3'd0;
            scaler <= 7'd127;
        end
    end
    

endmodule

