import 'dart:async';
import 'dart:collection';
import 'dart:ui';

import 'package:flutter/material.dart';

/// 帮助开发者创建灵活的，简洁的，精美的 Toast
///
/// Help developers create flexible, concise and beautiful Toast
///
/// e.g.:
/// ```
/// FToast.toast(context, msg: "Hi, FWidget");
class FToast {
  static Queue<_ToastData> _entryQueue;
  static _ToastData _current;

  /// [context] - 页面环境
  /// [toast] - 自定义 toast 视图，会覆盖默认视图
  /// [msg] - 主信息
  /// [msgStyle] - 主信息文本样式
  /// [subMsg] - 副信息
  /// [subMsgStyle] - 副信息文本样式
  /// [subMsgSpace] - 副信息与主信息的间距
  /// [corner] - 边角
  /// [color] - 颜色
  /// [duration] - 展示时长
  /// [padding] - 内间距
  /// [image] - 图标
  /// [imageDirection] - 图标相对文本的位置
  /// [imageSpace] - 图标与文本的间距
  ///
  /// [context]-page environment
  /// [toast]-custom toast view, will override the default view
  /// [msg]-main title
  /// [msgStyle]-main title text style
  /// [subMsg ]-Subtitle
  /// [subMsgStyle]-Subtitle text style
  /// [subMsgSpace]-Subtitle and main title spacing
  /// [corner]-Corner
  /// [color]-Color
  /// [duration]- Impression duration
  /// [padding]-inner spacing
  /// [image]-icon
  /// [imageDirection]-position of icon relative to text
  /// [imageSpace]-distance between icon and text
  static toast(
    final BuildContext context, {
    final Widget toast,
    final String msg = "",
    final TextStyle msgStyle,
    final String subMsg,
    final TextStyle subMsgStyle,
    final double subMsgSpace = 12.0,
    final double corner = 6.0,
    final Color color = Colors.black54,
    final int duration = 1800,
    final EdgeInsets padding =
        const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
    final Widget image,
    final AxisDirection imageDirection = AxisDirection.up,
    final double imageSpace = 9.0,
  }) {
    Widget buildToast() {
      TextStyle defaultStyle = TextStyle(
        color: Colors.white,
        fontSize: 16,
        height: 1.0,
      );
      List<Widget> children = [];

      if (image != null && imageDirection == AxisDirection.up) {
        children.add(image);
        children.add(SizedBox(height: imageSpace));
      }

      /// msg
      if (image != null && imageDirection == AxisDirection.left) {
        children.add(Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            image,
            SizedBox(width: imageSpace),
            Text(
              msg,
              style: msgStyle ?? defaultStyle,
            )
          ],
        ));
      } else if (image != null && imageDirection == AxisDirection.right) {
        children.add(Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              msg,
              style: msgStyle ?? defaultStyle,
            ),
            SizedBox(width: imageSpace),
            image,
          ],
        ));
      } else {
        children.add(Text(
          msg,
          style: msgStyle ?? defaultStyle,
        ));
      }

      /// subMsg
      if (subMsg != null) {
        children.add(
          SizedBox(height: subMsgSpace),
        );
        children.add(Text(
          subMsg,
          style: subMsgStyle ?? defaultStyle.copyWith(fontSize: 13),
        ));
      }
      if (image != null && imageDirection == AxisDirection.down) {
        children.add(SizedBox(height: imageSpace));
        children.add(image);
      }
      return ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: 80.0,
            minHeight: 38.0,
            maxWidth: MediaQueryData.fromWindow(window).size.width - 48.0),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(corner)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        ),
      );
    }

    if (_entryQueue == null) _entryQueue = Queue();
    OverlayEntry entry = OverlayEntry(builder: (context) {
      return IgnorePointer(
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              toast ?? buildToast(),
            ],
          ),
        ),
      );
    });
    _ToastData toastData = _ToastData()
      ..context = context
      ..entry = entry
      ..duration = duration;
    _entryQueue.addLast(toastData);
    _show();
  }

  static _show() {
    if (_current == null) {
      final _ToastData first =
          _entryQueue.isNotEmpty ? _entryQueue.removeFirst() : null;
      _current = first;
      if (first != null) {
        try {
          if (first.context != null &&
              (first.context.findRenderObject()?.attached ?? false)) {
            OverlayState overlayState = Overlay.of(first.context);
            overlayState.insert(first.entry);
            first.showed = true;
            Timer(Duration(milliseconds: first.duration), () {
              first.dispose();
              _current = null;
              _show();
            });
          } else {
            first.dispose();
            _current = null;
          }
        } catch (e) {
          _current = null;
        }
      }
    }
  }
}

class _ToastData {
  OverlayEntry entry;
  int duration;
  BuildContext context;
  bool showed = false;

  dispose() {
    if (showed) entry?.remove();
    entry = null;
    context = null;
  }
}
