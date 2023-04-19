module y_top_state(
    input clk_vga,//25M
    input in1,//3个按钮
    input in2,
    input in3,
    input game_rst,//游戏重新开始
    input [7:0]game_level,//游戏模式
    input game_level_choose,//游戏等级
    output [12:0] ytop1,//输出3个蜘蛛块的上方坐标
    output [12:0] ytop2,
    output [12:0] ytop3,
    output reg black_chose1,//下方图片是否需要展示
    output reg black_chose2,
    output reg black_chose3,
    output [13:0]score,//分数
    output reg [1:0]gameover_voi=0,//4个声音
    output reg voi1=0,
    output reg voi2=0,
    output reg voi3=0
);
reg signed[12:0]yt1;
reg signed[12:0]yt2;
reg signed[12:0]yt3;

reg [28:0]count=0;

reg [2:0]sta1=2;//3个蜘蛛块的y坐标
reg [2:0]sta2=2;
reg [2:0]sta3=2;

reg in1t=0;//按键的对应状态机需要的
reg in2t=0;
reg in3t=0;

reg [1:0]in1u=0;
reg [1:0]in2u=0;
reg [1:0]in3u=0;

reg b_c_sta1=0;//下方块展示状态
reg [28:0]b_c_count1=0;//下方块展示的时间
reg b_c_sta2=0;
reg [28:0]b_c_count2=0;
reg b_c_sta3=0;
reg [28:0]b_c_count3=0;

reg [13:0]rescore=0;//分数

reg [63:0]random_top=64'h82cb49afde7982c6;//y坐标每次刷新的随机数
always @(in1)
begin
    if(in1==0)
        in1t<=0;
    if(in1==1)
        in1t<=1;
end

always @(in2)
begin
    if(in2==0)
        in2t<=0;
    if(in2==1)
        in2t<=1;
end

always @(in3)
begin
    if(in3==0)
        in3t<=0;
    if(in3==1)
        in3t<=1;
end

always @(posedge clk_vga)
begin
    if(in1t==1&&in1u==0)
        in1u<=1;
    if(in1t==1&&in1u==1)
        in1u<=2;
    if(in1t==1&&in1u==2)
        in1u<=2;
    if(in1t==0&&in1u==2)
        in1u<=0;
    if(in1t==0&&in1u==0)
        in1u<=0;
end

always @(posedge clk_vga)
begin
    if(in2t==1&&in2u==0)
        in2u<=1;
    if(in2t==1&&in2u==1)
        in2u<=2;
    if(in2t==1&&in2u==2)
        in2u<=2;
    if(in2t==0&&in2u==2)
        in2u<=0;
    if(in2t==0&&in2u==0)
        in2u<=0;
end

always @(posedge clk_vga)
begin
    if(in3t==1&&in3u==0)
        in3u<=1;
    if(in3t==1&&in3u==1)
        in3u<=2;
    if(in3t==1&&in3u==2)
        in3u<=2;
    if(in3t==0&&in3u==2)
        in3u<=0;
    if(in3t==0&&in3u==0)
        in3u<=0;
end

always@ (posedge clk_vga)
begin
    count<=count+1;
    if(count>((game_level-48)*103600))//(game_level-48)))307200
    begin
        count<=0;
    end
end

always @(posedge clk_vga) 
begin
    if(game_rst||game_level_choose)
    begin
        sta1<=0;
    end
    else
    begin
        if(yt1>=515||sta1==2)
        begin
            sta1<=2;
        end
        else
        begin
            if(in1u==1&&yt1>=415)
                sta1<=0;
            else
            begin
                if(in1u==1&&yt1<415)
                begin
                    sta1<=2;
                end
                else
                begin
                if(count==0)
                    sta1<=1;
                else
                    sta1<=3;
                end
            end
        end
    end    
end

always @(posedge clk_vga) 
begin
    if(game_rst||game_level_choose)
    begin
        sta2<=0;
    end
    else
    begin
        if(yt2>=515||sta2==2)
        begin
            sta2<=2;
        end
        else
        begin
            if(in2u==1&&yt2>=415)
                sta2<=0;
            else
            begin
                if(in2u==1&&yt2<415)
                begin
                    sta2<=2;
                end
                else
                begin
                if(count==0)
                    sta2<=1;
                else
                    sta2<=3;
                end
            end
        end
    end    
end

always @(posedge clk_vga) 
begin
    if(game_rst||game_level_choose)
    begin
        sta3<=0;
    end
    else
    begin
        if(yt3>=515||sta3==2)
        begin
            sta3<=2;
        end
        else
        begin
            if(in3u==1&&yt3>=415)
                sta3<=0;
            else
            begin
                if(in3u==1&&yt3<415)
                begin
                    sta3<=2;
                end
                else
                begin
                    if(count==0)
                        sta3<=1;
                    else
                        sta3<=3;
                end
            end
            
        end
    end    
end


