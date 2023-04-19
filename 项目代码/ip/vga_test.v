module show_test(
    input clk_vga,//输入vga的时钟，频率为25Mhz
    input rst,//复位信号，高电平有效
    output x_valid,//x方向有效
    output y_valid,//y方向有效
    output reg[3:0] red,//对应输出给vga的rgb值
    output reg[3:0] blue,
    output reg[3:0] green,
    input [11:0]rgb,//背景图的rgb
    output reg [20:0]addr=1,//背景图的像素地址
    input [12:0] ytop1,//蜘蛛块的最上方y坐标
    input [12:0] ytop2,
    input [12:0] ytop3,
    input black_chose1,//下方是否要出现对应的图片
    input black_chose2,
    input black_chose3,
    input [11:0]zz_rgb1,//蜘蛛块的rgb
    input [11:0]zz_rgb2,
    input [11:0]zz_rgb3,
    input [3:0]jin_rgb1,////下方图片的rgb值
    input [3:0]jin_rgb2,
    input [3:0]jin_rgb3,
    output reg [20:0]zz_addr1=1,//蜘蛛块的像素地址
    output reg [20:0]zz_addr2=1,
    output reg [20:0]zz_addr3=1,
    output reg [20:0]jin_addr1=1,//下方图片的地址
    output reg [20:0]jin_addr2=1,
    output reg [20:0]jin_addr3=1
);
    wire [11:0] x_poi;//输出此时x的坐
    wire [11:0] y_poi;//输出此时y的坐
    wire is_display;//表征此时是否能够输出

    parameter witehigh=100;//块的高

    parameter [10:0] witex1=164;//上个蜘蛛块的左边的x坐标
    parameter [10:0] witex2=364;
    parameter [10:0] witex3=564;
    parameter [10:0] witewide=160;

    parameter [10:0] y_bottom=415;//底部的块的上边的坐标

    vga_control control(clk_vga,rst,x_poi,y_poi,is_display,x_valid,y_valid);//控制vga

    always @(posedge clk_vga)//根据优先级显示图片，先是判断是否是底部图片，再判断是否是蜘蛛块图片，再不是就放入背景图片
    begin
        red<=0;
        blue<=0;
        green<=0;
        if(is_display)
        begin
            if(black_chose1==1&&x_poi>=witex1&&x_poi<witex1+witewide&&y_poi>=y_bottom&&y_poi<y_bottom+witehigh)//
            begin
                red <=jin_rgb1;//底部图片放入的是黑白图
                blue <=jin_rgb1;
                green <=jin_rgb1;
                if(jin_addr1==1599)
                    jin_addr1<=0;
                else
                    jin_addr1<=(x_poi-witex1)+(y_poi-y_bottom)*witewide+1;
            end
            else
            begin
                if(black_chose2==1&&x_poi>=witex2&&x_poi<witex2+witewide&&y_poi>=y_bottom&&y_poi<y_bottom+witehigh)//
                begin
                    red <=jin_rgb2;
                    blue <=jin_rgb2;
                    green <=jin_rgb2;
                    if(jin_addr2==1599)
                        jin_addr2<=0;
                    else
                        jin_addr2<=(x_poi-witex2)+(y_poi-y_bottom)*witewide+1;
                end
                else
                begin
                    if(black_chose3==1&&x_poi>=witex3&&x_poi<witex3+witewide&&y_poi>=y_bottom&&y_poi<y_bottom+witehigh)//
                    begin
                        red <=jin_rgb3;
                        blue <=jin_rgb3;
                        green <=jin_rgb3;
                        if(jin_addr3==1599)
                            jin_addr3<=0;
                        else
                            jin_addr3<=(x_poi-witex3)+(y_poi-y_bottom)*witewide+1;
                    end
                    else
                    begin
                        if(x_poi>=witex1&&x_poi<witex1+witewide&&y_poi>=ytop1&&y_poi<ytop1+witehigh)//
                        begin
                            red[3]<=zz_rgb1[11];
                            red[2]<=zz_rgb1[10];
                            red[1]<=zz_rgb1[9];
                            red[0]<=zz_rgb1[8];
                            green[3]<=zz_rgb1[7];
                            green[2]<=zz_rgb1[6];
                            green[1]<=zz_rgb1[5];
                            green[0]<=zz_rgb1[4];
                            blue[3]<=zz_rgb1[3];
                            blue[2]<=zz_rgb1[2];
                            blue[1]<=zz_rgb1[1];
                            blue[0]<=zz_rgb1[0];
                            if(zz_addr1==1599)
                                zz_addr1<=0;
                            else
                                zz_addr1<=(x_poi-witex1)+(y_poi-ytop1)*witewide+1;
                        end
                        else
                        begin
                            if(x_poi>=witex2&&x_poi<witex2+witewide&&y_poi>=ytop2&&y_poi<ytop2+witehigh)//
                            begin
                                red[3]<=zz_rgb2[11];
                                red[2]<=zz_rgb2[10];
                                red[1]<=zz_rgb2[9];
                                red[0]<=zz_rgb2[8];
                                green[3]<=zz_rgb2[7];
                                green[2]<=zz_rgb2[6];
                                green[1]<=zz_rgb2[5];
                                green[0]<=zz_rgb2[4];
                                blue[3]<=zz_rgb2[3];
                                blue[2]<=zz_rgb2[2];
                                blue[1]<=zz_rgb2[1];
                                blue[0]<=zz_rgb2[0];
                                if(zz_addr2==1599)
                                    zz_addr2<=0;
                                else
                                    zz_addr2<=(x_poi-witex2)+(y_poi-ytop2)*witewide+1;
                            end
                            else
                            begin
                                if(x_poi>=witex3&&x_poi<witex3+witewide&&y_poi>=ytop3&&y_poi<ytop3+witehigh)//
                                begin
                                    red[3]<=zz_rgb3[11];
                                    red[2]<=zz_rgb3[10];
                                    red[1]<=zz_rgb3[9];
                                    red[0]<=zz_rgb3[8];
                                    green[3]<=zz_rgb3[7];
                                    green[2]<=zz_rgb3[6];
                                    green[1]<=zz_rgb3[5];
                                    green[0]<=zz_rgb3[4];
                                    blue[3]<=zz_rgb3[3];
                                    blue[2]<=zz_rgb3[2];
                                    blue[1]<=zz_rgb3[1];
                                    blue[0]<=zz_rgb3[0];
                                    if(zz_addr3==1599)
                                        zz_addr3<=0;
                                    else
                                        zz_addr3<=(x_poi-witex3)+(y_poi-ytop3)*witewide+1;
                                end
                                else
                                begin
                                    red[3]<=rgb[11];
                                    red[2]<=rgb[10];
                                    red[1]<=rgb[9];
                                    red[0]<=rgb[8];
                                    green[3]<=rgb[7];
                                    green[2]<=rgb[6];
                                    green[1]<=rgb[5];
                                    green[0]<=rgb[4];
                                    blue[3]<=rgb[3];
                                    blue[2]<=rgb[2];
                                    blue[1]<=rgb[1];
                                    blue[0]<=rgb[0];
                                end
                            end
                        end
                    end
                end
            end
            addr=addr+1;
            if(addr>307200)
                addr=1;
        end
    end
endmodule