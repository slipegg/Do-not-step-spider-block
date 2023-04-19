# Do-not-step-spider-block

同济大学数字逻辑的大作业，使用了VGA，蓝牙，7短数码管，蜂鸣器这4个外设，使用Verilog语言在NEXYS 4 DDR Atrix-7开发板上完成的与别踩白块游戏规则相同的游戏——别踩蜘蛛块。

这是当时刚接触到Verilog语言所写的代码，所以质量肯定有些不堪入目，但是完成度还是可以的。

![image](https://user-images.githubusercontent.com/65942634/233048577-8fe5d549-b922-4e15-832c-d333d6f0ef00.png)

![image](https://user-images.githubusercontent.com/65942634/233048634-a7eb116c-0f79-463b-9306-edd5f023e7d8.png)

# 设计框架

游戏流程：

![image](https://user-images.githubusercontent.com/65942634/233050611-a1c619ac-b07a-4130-8085-eb8c78e3b280.png)

总体框架图：

![image](https://user-images.githubusercontent.com/65942634/233048710-14627161-43f9-4185-820c-b0e88d43ebbf.png)

vivado中的模拟电路图：

![image](https://user-images.githubusercontent.com/65942634/233050797-2abb9d0f-9abd-4bc1-8531-49573865dd85.png)

# 运行结果

游戏开始界面：

![image](https://user-images.githubusercontent.com/65942634/233051142-80475a4f-46cc-4857-a187-c31b2a3f8266.png)

![image](https://user-images.githubusercontent.com/65942634/233051208-ad127d43-679b-4f89-81ae-c985aa2e8e37.png)

![image](https://user-images.githubusercontent.com/65942634/233051222-aa6f8b8f-c526-4f3b-98f6-cb4a25be2594.png)

选择游戏模式或者重置游戏后开始游戏：

![image](https://user-images.githubusercontent.com/65942634/233051255-2a33459a-d186-450f-9d92-ec2cfcdb56b4.png)

在蜘蛛块接触到了最下沿的时候点击对应的十字按钮的键，就可以消除，并且会在对应的底部出现图片，共3张：

![image](https://user-images.githubusercontent.com/65942634/233051301-616e07a8-1e0f-4ff8-bdc0-2ad380258dcb.png)

![image](https://user-images.githubusercontent.com/65942634/233051325-57ba9ef6-8e32-496c-a662-eb00d8bd4d84.png)

![image](https://user-images.githubusercontent.com/65942634/233051347-2bc14033-3076-4995-8793-54c449955f6c.png)

如果没有在对应的时候按下按键，让蜘蛛块划过或者提前按了，都是使得游戏失败，失败后无蜘蛛块滑落，分数显示不动：

![image](https://user-images.githubusercontent.com/65942634/233051403-50450ba9-d2ec-4442-8b2c-4a420e663858.png)

![image](https://user-images.githubusercontent.com/65942634/233051453-1259b88a-0dce-4fdf-a6ee-31f86374efba.png)

再开始游戏需要将底部按钮最左边上拉，再下拉。将底部按钮最右边上拉会将VGA熄屏，游戏停止。

还有声音会根据按键或游戏结束而发出。

![image](https://user-images.githubusercontent.com/65942634/233051520-8f8565d8-c5bd-47b8-9ec5-11b4cc4969ac.png)

