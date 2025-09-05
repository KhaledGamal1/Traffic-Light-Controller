module timer_tb ();

parameter WIDTH = 8;
reg clk, rstn;
reg load , enable;
reg [WIDTH-1 :0] load_value;
wire timer_count;
wire done;

timer #(.WIDTH(WIDTH)) dut (
    .clk(clk),
    .rstn(rstn),
    .enable(enable),
    .load(load),
    .load_value(load_value),
    .timer_count(timer_count),
    .done(done)
);

initial begin
    clk=1'b0;
    forever #5 clk = ~clk;
end


initial begin
    rstn = 1'b0;
    load = 1'b0;
    enable = 1'b0;
    load_value = 8'd5;
    repeat (3) @(negedge clk);
    rstn = 1'b1;
    load = 1'b1;
    enable = 1'b0;
    @(negedge clk);
    load = 1'b0;
    repeat (2) @(negedge clk);
    enable =1'b1;
    repeat (6) @(negedge clk);
    load = 1'b1;
    load_value = 8'd10;
    @(negedge clk);
    load = 1'b0;
    repeat (12) @(negedge clk);
    $stop;
end

endmodule //timer_tb