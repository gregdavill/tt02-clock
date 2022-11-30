`default_nettype none

module bcd_decoder (
    input [3:0] i_in,
    output reg [7:0] o_out
);
    
    always @(*) begin
        case (i_in)
            4'd0: o_out <= 8'b0011_1111;
            4'd1: o_out <= 8'b0000_0110;
            4'd2: o_out <= 8'b0101_1011;
            4'd3: o_out <= 8'b0100_1111;
            4'd4: o_out <= 8'b0110_0110;
            4'd5: o_out <= 8'b0110_1101;
            4'd6: o_out <= 8'b0111_1101; 
            4'd7: o_out <= 8'b0000_0111;
            4'd8: o_out <= 8'b0111_1111;
            4'd9: o_out <= 8'b0110_1111;
            default: o_out <= 8'b0000_0000;
        endcase
    end
endmodule
