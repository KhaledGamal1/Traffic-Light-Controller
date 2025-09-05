module two_digit_display_tb ();

reg clk , rstn;
reg [3:0] value;
wire [6:0] seg;
wire [1:0] an;

initial begin
    clk=1'b0;
    forever #5 clk = ~clk;
end

two_digit_display dut (
    .clk(clk) ,
    .rstn(rstn) ,
    .value(value) ,
    .seg(seg) ,
    .an(an)
);

initial begin
    rstn = 1'b0;
    value = 4'd0;
    repeat (3) @(negedge clk);
    rstn = 1'b1;
    repeat (10) @(negedge clk);
    value = 4'd5;
    repeat (10) @(negedge clk);
    value = 4'd9;
    repeat (10) @(negedge clk);
    value = 4'd12;
    repeat (10) @(negedge clk);
    value = 4'd15;
    repeat (10) @(negedge clk);
    $stop;
    
end


endmodule //two_digit_display_tb