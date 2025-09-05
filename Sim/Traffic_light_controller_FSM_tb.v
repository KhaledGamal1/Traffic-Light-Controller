module Traffic_light_controller_FSM_tb();

parameter WIDTH_TIMER = 4;
reg clk, rstn;
reg ped_req;
reg done ;

wire load ;
wire [WIDTH_TIMER -1 :0]load_value;

wire NS_green , NS_yellow , NS_red;
wire EW_green , EW_yellow , EW_red;

Traffic_light_controller_FSM #(.WIDTH_TIMER(WIDTH_TIMER)) dut (
    .clk(clk) , 
    .rstn(rstn) , 
    .ped_req(ped_req) , 
    .done(done) ,
    .load(load) ,
    .load_value(load_value) ,
    .NS_green(NS_green) , 
    .NS_yellow(NS_yellow) , 
    .NS_red(NS_red) , 
    .EW_green(EW_green) , 
    .EW_yellow(EW_yellow) , 
    .EW_red(EW_red)
);

initial begin
    clk=1'b0;
    forever #5 clk = ~clk;
end

initial begin
    rstn = 1'b0;
    ped_req = 1'b0;
    done = 1'b0;
    repeat (3) @(negedge clk);
    rstn = 1'b1;
    done = 1'b1;
    repeat (50) @(negedge clk);
    wait (NS_green == 1'b1);
    ped_req = 1'b1;
    @(negedge clk);
    ped_req = 1'b0;
    repeat (50) @(negedge clk);
    #50;
    $stop;
end


endmodule