always @(posedge clk_vga) 
begin
    if(sta1==2||sta2==2||sta3==2)
    begin
        yt1<=(random_top[63:56]+235)%235-300;//({$random} %235)-200;
        yt2<=(random_top[55:48]+235)%235-300;
        yt3<=(random_top[47:40]+235)%235-300;
        //rescore<=0;
    end
    else
    begin
        if((sta1==0&&sta2!=0&&sta3!=0)||(sta1!=0&&sta2==0&&sta3!=0)||(sta1!=0&&sta2!=0&&sta3==0))
        begin
            rescore<=rescore+1;
        end
        else if((sta1==0&&sta2==0&&sta3!=0)||(sta1!=0&&sta2==0&&sta3==0)||(sta1==0&&sta2!=0&&sta3==0))
            rescore<=rescore+2;
        else if(sta1==0&&sta2==0&&sta3==0)
            rescore<=0;//rescore+3;
        
        case (sta1)
        0:
        begin
            yt1<=(random_top[63:56]+235)%235-300;
        end
        1:
        begin
            yt1<=yt1+1;
        end
        3:
        begin
            yt1<=yt1;
        end
        default:
            yt1<=(random_top[63:56]+235)%235-300;
        endcase

        case (sta2)
        0:
        begin
            yt2<=(random_top[55:48]+235)%235-300;
        end
        1:
        begin
            yt2<=yt2+1;
        end
        3:
        begin
            yt2<=yt2;
        end
        default:
            yt2<=(random_top[55:48]+235)%235-300;
        endcase

        case (sta3)
        0:
        begin
            yt3<=(random_top[47:40]+235)%235-300;
            random_top={random_top[0],random_top[63:1]};
        end
        1:
        begin
            yt3<=yt3+1;
        end
        3:
        begin
            yt3<=yt3;
        end
        default:
            yt3<=0;
        endcase
    end
end

always @(posedge clk_vga)
begin
    if(sta1==2||sta2==2||sta3==2||b_c_count1>=12000000)
    begin
        b_c_sta1<=0;
    end
    else
    begin
        if(in1u==1||b_c_sta1==1)
        begin
            b_c_sta1<=1;
        end
    end
end

always @(posedge clk_vga)
begin
    if(b_c_sta1==0)
    begin
        b_c_count1<=0;
    end
    else
    begin
        if(b_c_sta1==1)
        begin
            b_c_count1<=b_c_count1+1;
            if(b_c_count1>12000000)
            begin
                b_c_count1<=0;
            end
        end
    end
end

always @(posedge clk_vga)
begin
    case(b_c_sta1)
    0:
    begin
        black_chose1<=0;
    end
    1:
    begin
        black_chose1<=1;
    end
    endcase
end
////
always @(posedge clk_vga)
begin
    if(sta1==2||sta2==2||sta3==2||b_c_count2>=12000000)
    begin
        b_c_sta2<=0;
    end
    else
    begin
        if(in2u==1||b_c_sta2==1)
        begin
            b_c_sta2<=1;
        end
    end
end

always @(posedge clk_vga)
begin
    if(b_c_sta2==0)
    begin
        b_c_count2<=0;
    end
    else
    begin
        if(b_c_sta2==1)
        begin
            b_c_count2<=b_c_count2+1;
            if(b_c_count2>12000000)
            begin
                b_c_count2<=0;
            end
        end
    end
end

always @(posedge clk_vga)
begin
    case(b_c_sta2)
    0:
    begin
        black_chose2<=0;
    end
    1:
    begin
        black_chose2<=1;
    end
    endcase
end

always @(posedge clk_vga)
begin
    if(sta1==2||sta2==2||sta3==2||b_c_count3>=12000000)
    begin
        b_c_sta3<=0;
    end
    else
    begin
        if(in3u==1||b_c_sta3==1)
        begin
            b_c_sta3<=1;
        end
    end
end

always @(posedge clk_vga)
begin
    if(b_c_sta3==0)
    begin
        b_c_count3<=0;
    end
    else
    begin
        if(b_c_sta3==1)
        begin
            b_c_count3<=b_c_count3+1;
            if(b_c_count3>12000000)
            begin
                b_c_count3<=0;
            end
        end
    end
end

always @(posedge clk_vga)
begin
    case(b_c_sta3)
    0:
    begin
        black_chose3<=0;
    end
    1:
    begin
        black_chose3<=1;
    end
    endcase
end

always @(posedge clk_vga) 
begin
    if(gameover_voi==2&&(sta1!=2&&sta2!=2&&sta3!=2))
        gameover_voi<=0;
    else if(gameover_voi==2)
        gameover_voi<=2;
    else if(gameover_voi==1)
        gameover_voi<=2;
    else if(sta1==2||sta2==2||sta3==2)
        gameover_voi<=1;

        if(in1u==1)
            voi1<=1;
        else
            voi1<=0;
        if(in2u==1)
            voi2<=1;
        else
            voi2<=0;
        if(in3u==1)
            voi3<=1;
        else
            voi3<=0;
    
end

assign score = rescore;
assign ytop1 = yt1;
assign ytop2 = yt2;
assign ytop3 = yt3;
endmodule