module Traffic_light_controller_FSM
    #(parameter WIDTH_TIMER = 4)
(
    input clk , rstn,
    input done,               //timer done signal

    output reg load ,                                 //load signal for timer 
    output reg [WIDTH_TIMER -1 :0]load_value,         //load value for timer     

    output reg NS_green , NS_yellow , NS_red,         //North-South traffic light
    output reg EW_green , EW_yellow , EW_red          //East-West traffic light
);

//State encoding
localparam s0 = 0 , s1 = 1 , s2 = 2 , s3 = 3 ;

reg [1:0] state_reg , state_next;

//for solving the problem of load signal pulse during reset
reg initial_load;            //Ensures load signal is pulsed once after reset
reg timer_loaded;            //Prevents the FSM from transitioning states before the timer is loaded

//======================State Register=========================
always @(posedge clk or negedge rstn) begin
    if(~rstn) begin
        state_reg <= s0;
        initial_load <= 1'b1;
        timer_loaded <= 1'b0;
    end
    else begin
        state_reg <= state_next;
        if(initial_load)
            initial_load <= 1'b0;
        if(load)
            timer_loaded <= 1'b1;
    end
end


//======================Next State Logic======================
always @(*) begin
    state_next = state_reg;
    load_value = 'd10;

    case (state_reg)
    //------------------Green North-South State------------------
        s0 : begin
            load_value = 'd10;
            if (done && timer_loaded)begin
                state_next = s1;
                load_value = 'd3;
            end
        end 


    //------------------Yellow North-South State------------------
        s1 : begin
            load_value = 'd3;
            if(done && timer_loaded)begin
                state_next = s2;
                load_value = 'd10;
            end
        end

    //------------------Green East-West State------------------
        s2 : begin
            load_value = 'd10;
            if (done && timer_loaded)begin
                state_next = s3;
                load_value = 'd3;
            end
        end

    //------------------Yellow East-West State------------------
        s3 : begin
            load_value = 'd3;
            if(done && timer_loaded)begin
                state_next = s0;
                load_value = 'd10;
            end
        end
        default: state_next = s0;
    endcase

    // Pulse load signal when state changes or during initial load
    if((state_next != state_reg) || initial_load)
        load = 1'b1;
    else 
        load = 1'b0;

end


//======================Output Logic==========================
always @( *) begin
    case (state_reg)
        s0 : begin
            NS_green = 1'b1; NS_yellow = 1'b0; NS_red = 1'b0;
            EW_green = 1'b0; EW_yellow = 1'b0; EW_red = 1'b1;
        end 

        s1 : begin
            NS_green = 1'b0; NS_yellow = 1'b1; NS_red = 1'b0;
            EW_green = 1'b0; EW_yellow = 1'b0; EW_red = 1'b1;
        end

        s2 : begin
            NS_green = 1'b0; NS_yellow = 1'b0; NS_red = 1'b1;
            EW_green = 1'b1; EW_yellow = 1'b0; EW_red = 1'b0;
        end

        s3 : begin
            NS_green = 1'b0; NS_yellow = 1'b0; NS_red = 1'b1;
            EW_green = 1'b0; EW_yellow = 1'b1; EW_red = 1'b0;
        end 
    endcase
end


endmodule //Traffic_light_controller_FSM