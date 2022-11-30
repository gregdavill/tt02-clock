`default_nettype none

module mux_6_4b (
    input [3:0] i_in0,
    input [3:0] i_in1,
    input [3:0] i_in2,
    input [3:0] i_in3,
    input [3:0] i_in4,
    input [3:0] i_in5,
    input [2:0] i_sel,
    output reg [3:0] o_out
);
    
    always @(*) begin
        case (i_sel)
            3'd0: o_out <= i_in0;
            3'd1: o_out <= i_in1;
            3'd2: o_out <= i_in2;
            3'd3: o_out <= i_in3;
            3'd4: o_out <= i_in4;
            3'd5: o_out <= i_in5; 
            default: o_out <= 4'b1111;
        endcase
    end
endmodule
