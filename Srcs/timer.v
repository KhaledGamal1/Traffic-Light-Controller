module timer 
    #(parameter WIDTH = 4)
(
    input clk, rstn,
    input load, enable,
    input [WIDTH -1 :0] load_value,
    output [WIDTH -1 :0] timer_count,
    output done
);

reg [WIDTH-1 :0] Q_reg , Q_next;

//State register
always @(posedge clk or negedge rstn) begin
    if(!rstn)
        Q_reg <= 0;
    else
        Q_reg <= Q_next;
end

//Next state logic
always @(*) begin
    if(load)
        Q_next = load_value;
    else if (enable && Q_reg != 0)
        Q_next = Q_reg - 1;
    else 
        Q_next = Q_reg;
end

//output logic
assign done = (Q_reg==0) && enable;
assign timer_count = Q_reg;

endmodule //timer