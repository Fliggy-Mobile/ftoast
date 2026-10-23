<p align="center">
  <a href="https://github.com/Fliggy-Mobile">
    <img width="200" src="https://gw.alicdn.com/tfs/TB1a288sxD1gK0jSZFKXXcJrVXa-360-360.png">
  </a>
</p>

<h1 align="center">ftoast</h1>


<div align="center">

<p>Simple, beautiful Toast</p>

<p>Help developers create flexible, concise and beautiful Toast</p>

<p><strong>Author：<a href="https://github.com/chenBingX">Newton</a>(<a href="coorchice.cb@alibaba-inc.com">coorchice.cb@alibaba-inc.com</a>)</strong></p>
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

<a href="https://www.apache.org/licenses/LICENSE-2.0.txt">
   <img height="20" src="https://img.shields.io/badge/License-Apache--2.0-blueviolet.svg">
</a>

<p>
<p>

</div>

![](https://gw.alicdn.com/tfs/TB1CdJ5ffzO3e4jSZFxXXaP_FXa-1466-562.png)


**English | [简体中文](https://github.com/Fliggy-Mobile/ftoast/blob/master/README_CN.md)**

> Like it? Please cast your **Star**  🥰 ！

# ✨ Features

- Provide a convenient way to create **Toast**

- Support primary information, secondary information, and customize their style

- Support flexible icon view

- Support to configure corner size and background color

- Support queue display

- Support to align toast to top / bottom / anywhere

- Support to ignore duplicate toasts

- Support custom **Toast** style


# 🛠 Guide

In FToast, developers can easily create a **Toast** with simple code.

```dart
FToast.toast(context, msg: "FToast");
```

## ⚙️ Parameters

|Param|Type|Necessary|Default|desc|
|---|---|:---:|---|---|
|context|BuildContext|true|null|page environment|
|toast|Widget|false|null|custom toast view, will override the default view|
|msg|String|false|null|main title|
|msgStyle|TextStyle|false|null|main title text style|
|subMsg|String|false|null|Subtitle|
|subMsgStyle|TextStyle|false|null|Subtitle text style|
|subMsgSpace|double|false|12.0|Subtitle and main title spacing|
|corner|double|false|6.0|Corner|
|color|Color|false|Colors.black54|Color|
|duration|double|false|1800|Impression duration|
|padding|EdgeInsets|false|`EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0)`|inner spacing|
|image|Widget|false|null|icon|
|imageDirection|AxisDirection|false|AxisDirection.up|position of icon relative to text|
|imageSpace|double|false|9.0|distance between icon and text|
|alignment|Alignment|false|Alignment.center|the alignment of the toast on the screen|
|ignoreDuplicate|bool|false|false|drop a new toast whose content is identical to one already showing or queued|

## 🔩 Basic

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

## 🔆 SubMsg

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

## 🔳 Image

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


##  🔩 Custom style

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

## 📍 Alignment

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

## ♻️ IgnoreDuplicate

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


# 😃 How to use？

Add dependencies in the project `pubspec.yaml` file:

## 🌐 pub dependency

```
dependencies:
  ftoast: ^<version number>
```

> ⚠️ Attention，please go to [**pub**] (https://pub.dev/packages/ftoast) to get the latest version number of **FToast**

## 🖥 Git dependency

```
dependencies:
  ftoast:
    git:
      url: 'git@github.com:Fliggy-Mobile/ftoast.git'
      ref: '<Branch number or tag number>'
```

> ⚠️ Attention，please refer to [**FToast**] (https://github.com/Fliggy-Mobile/ftoast) official project for branch number or tag.


# 💡 License

```
Copyright 2020-present Fliggy Android Team <alitrip_android@list.alibaba-inc.com>.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at following link.

    https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

```


### Like it? Please cast your [**Star**](https://github.com/Fliggy-Mobile/ftoast) 🥰 ！


---

# How to run Demo project?

1. **clone** project to local

2. Enter the project `example` directory and run the following command

```
flutter create .
```

3. Run the demo in `example`



