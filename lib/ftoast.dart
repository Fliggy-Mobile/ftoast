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
  static Queue<_ToastData>? _entryQueue;
  static _ToastData? _current;

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
  /// [alignment] - Toast 在屏幕上的对齐位置，默认居中，可配置为 [Alignment.topCenter]、[Alignment.bottomCenter] 等
  /// [ignoreDuplicate] - 是否忽略内容重复的 Toast。开启后，若相同内容的 Toast 正在显示或已在队列中，将不再重复入队
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
  /// [alignment]-the alignment of the toast on the screen, centered by default, e.g. [Alignment.topCenter], [Alignment.bottomCenter]
  /// [ignoreDuplicate]-whether to ignore toasts with duplicate content. When enabled, a new toast identical to one already showing or queued will be dropped
  static toast(
    final BuildContext context, {
    final Widget? toast,
    final String msg = "",
    final TextStyle? msgStyle,
    final String? subMsg,
    final TextStyle? subMsgStyle,
    final double subMsgSpace = 12.0,
    final double corner = 6.0,
    final Color color = Colors.black54,
    final int duration = 1800,
    final EdgeInsets padding =
        const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
    final Widget? image,
    final AxisDirection imageDirection = AxisDirection.up,
    final double imageSpace = 9.0,
    final Alignment alignment = Alignment.center,
    final bool ignoreDuplicate = false,
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
          child: Padding(
            padding: EdgeInsets.only(
              top: alignment.y < 0
                  ? MediaQueryData.fromWindow(window).padding.top + 16.0
                  : 0.0,
              bottom: alignment.y > 0
                  ? MediaQueryData.fromWindow(window).padding.bottom + 16.0
                  : 0.0,
            ),
            child: Align(
              alignment: alignment,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  toast ?? buildToast(),
                ],
              ),
            ),
          ),
        ),
      );
    });
    _ToastData toastData = _ToastData()
      ..context = context
      ..entry = entry
      ..duration = duration
      ..content = toast != null ? null : (msg + "\n" + (subMsg ?? ""));

    /// 内容重复的 Toast 不再重复入队
    ///
    /// Drop the new toast if its content is identical
    /// to one already showing or queued.
    if (ignoreDuplicate && toast == null) {
      final String content = toastData.content!;
      final bool isShowing = _current?.content == content;
      final bool inQueue =
          _entryQueue?.any((data) => data.content == content) ?? false;
      if (isShowing || inQueue) {
        return;
      }
    }
    _entryQueue?.addLast(toastData);
    _show();
  }

  static _show() {
    if (_current == null) {
      final _ToastData? first = (_entryQueue?.isNotEmpty ?? false)
          ? _entryQueue?.removeFirst()
          : null;
      _current = first;
      if (first != null) {
        try {
          if (first.context != null &&
              (first.context!.findRenderObject()?.attached ?? false) &&
              first.entry != null) {
            OverlayState? overlayState = Overlay.of(first.context!);
            overlayState?.insert(first.entry!);
            first.showed = true;
            Timer(Duration(milliseconds: first.duration), () {
              first.dispose();
              _current = null;
              _show();
            });
          } else {
            first.dispose();
            _current = null;
            _show();
          }
        } catch (e) {
          _current = null;
          _show();
        }
      }
    }
  }
}

class _ToastData {
  OverlayEntry? entry;
  int duration = 1800;
  BuildContext? context;
  bool showed = false;

  /// 用于判断 Toast 内容是否重复
  ///
  /// Used to check whether the toast content is duplicated
  String? content;

  dispose() {
    if (showed) entry?.remove();
    entry = null;
    context = null;
  }
}
