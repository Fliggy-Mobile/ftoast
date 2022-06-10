import 'dart:ui';

import 'package:fcommon/fcommon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fsuper/fsuper.dart';
import 'package:ftoast/ftoast.dart';
import 'package:fcontrol/fdefine.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (context) {
        var appBar = AppBar(
          backgroundColor: mainBackgroundColor,
          title: const Text(
            'FToast',
            style: TextStyle(color: mainTextTitleColor),
          ),
          centerTitle: true,
        );
        var shadowTop = MediaQueryData.fromWindow(window).size.height -
            appBar.preferredSize.height -
            20;
        return Scaffold(
          backgroundColor: mainBackgroundColor,
          appBar: appBar,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildTitle("FToast"),
                      buildMiddleMargin(),
                      buildMiddleMargin(),
                      buildMiddleMargin(),

                      /// FToast
                      buildFToast(context),
                      const SizedBox(height: 500),
                      buildTitle("SubMsg"),
                      buildMiddleMargin(),
                      buildMiddleMargin(),
                      buildMiddleMargin(),

                      /// SubMsg
                      buildSubMsg(context),
                      const SizedBox(height: 500),

                      buildTitle("Image"),
                      buildMiddleMargin(),
                      buildMiddleMargin(),
                      buildMiddleMargin(),

                      /// Image
                      buildImage(context),
                      const SizedBox(height: 500),

                      buildTitle("Custom Toast"),
                      buildMiddleMargin(),
                      buildMiddleMargin(),
                      buildMiddleMargin(),

                      /// Custom Toast
                      buildCustomToast(context),
                      const SizedBox(height: 500),

                      buildBiggestMargin(),
                      buildBiggestMargin(),
                    ],
                  ),
                ),
              ),
              FSuper(
                width: double.infinity,
                height: 26.0,
                margin: EdgeInsets.only(top: shadowTop),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black26,
                    ]),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildFToast(BuildContext context) {
    return FSuper(
      text: "Click to show FToast",
      style: TextStyle(color: mainTextTitleColor),
      backgroundColor: mainBackgroundColor,
      padding: EdgeInsets.all(12.0),
      onClick: () {
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
        );
      },
      corner: FCorner.all(20),
      isSupportNeumorphism: true,
    );
  }

  Widget buildSubMsg(BuildContext context) {
    return FSuper(
      text: "Click to show FToast",
      style: TextStyle(color: mainTextTitleColor),
      backgroundColor: mainBackgroundColor,
      padding: EdgeInsets.all(12.0),
      onClick: () {
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
        );
      },
      corner: FCorner.all(20),
      isSupportNeumorphism: true,
    );
  }

  AxisDirection up = AxisDirection.up;

  Widget buildImage(BuildContext context) {
    return FSuper(
      text: "Click to show FToast",
      style: TextStyle(color: mainTextTitleColor),
      backgroundColor: mainBackgroundColor,
      padding: EdgeInsets.all(12.0),
      onClick: () {
        switch (up) {
          case AxisDirection.up:
            up = AxisDirection.left;
            break;
          case AxisDirection.left:
            up = AxisDirection.right;
            break;
          case AxisDirection.right:
            up = AxisDirection.down;
            break;
          case AxisDirection.down:
            up = AxisDirection.up;
            break;
        }
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
        );
      },
      corner: FCorner.all(20),
      isSupportNeumorphism: true,
    );
  }

  Widget buildCustomToast(BuildContext context) {
    return FSuper(
      text: "Click to show FToast",
      style: TextStyle(color: mainTextTitleColor),
      backgroundColor: mainBackgroundColor,
      padding: EdgeInsets.all(12.0),
      onClick: () {
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
        );
      },
      corner: FCorner.all(20),
      isSupportNeumorphism: true,
    );
  }
}

class Page_2 extends StatefulWidget {
  @override
  _Page_2State createState() => _Page_2State();
}

class _Page_2State extends State<Page_2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: mainBackgroundColor,
      child: FSuper(
        width: 100,
        height: 80,
        backgroundColor: mainBackgroundColor,
        onClick: () {
          FToast.toast(context, msg: "Hi");
          Navigator.pop(context);
        },
        isSupportNeumorphism: true,
      ),
    );
  }
}
