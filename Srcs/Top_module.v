module Top_module 
    #(parameter TIMER_WIDTH = 4)
(
    input clk , rstn ,
    output NS_green , NS_yellow , NS_red,
    output EW_green , EW_yellow , EW_red,
    output [6:0] seg,
    output [1:0] an
);

/*============================================================
                Internal Signals declaration
==============================================================*/

wire clk_div ;                              // 1Hz clock signal
wire load ;                                 //load signal for timer
wire [TIMER_WIDTH -1 :0]load_value;         //load value for timer
wire done ;                                 //signal indicating timer is done
wire [TIMER_WIDTH -1 :0] timer_count;       //current count value of timer

/*============================================================
                Module Instantiation
==============================================================*/

clk_divider #(.DIV(10)) clk_div_inst (
    .clk_100MHz(clk) , 
    .rstn(rstn) , 
    .clk_1Hz(clk_div)
);

timer #(.WIDTH(TIMER_WIDTH)) timer_inst (
    .clk(clk_div) , 
    .rstn(rstn) , 
    .load(load) , 
    .enable(1'b1) , 
    .load_value(load_value) , 
    .timer_count(timer_count),
    .done(done)
);

Traffic_light_controller_FSM #(.WIDTH_TIMER(TIMER_WIDTH)) fsm (
    .clk(clk_div) , 
    .rstn(rstn) , 
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

two_digit_display display (
    .clk(clk_div) ,
    .rstn(rstn) ,
    .value(timer_count),
    .seg(seg),
    .an(an)
);


endmodule //Top_module