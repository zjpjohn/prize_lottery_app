import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/resources/styles.dart';
import 'package:prize_lottery_app/widgets/nav_app_bar.dart';

class LayoutContainer extends StatelessWidget {
  ///
  ///
  final String title;

  ///
  /// AppBar底部border是否显示
  final bool border;

  ///
  /// header部分组件
  final Widget? header;

  ///
  /// 右侧组件
  final Widget? right;

  ///
  final Widget content;

  /// 状态栏样式
  final SystemUiOverlayStyle style;

  LayoutContainer({
    super.key,
    required this.content,
    this.border = true,
    this.title = '',
    this.header,
    this.right,
    this.style = UiStyle.dark,
  }) : assert((title.isNotEmpty && header == null) ||
            (title.isEmpty && header != null));

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: style,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: LayoutWithoutAnnotatedRegion(
            content: content,
            border: border,
            title: title,
            header: header,
            right: right,
          ),
        ),
      ),
    );
  }
}

class LayoutWithoutAnnotatedRegion extends StatelessWidget {
  LayoutWithoutAnnotatedRegion({
    super.key,
    required this.content,
    this.border = true,
    this.title = '',
    this.header,
    this.right,
  }) : assert((title.isNotEmpty && header == null) ||
            (title.isEmpty && header != null));

  ///
  ///
  final String title;

  ///
  /// AppBar底部border是否显示
  final bool border;

  ///
  /// header部分组件
  final Widget? header;

  ///
  /// 右侧组件
  final Widget? right;

  ///
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NavAppBar(
          border: border,
          center: title.isEmpty
              ? header!
              : Text(
                  title,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 17.sp,
                  ),
                ),
          left: Container(
            width: 40.w,
            height: 32.w,
            alignment: Alignment.centerLeft,
            child: Icon(
              const IconData(0xe669, fontFamily: 'iconfont'),
              size: 19.w,
              color: Colors.black87,
            ),
          ),
          right: right,
        ),
        Expanded(
          child: content,
        ),
      ],
    );
  }
}
