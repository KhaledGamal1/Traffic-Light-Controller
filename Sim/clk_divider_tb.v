module clk_divider_tb();

parameter DIV = 50_000_000;

reg clk_100MHz , rstn , enable;
wire clk_1Hz;

clk_divider #(.DIV(5)) dut (.clk_100MHz(clk_100MHz) , .rstn(rstn) , .clk_1Hz(clk_1Hz));

initial begin
    clk_100MHz=1'b0;
    forever #5 clk_100MHz = ~clk_100MHz;
end

initial begin
    rstn = 1'b0;
    repeat (20) @(negedge clk_100MHz);
    rstn = 1'b1;
    repeat (50) @(negedge clk_100MHz);
    $stop;
end


endmodule