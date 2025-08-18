import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

typedef ActionHandle = Future<void> Function();
typedef BeforeHandle = bool Function();

class ActionStateButton extends StatefulWidget {
  const ActionStateButton({
    super.key,
    required this.active,
    required this.unActive,
    this.hintTxt = '正在提交，请耐心等待',
    this.style,
    this.before,
    required this.action,
  });

  final String unActive;
  final String active;
  final String hintTxt;
  final ButtonStyle? style;
  final ActionHandle action;
  final BeforeHandle? before;

  @override
  ActionStateButtonState createState() => ActionStateButtonState();
}

class ActionStateButtonState extends State<ActionStateButton> {
  ///
  ///提交状态
  bool _action = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (!widget.before!()) {
          return;
        }
        if (_action) {
          EasyLoading.showToast(widget.hintTxt);
          return;
        }
        setState(() {
          _action = true;
        });
        widget.action().whenComplete(() {
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              setState(() {
                _action = false;
              });
            }
          });
        });
      },
      style: widget.style,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _action ? widget.active : widget.unActive,
            style: TextStyle(color: Colors.white, fontSize: 17.sp),
          ),
          if (_action)
            Padding(
              padding: EdgeInsets.only(left: 6.w),
              child: SpinKitRing(
                color: Colors.white,
                lineWidth: 1.2.w,
                size: 17.w,
              ),
            )
        ],
      ),
    );
  }
}
