module clk_divider 
    #(parameter DIV = 50_000_000 )
(
    input clk_100MHz , rstn ,
    output reg clk_1Hz
);

reg [$clog2(DIV) -1 : 0] count;     

always @(posedge clk_100MHz or negedge rstn) begin
    if(~rstn)begin
        clk_1Hz <= 1'b0;
        count <= 0;
    end
    else if (count == DIV -1)begin
        count <= 0 ;
        clk_1Hz <= ~clk_1Hz;
    end
    else 
        count <= count +1;
end

endmodule //clk_divider