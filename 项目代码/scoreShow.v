module scoreShow(
    input clk_vga,
    input [13:0]score,//分数
    output reg[6:0]seg_data, //七段数码管
    output reg[7:0]seg_sel//选择哪些是亮的
);
reg [3:0]score_ones=0;//分数的个位数
reg [3:0]score_tens=0;//分数的十位数
reg [3:0]score_hund=0;//分数的百位数
reg [3:0]score_thou=0;//分数的千位数

reg [15:0]cnt=0;
reg [3:0]data;

always@(posedge clk_vga)
begin
    begin
        cnt<=cnt+1;
        if(cnt>=4000)
            cnt<=0;
    end
end

always@(posedge clk_vga) 
begin
    score_ones<=score%10;
    score_tens<=(score/10)%10;
    score_hund<=(score/100)%10;
    score_thou<=(score/1000)%10;
end

always@(posedge clk_vga) 
begin
    begin
        if(cnt<=1000)//cnt在不同的值亮不同的管
        begin
            seg_sel<=8'b11111110;
            data<=score_ones;
		end
		else if(cnt<=2000)
        begin
            seg_sel<=8'b11111101;
            data<=score_tens;
		end
		else if(cnt<=3000)
        begin
            seg_sel<=8'b11111011;
            data<=score_hund;
        end
		else if(cnt<=4000)
        begin
            seg_sel<=8'b11110111;
            data<=score_thou;
		end
        case (data)//展示对应的数字
            4'd0:seg_data <= 7'b1000000;
            4'd1:seg_data <= 7'b1111001;
            4'd2:seg_data <= 7'b0100100;
            4'd3:seg_data <= 7'b0110000;
            4'd4:seg_data <= 7'b0011001;
            4'd5:seg_data <= 7'b0010010;
            4'd6:seg_data <= 7'b0000010;
            4'd7:seg_data <= 7'b1111000;
            4'd8:seg_data <= 7'b0000000;
            4'd9:seg_data <= 7'b0010000;
            default:
            seg_data <= 7'b1111111;
        endcase
    end
end
endmodule