import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum SmsState {
  ///
  /// 发送成功
  success,

  ///
  ///发送失败
  error,

  ///
  /// 手机号错误
  empty,
}

typedef SmsSendFunction = Future<SmsState> Function();

///可用时使用的字体样式。
final TextStyle availableStyle = TextStyle(
  fontSize: 14.sp,
  color: Colors.blue,
);

///不可用时使用的样式。
final TextStyle unavailableStyle = TextStyle(
  fontSize: 14.sp,
  color: const Color(0xFFCCCCCC),
);

class CountdownWidget extends StatefulWidget {
  const CountdownWidget({
    super.key,
    this.countdown = 60,
    required this.handle,
  });

  ///
  /// 发送短信倒计时时间
  final int countdown;

  ///
  /// 发送消息
  final SmsSendFunction handle;

  @override
  CountdownWidgetState createState() => CountdownWidgetState();
}

class CountdownWidgetState extends State<CountdownWidget> {
  ///
  /// 是否可用
  bool available = true;

  ///
  /// 倒计时秒
  late int seconds;

  ///
  /// 发送按钮样式
  String btnTxt = '获取验证码';

  ///
  /// 计时器
  StreamSubscription? timer;

  ///
  /// 发送按钮文字样式
  TextStyle btnStyle = availableStyle;

  ///
  /// 发送倒计时
  void _startTimer() {
    setState(() {
      available = false;
      seconds = widget.countdown;
      btnStyle = unavailableStyle;
      btnTxt = '$seconds秒后重发';
    });
    timer = Stream.periodic(const Duration(seconds: 1), (i) => i)
        .take(widget.countdown)
        .listen((i) {
      setState(() {
        btnStyle = unavailableStyle;
        seconds = widget.countdown - i - 1;
        btnTxt = '$seconds秒后重发';
        if (seconds < 1) {
          seconds = widget.countdown;
          btnStyle = availableStyle;
          btnTxt = '重新发送';
          available = true;
        }
      });
    });
  }

  void _sendSms() {
    if (!available) {
      return;
    }
    setState(() {
      available = false;
    });
    widget.handle().then((value) {
      switch (value) {
        case SmsState.success:
          EasyLoading.showToast('发送成功');
          _startTimer();
          break;
        case SmsState.error:
          EasyLoading.showToast('发送失败');
          _startTimer();
          break;
        case SmsState.empty:
          setState(() {
            available = true;
          });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _sendSms();
      },
      child: Container(
        height: 28.h,
        alignment: Alignment.centerRight,
        child: Text(
          btnTxt,
          style: btnStyle,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
