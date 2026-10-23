<p align="center">
  <a href="https://github.com/Fliggy-Mobile">
    <img width="200" src="https://gw.alicdn.com/tfs/TB1a288sxD1gK0jSZFKXXcJrVXa-360-360.png">
  </a>
</p>

<h1 align="center">ftoast</h1>


<div align="center">

<p>简单、精美的 Toast</p>

<p>帮助开发者创建灵活的，简洁的，精美的 Toast</p>

<p><strong>主理人：<a href="https://github.com/chenBingX">纽特</a>(<a href="coorchice.cb@alibaba-inc.com">coorchice.cb@alibaba-inc.com</a>)</strong></p>
<p>

<a href="https://pub.dev/packages/ftoast#-readme-tab-">
    <img height="20" src="https://img.shields.io/badge/Version-2.1.0-important.svg">
</a>


<a href="https://github.com/Fliggy-Mobile/ftoast">
    <img height="20" src="https://img.shields.io/badge/Build-passing-brightgreen.svg">
</a>


<a href="https://github.com/Fliggy-Mobile">
    <img height="20" src="https://img.shields.io/badge/Team-FAT-ffc900.svg">
</a>

<a href="https://www.dartcn.com/">
    <img height="20" src="https://img.shields.io/badge/Language-Dart-blue.svg">
</a>

<a href="https://pub.dev/documentation/ftoast/latest/ftoast/ftoast-library.html">
    <img height="20" src="https://img.shields.io/badge/API-done-yellowgreen.svg">
</a>

<a href="http://www.apache.org/licenses/LICENSE-2.0.txt">
   <img height="20" src="https://img.shields.io/badge/License-Apache--2.0-blueviolet.svg">
</a>

<p>
<p>

</div>

![](https://gw.alicdn.com/tfs/TB1CdJ5ffzO3e4jSZFxXXaP_FXa-1466-562.png)

**[English](https://github.com/Fliggy-Mobile/ftoast) | 简体中文**

> 感觉还不错？请投出您的 **Star** 吧 🥰 ！

# ✨ 特性

- 提供便捷的方式创建  **Toast** 

- 支持主信息、副信息，以及自定义它们的样式

- 支持灵活多变的图标视图

- 支持配置边角大小、背景色

- 支持队列展示

- 支持配置 Toast 对齐位置（顶部 / 底部 / 任意位置）

- 支持忽略内容重复的 Toast

- 支持自定义 **Toast** 样式


# 🛠 使用指南

在 FToast 中，开发者只需要通过简单的代码就能轻松创建一个  **Toast** 。

```dart
FToast.toast(context, msg: "FToast");
```

## ⚙️ 参数

|参数|类型|必要|默认值|说明|
|---|---|:---:|---|---|
|context|BuildContext|true|null|页面环境|
|toast|Widget|false|null|自定义 toast 视图，会覆盖默认视图|
|msg|String|false|null|主信息|
|msgStyle|TextStyle|false|null|主信息文本样式|
|subMsg|String|false|null|副信息|
|subMsgStyle|TextStyle|false|null|副信息文本样式|
|subMsgSpace|double|false|12.0|副信息与主信息的间距|
|corner|double|false|6.0|边角|
|color|Color|false|Colors.black54|颜色|
|duration|double|false|1800|展示时长|
|padding|EdgeInsets|false|`EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0)`|内间距|
|image|Widget|false|null|图标|
|imageDirection|AxisDirection|false|AxisDirection.up|图标相对文本的位置|
|imageSpace|double|false|9.0|图标与文本的间距|
|alignment|Alignment|false|Alignment.center|Toast 在屏幕上的对齐位置|
|ignoreDuplicate|bool|false|false|忽略内容重复的 Toast（正在显示或在队列中时不再重复入队）|

## 🔩 基础使用

![](https://gw.alicdn.com/tfs/TB1YG.Mc8FR4u4jSZFPXXanzFXa-365-720.gif)

```dart
FToast.toast(
  context,

  /// 配置显示时长
  ///
  /// Configure display duration
  duration: 800,

  /// 配置 Msg
  ///
  /// set Msg
  msg: "I'm FToast: ${count++}",

  /// 配置 Msg 样式
  ///
  /// set Msg style
  msgStyle: TextStyle(color: Colors.white),
)
```

## 🔆 副信息

![](https://gw.alicdn.com/tfs/TB1b0.5NQT2gK0jSZFkXXcIQFXa-365-720.gif)

```dart
FToast.toast(
  context,
  msg: "This is Msg",

  /// 配置 subMsg
  ///
  /// set subMsg
  subMsg: "Welcome to use FToast. This is subMsg!",

  /// 配置 SubMsg 样式
  ///
  /// set SubMsg style
  subMsgStyle: TextStyle(color: Colors.white, fontSize: 13),
)
```

## 🔳 图标

![](https://gw.alicdn.com/tfs/TB13JPNbZVl614jSZKPXXaGjpXa-365-720.gif)

```dart
FToast.toast(
  context,
  msg: "This is Msg",
  subMsg: "Welcome to use FToast. This is subMsg!",

  /// 配置图标
  ///
  /// set image
  image: Icon(
    Icons.star,
    color: Colors.yellow,
  ),

  /// 配置图标相对文本的位置
  ///
  /// set position of icon relative to text
  imageDirection: up,
)
```


##  🔩 自定义样式

![](https://gw.alicdn.com/tfs/TB1wlI_NUT1gK0jSZFrXXcNCXXa-365-720.gif)

```dart
FToast.toast(
  context,
  /// 自定义 Toast 样式
  /// 
  /// Custom Toast style
  toast: FSuper(
    text: "Custom Toast",
    style: TextStyle(color: Colors.grey),
    padding: EdgeInsets.all(12),
    shadowColor: Colors.yellow,
    shadowBlur: 80,
  ),
)
```

## 📍 对齐位置

```dart
FToast.toast(
  context,
  msg: "I'm FToast",

  /// 配置 Toast 对齐位置
  ///
  /// set alignment
  alignment: Alignment.topCenter,
)
```

## ♻️ 忽略重复内容

```dart
FToast.toast(
  context,
  msg: "I'm FToast",

  /// 忽略内容重复的 Toast
  ///
  /// ignore duplicate toast
  ignoreDuplicate: true,
)
```


# 😃 如何使用？

在项目 `pubspec.yaml` 文件中添加依赖：

## 🌐 pub 依赖方式

```
dependencies:
  ftoast: ^<版本号>
```

> ⚠️ 注意，请到 [**pub**](https://pub.dev/packages/ftoast) 获取 **FToast** 最新版本号

## 🖥 git 依赖方式

```
dependencies:
  ftoast:
    git:
      url: 'git@github.com:Fliggy-Mobile/ftoast.git'
      ref: '<分支号 或 tag>'
```


> ⚠️ 注意，分支号 或 tag 请以 [**FToast**](https://github.com/Fliggy-Mobile/ftoast) 官方项目为准。


# 💡 License

```
Copyright 2020-present Fliggy Android Team <alitrip_android@list.alibaba-inc.com>.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at following link.

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

```


### 感觉还不错？请投出您的 [**Star**](https://github.com/Fliggy-Mobile/ftoast) 吧 🥰 ！


---

# 如何运行 Demo 工程？

1.**clone** 工程到本地

2.进入工程 `example` 目录，运行以下命令

```
flutter create .
```

3.运行 `example` 中的 Demo



