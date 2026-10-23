import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ftoast/ftoast.dart';

void main() {
  late BuildContext toastContext;

  Widget buildApp() {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          toastContext = context;
          return const Scaffold(body: SizedBox());
        },
      ),
    );
  }

  /// FToast 的队列是静态的，测试结束时必须把队列清空，
  /// 否则会污染下一个测试（以及留下 pending Timer）。
  ///
  /// The toast queue is static, so every test must drain it,
  /// otherwise it pollutes the next test (and leaves pending timers).
  Future<void> drain(WidgetTester tester) async {
    await tester.pump(const Duration(milliseconds: 700));
  }

  testWidgets('toast shows and dismisses after duration', (tester) async {
    await tester.pumpWidget(buildApp());
    FToast.toast(toastContext, msg: "hello", duration: 100);
    await tester.pump();
    expect(find.text("hello"), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 150));
    expect(find.text("hello"), findsNothing);
  });

  testWidgets('identical toasts queue and show sequentially by default',
      (tester) async {
    await tester.pumpWidget(buildApp());
    FToast.toast(toastContext, msg: "queue", duration: 100);
    await tester.pump();
    FToast.toast(toastContext, msg: "queue", duration: 100);
    await tester.pump();
    expect(find.text("queue"), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 150));
    // 第一条结束，第二条开始展示
    expect(find.text("queue"), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 150));
    expect(find.text("queue"), findsNothing);
  });

  testWidgets('ignoreDuplicate drops the repeated toast', (tester) async {
    await tester.pumpWidget(buildApp());
    FToast.toast(toastContext, msg: "dup", duration: 100, ignoreDuplicate: true);
    await tester.pump();
    FToast.toast(toastContext, msg: "dup", duration: 100, ignoreDuplicate: true);
    await tester.pump();
    expect(find.text("dup"), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 150));
    // 重复的那条已被丢弃，不会再展示
    expect(find.text("dup"), findsNothing);
    await drain(tester);
  });

  testWidgets('ignoreDuplicate keeps toasts with different content',
      (tester) async {
    await tester.pumpWidget(buildApp());
    FToast.toast(toastContext, msg: "a", duration: 100, ignoreDuplicate: true);
    await tester.pump();
    FToast.toast(toastContext, msg: "b", duration: 100, ignoreDuplicate: true);
    await tester.pump();
    expect(find.text("a"), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 150));
    expect(find.text("a"), findsNothing);
    expect(find.text("b"), findsOneWidget);
    await drain(tester);
  });

  testWidgets('alignment top places the toast near the top', (tester) async {
    await tester.pumpWidget(buildApp());
    FToast.toast(toastContext,
        msg: "top", duration: 500, alignment: Alignment.topCenter);
    await tester.pump();
    expect(tester.getTopLeft(find.text("top")).dy, lessThan(100.0));
    await drain(tester);
  });

  testWidgets('alignment bottom places the toast near the bottom',
      (tester) async {
    await tester.pumpWidget(buildApp());
    FToast.toast(toastContext,
        msg: "bottom", duration: 500, alignment: Alignment.bottomCenter);
    await tester.pump();
    expect(tester.getBottomLeft(find.text("bottom")).dy, greaterThan(500.0));
    await drain(tester);
  });

  testWidgets('default alignment centers the toast', (tester) async {
    await tester.pumpWidget(buildApp());
    FToast.toast(toastContext, msg: "center", duration: 500);
    await tester.pump();
    final double y = tester.getTopLeft(find.text("center")).dy;
    expect(y, greaterThan(200.0));
    expect(y, lessThan(400.0));
    await drain(tester);
  });
}
