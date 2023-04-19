module bluetooth(
    input clk,
    input rst,
    input get,//读取的信号
    output reg [7:0] out=49,//输出信号，对应的是ASCII码
    output reg is_chooose=0
);
parameter bps=2605;//对应9600波特，用25M/9600
reg [14:0] count_1;//每一位中的计数器
reg [3:0] count_2;//每一组数据的计数
reg buffer_0,buffer_1,buffer_2;//除去滤波
wire buffer_en;//检测边沿
reg add_en;//加法使能信号

always @ (posedge clk)
begin
    if(rst)
    begin
        buffer_0<=1;
        buffer_1<=1;
        buffer_2<=1;
    end
    else
    begin
        buffer_0<=get;
        buffer_1<=buffer_0;
        buffer_2<=buffer_1;
    end
end

assign buffer_en=buffer_2&~buffer_1;//1说明检测到信号边缘

always @ (posedge clk)
begin
    if(rst)
    begin
        add_en<=0;
    end
    else if(buffer_en)
    begin
        add_en<=1;//说明可以开始相加
    end
    else if(add_en&&count_2==8&&count_1==bps-1)//已经读取到了对应的8个字符
    begin
        add_en<=0;
    end
end

always @ (posedge clk)
begin
    if(rst)
    begin
        count_1<=0;
    end
    else if(add_en)
    begin
        if(count_1==bps-1)//读取了一个字的信号
        begin
            count_1<=0;
        end
        else
        begin
            count_1<=count_1+1;
        end
    end
end

always @ (posedge clk)
begin
    if(rst)
    begin
        count_2<=0;
    end
    else if(add_en&&count_1==bps-1)//读取了一个字的信号
    begin
        if(count_2==8)//读取完了8个
        begin
            count_2<=0;
        end
        else
        begin
            count_2<=count_2+1;
        end
    end
end

always @ (posedge clk)
begin
    if(rst)
    begin
        out<=0;
    end
    else if(add_en&&count_1==bps/2-1&&count_2!=0)//到中间的时候进行数据读取
    begin
        out[count_2-1]<=get;
    end
end

always @(posedge clk) 
begin
    if(count_2==8&&is_chooose==0)//读取了8个信号说明读取完毕了
    begin
        is_chooose<=1;
    end
    else if(is_chooose==0)
    begin
        is_chooose<=0;
    end

    if(is_chooose==1)
    begin
        is_chooose<=0;
    end
end

endmodule