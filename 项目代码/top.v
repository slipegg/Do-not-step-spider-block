module top(
	input 	clk,
	input 	rst,
	input 	game_rst,
	input	in1,
	input	in2,
	input	in3,
	input	blue_get,
	output [3:0] red,
	output [3:0] blue,
	output [3:0] green,
	output x_valid,
	output y_valid,
	output [2:0]black_test,
	output [6:0]seg_data,
    output [7:0]seg_sel,
	output voi 
);

wire locked;
wire [11:0]rgb;
wire [20:0]addr;
wire isget1=0;
wire isget2=0;
wire isget3=0;
wire signed [12:0]ytop1;
wire signed [12:0]ytop2;
wire signed [12:0]ytop3;
wire is_chooose;
wire [7:0]game_level;
wire black_chose1;
wire black_chose2;
wire black_chose3;
assign black_test[0]=black_chose1;
assign black_test[1]=black_chose2;
assign black_test[2]=black_chose3;
wire [13:0]score;
wire [11:0]zz_rgb1;
wire [11:0]zz_rgb2;
wire [11:0]zz_rgb3;
wire [3:0]jin_rgb1;
wire [3:0]jin_rgb2;
wire [3:0]jin_rgb3;
wire [20:0]zz_addr1;
wire [20:0]zz_addr2;
wire [20:0]zz_addr3;
wire [20:0]jin_addr1;
wire [20:0]jin_addr2;
wire [20:0]jin_addr3;
wire [1:0]gameover_voi;
wire voi1;
wire voi2;
wire voi3;
bluetooth blue_t(clk_vga,rst,blue_get,game_level,is_chooose);
y_top_state y_state(clk_vga,in1,in2,in3,game_rst,game_level,is_chooose,ytop1,ytop2,ytop3,black_chose1,black_chose2,black_chose3,score,gameover_voi,voi1,voi2,voi3);
show_test test(clk_vga,rst,x_valid,y_valid,red,blue,green,rgb,addr,ytop1,ytop2,ytop3,black_chose1,black_chose2,black_chose3,zz_rgb1,zz_rgb2,zz_rgb3,jin_rgb1,jin_rgb2,jin_rgb3,zz_addr1,zz_addr2,zz_addr3,jin_addr1,jin_addr2,jin_addr3);
scoreShow scoreshow(clk_vga,score,seg_data,seg_sel);
clk_wiz_25_175	clk_wiz_25_175_inst (.reset (rst),.clk_in1(clk),.clk_out1 (clk_vga),.locked(locked));
pic_mem data(.clka(!clk_vga),.ena(1),.addra(addr),.douta(rgb));
zhizhu zz_mem1(.clka(!clk_vga),.ena(1),.addra(zz_addr1),.douta(zz_rgb1));
zhizhu zz_mem2(.clka(!clk_vga),.ena(1),.addra(zz_addr2),.douta(zz_rgb2));
zhizhu zz_mem3(.clka(!clk_vga),.ena(1),.addra(zz_addr3),.douta(zz_rgb3));
jin1 j1(.clka(!clk_vga),.ena(1),.addra(jin_addr1),.douta(jin_rgb1));
gameVoice voice(clk_vga,voi,gameover_voi,voi1,voi2,voi3);
jin2 j2(.clka(!clk_vga),.ena(1),.addra(jin_addr2),.douta(jin_rgb2));
jin3 j3(.clka(!clk_vga),.ena(1),.addra(jin_addr3),.douta(jin_rgb3));
endmodule 