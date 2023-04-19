module gameVoice(
    input clk_vga,
    output reg voi,//输出的声音
    input [1:0]gameover_voi,//游戏结束声音
    input voi1,//3个不同的声音
    input voi2,
    input voi3
);
reg [20:0]cnt=0;//有关不同音调的频率
reg [3:0]sta=0;//状态机
reg [28:0]wait_time=0;//等待时间
always @(posedge clk_vga)
begin
    if(wait_time>=22000000)
        sta<=0;
    else if(gameover_voi==1||sta==1)
        sta<=1;
    else if(voi1==1||sta==2)
        sta<=2;
    else if(voi2==1||sta==3)
        sta<=3;
    else if(voi3==1||sta==4)
        sta<=4;
    else 
        sta<=0;
end

always @(posedge clk_vga) //相加计算需要出声的时间
begin
    if(sta==0)
        wait_time<=0;
    else
    begin
        wait_time<=wait_time+1;
        if(wait_time>=22000000)
            wait_time<=0;
    end
end

always @(posedge clk_vga)//不同的状态输出不同的声音
begin
    case (sta)
        0:
        begin
            voi<=0;
            cnt<=0;
        end
        1:
        begin
            if(cnt<=47709)
                voi<=1;
            else
                voi<=0;
            if(cnt>=95419)
                cnt<=0;
            else
                cnt<=cnt+1;
        end
        2:
        begin
            if(cnt<=21294)
                voi<=1;
            else
                voi<=0;
            if(cnt>=42589)
                cnt<=0;
            else
                cnt<=cnt+1;
        end
        3:
        begin
            if(cnt<=18968)
                voi<=1;
            else
                voi<=0;
            if(cnt>=37936)
                cnt<=0;
            else
                cnt<=cnt+1;
        end
        4:
        begin
            if(cnt<=17908)
                voi<=1;
            else
                voi<=0;
            if(cnt>=35816)
                cnt<=0;
            else
                cnt<=cnt+1;
        end
        default:
            begin
                cnt<=0;
                voi<=0;
            end
    endcase
end
endmodule