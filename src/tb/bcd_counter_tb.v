`timescale 1ns / 1ps

module bcd_counter_tb();

reg clk = 0;
reg rst = 0;
reg en = 0; 

bcd_counter_8b uut (
    .i_clk(clk),
    .i_rst(rst),
    .i_en(en),
    .i_max(8'h99)
);

initial begin
  $dumpfile("bcd_counter_tb.vcd");
  $dumpvars(0, bcd_counter_tb);
end

initial begin
   #10000; // Wait a long time in simulation units (adjust as needed).
   $display("Caught by trap");
   $finish;
 end

always begin
  clk = 1'b1;
  #2;
  clk = 1'b0;
  #2;
end


initial 
begin
    rst = 1'b1;
    repeat (4) @(posedge clk);
    rst = 1'b0;

    

    repeat (20) begin
        @(posedge clk);
        en <= 1;
        @(posedge clk);
        en <= 0;
    end

    repeat (20) begin
        @(posedge clk);
        en <= 1;
    end
    repeat (4) begin
        @(posedge clk);
        en <= 0;
    end
    
    $finish;
end

endmodule
