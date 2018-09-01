# Jump
微信小游戏**跳一跳**脚本

## 文件说明
* `a.lua`: 用于测试各种函数和其它东西的脚本
* `jump.log`: 日志文件
* `main.lua`: 真正的跳一跳脚本文件
* `README.md`: 本文档

## 使用说明
测试平台： 雷电模拟器，`Android5.1`，分辨率设置为`720*1280`

安卓模拟器使用比较简单，安卓手机使用需要先`root`（现在的手机想`root`越来越困难了）。即便如此，下面依然将会给出两种方法: **使用安卓手机**和**使用雷电安卓模拟器**。夜神模拟器因未知原因无法运行微信小游戏（即便使用`Android5.1`）

### 使用安卓手机
这部分并未测试，写得也比较简洁，且仅支持`720*1280`分辨率的手机，故仅供参考
1. `root`。这个步骤可能很简单也可能相当复杂，大家自行尝试
2. 安装**触动精灵**。
3. 下载本项目的ZIP文件到电脑：<https://github.com/wsxq2/jump/archive/master.zip>
4. 解压下载的ZIP文件, 将其中的`main.lua`通过各种方法发送到手机（如使用数据线，使用QQ等），并将其移动到`/sdcard/TouchSprite/lua`目录中
5. 打开模拟器中的**触动精灵**，点击左上角的`+`号，选择**导入文件**，勾选`main.lua`，点击**导入**，回到**我的脚本**后，然后勾选`main.lua`以准备启动该脚本，然后点击**更多**，打开**悬浮窗**
6. 进入微信跳一跳，点击**开始游戏**后在打开的**悬浮窗**中点击**播放按钮**。

### 使用雷电安卓模拟器
1. 下载雷电安卓模拟器：<http://www.ldmnq.com>
2. 安装并打开雷电安卓模拟器，点击雷电模拟器右边的**设置**，将分辨率设置为**手机版**`720*1280`。然后在模拟器里面安装**触动精灵**（使用自带的**雷电游戏中心**即可）；也可以在电脑上下载相应的APK文件拖入到模拟器中。
3. 下载本项目的ZIP文件到电脑：<https://github.com/wsxq2/jump/archive/master.zip>
4. 解压下载的ZIP文件, 将其中的`main.lua`拖入到已打开的雷电模拟器中，并将其移动到`/sdcard/TouchSprite/lua`目录中(使用它自带的文件管理器即可：选中已拖入到雷电模拟器中的`main.lua`文件，然后直接到指定目录中点击**选项**，**粘贴选择项**即可)
5. 打开模拟器中的**触动精灵**，点击左上角的`+`号，选择**导入文件**，勾选`main.lua`，点击**导入**，回到**我的脚本**后，然后勾选`main.lua`以准备启动该脚本，然后点击**更多**，打开**悬浮窗**
6. 进入微信跳一跳，点击**开始游戏**后在打开的**悬浮窗**中点击**播放按钮**。


## 我的学习笔记
在我的个人博客里：<https://wsxq2.55555.io/blog/2018/08/23/TouchSprite%E8%84%9A%E6%9C%AC%E7%AC%94%E8%AE%B0/>
