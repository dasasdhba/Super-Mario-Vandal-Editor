# 简介

**Super Mario Vandal Editor** 是由 **dasasdhba** 基于 ***Gamemaker 8.2*** 开发的 *Mario Forever* 制作模板。

**Q**：***Gamemaker 8.2*** 为何物？
**A**：一个基于 *Gamemaker 8.1* 的民间修改版，最大的亮点在于其 *gm82* 的文件格式，将所有的资源分类保存于各个文件夹中，非常方便手动修改。这种文件格式给使用第三方编辑器如 *Tiled* 进行关卡设计，甚至是将 *smwl* 文件转换为 *gm82* 的 *room* 提供了可能。

**Q**：使用此模板进行开发制作有何优劣？
**A**：

* 优势：编程比较方便，能全局地把握一些东西，关卡设计在某些方面也更方便；
* 劣势：门槛较高，图层的支持较差，改参数在不熟悉的情况下很不方便，编辑设计有时候不够直观。

**Q**：我如何获取 ***Gamemaker 8.2***？
**A**：官方还没有推出公开版本，目前仍在 *discord* 进行开发和测试工作。

**Q**：这个模板对 **MF** 原版的还原度如何？
**A**：整体上会与 **Super Mario Ultra Edition Rainbow** 相似，而且可能会更稳定一些。

**Q**：为什么音乐和音效文件都外置了，不怕被修改吗？
**A**：*Gamemaker 8* 原生音频系统不支持 *ogg* 格式，外置是比较好的选择。至于防修改，目前编写了一套简略的防修改系统，通过 **debug mode** 运行游戏将会在 *.\Data* 目录下生成一个 *check.dat* 文件用于检查文件是否被修改。 目前也内置了一套外置音频加密的功能，不过默认不启用。

**Q**：为什么要打开 *Treat uninitialized variables as value 0*？
**A**：我怀疑这个是误报，没办法。这个功能主要是防止你手抖打错变量名用的（确实很好用），所以排查 bug 的时候可以先关一下看看 *error log*，总的来说影响不大。

**Q**：这个项目什么时候能做完？
**A**：咕咕咕~

# 说明

## 不支持旋转的物件

一些物件被旋转可能会改变其属性，如重力方向等，而下列是一些**不支持旋转的物件**：

* 终点杆
* 封顶砖
* 弹簧
* 大片水面/岩浆
* 刺猬云
* 电珊瑚
* 布布鬼
* 探照灯
* 游鱼/飞鱼生成器
* 金飞龟圈生成器

# Credits

## 程序

* ***Gamemaker 8.2 Ultimate*** Created by **renex & Floogle**
* ***FMOD Sound System*** by **Firelight Technologies Pty, Ltd.**
* ***MageINI*** by **Mage松仁玉米**
* ***CleanMem.dll*** by **Halo Shg**
* ***DX8 to DX9 Convertor*** by **ENBSeries**
* Some scripts from **GMLscripts.com**
* Other main scripts by **dasasdhba**

## 素材

* 部分素材取自基于 ***Clickteam Fusion*** 的 ***Rainbow Engine*** by **lyh**
* 部分贴图和背景取自 ***Super Mario Worker Project*** by **Innovation Leap**
* HUD 字体，分数字体，命数字体 by **电童·Isamo（马里奥x7）**
* 编辑物件贴图部分取自 ***Carldron Engine*** by **电童·Isamo（马里奥x7）**，其他 by **dasasdhba**

## 音频

* ***Super Mario World***
* ***New Super Mario Bros.***
* ***Mario Forever***
