module two_digit_display (
    input clk , rstn,
    input [3:0] value,
    output reg [6:0] seg,
    output reg [1:0] an
);

always @(posedge clk or negedge rstn) begin
    if(~rstn)begin
        an <= 2'b11;
        seg <= 7'b1111111;
    end
    else
        case (value)
            4'd0 : begin
                seg <= 7'b1000000;
                an <= 2'b10;
            end 

            4'd1 : begin
                seg <= 7'b1111001;
                an <= 2'b10;
            end

            4'd2 : begin
                seg <= 7'b0100100;
                an <= 2'b10;
            end

            4'd3 : begin
                seg <= 7'b0110000;
                an <= 2'b10;
            end

            4'd4 : begin
                seg <= 7'b0011001;
                an <= 2'b10;
            end

            4'd5 : begin
                seg <= 7'b0010010;
                an <= 2'b10;
            end

            4'd6 : begin
                seg <= 7'b0000010;
                an <= 2'b10;
            end

            4'd7 : begin
                seg <= 7'b1111000;
                an <= 2'b10;
            end

            4'd8 : begin
                seg <= 7'b0000000;
                an <= 2'b10;
            end

            4'd9 : begin
                seg <= 7'b0010000;
                an <= 2'b10;
            end

            4'd10 : begin
                seg <= 7'b1000000;
                an <= 2'b01;
            end

            4'd11 : begin
                seg <= 7'b1111001;
                an <= 2'b01;
            end

            4'd12 : begin
                seg <= 7'b0100100;
                an <= 2'b01;
            end

            4'd13 : begin
                seg <= 7'b0110000;
                an <= 2'b01;
            end

            4'd14 : begin
                seg <= 7'b0011001;
                an <= 2'b01;
            end

            4'd15 : begin
                seg <= 7'b0010010;
                an <= 2'b01;
            end

            default: begin
                seg <= 7'b1111111;
                an <= 2'b11;
            end
        endcase
end


endmodule //two_digit_display