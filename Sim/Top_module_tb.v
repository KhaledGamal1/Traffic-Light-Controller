module Top_module_tb ();

parameter TIMER_WIDTH = 4;
reg clk , rstn ;
wire NS_green , NS_yellow , NS_red;
wire EW_green , EW_yellow , EW_red;
wire [6:0] seg;
wire [1:0] an;

Top_module #(.TIMER_WIDTH(TIMER_WIDTH)) dut (
    .clk(clk) , 
    .rstn(rstn) , 
    .NS_green(NS_green) , 
    .NS_yellow(NS_yellow) , 
    .NS_red(NS_red) , 
    .EW_green(EW_green) , 
    .EW_yellow(EW_yellow) , 
    .EW_red(EW_red),
    .seg(seg),
    .an(an)
);

initial begin
    clk=1'b0;
    forever #5 clk = ~clk;
end

initial begin
    
    // Reset and Initialization
    rstn = 1'b0;
    repeat (3) @(negedge clk);
    rstn = 1'b1;
    
    // Observe one full cycle
    wait (NS_green == 1'b1);
    $display("Time: %0t - NS Green", $time);
    wait (NS_yellow == 1'b1);
    $display("Time: %0t - NS Yellow", $time);
    wait (EW_green == 1'b1);
    $display("Time: %0t - EW Green", $time);
    wait (EW_yellow == 1'b1);
    $display("Time: %0t - EW Yellow", $time);
    wait (NS_green == 1'b1);
    $display("Time: %0t - Back to NS Green", $time);

    //Observe the second full cycle
    wait (NS_green == 1'b1);
    $display("Time: %0t - NS Green", $time);
    wait (NS_yellow == 1'b1);
    $display("Time: %0t - NS Yellow", $time);
    wait (EW_green == 1'b1);
    $display("Time: %0t - EW Green", $time);
    wait (EW_yellow == 1'b1);
    $display("Time: %0t - EW Yellow", $time);
    wait (NS_green == 1'b1);
    $display("Time: %0t - Back to NS Green", $time);
    
    $stop;
    
end

endmodule //Top_module_tb