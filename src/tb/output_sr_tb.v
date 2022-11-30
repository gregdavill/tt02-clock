`timescale 1ns / 1ps

module output_sr_tb();

reg clk = 0;
reg rst = 0;
reg load = 0; 
reg [7:0] data = 0;
wire out_bit;
wire out_clk;
wire busy;

output_sr uut (
    .i_clk(clk),
    .i_rst(rst),
    .i_load(load),
    .i_data(data),
    .o_bit(out_bit),
    .o_clk(out_clk),
    .o_busy(busy)
);

initial begin
  $dumpfile("output_sr_tb.vcd");
  $dumpvars(0, output_sr_tb);
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


task load_sr;
    input [7:0] _data;
    begin
        while(busy)
            @(posedge clk);
        data <= _data;
        load <= 1'b1;
        @(posedge clk);
        load <= 1'b0;
        @(posedge clk);
    end
endtask


initial 
begin
    rst = 1'b1;
    repeat (4) @(posedge clk);
    rst = 1'b0;

	load_sr(8'h01);
	load_sr(8'h80);
	load_sr(8'h00);
	load_sr(8'hff);
	load_sr(8'haa);


    while(busy)
        @(posedge clk);
    
    repeat (4) @(posedge clk);
    $finish;
end

endmodule
