`timescale 1ns / 1ps

module clock_tb();

reg clk = 0;
reg rst = 0;

clock uut (
    .i_clk(clk),
    .i_rst(rst)
);

initial begin
  $dumpfile("clock_tb.vcd");
  $dumpvars(0, clock_tb);
end

initial begin
   #1000; // Wait a long time in simulation units (adjust as needed).
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
end


endmodule
