import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:prize_lottery_app/store/resource.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';

class ChannelButton extends StatelessWidget {
  ///
  ///
  const ChannelButton({
    super.key,
    required this.text,
    required this.icon,
    required this.size,
    required this.callback,
    this.margin = EdgeInsets.zero,
  });

  final String icon;
  final double size;
  final String text;
  final Function callback;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      behavior: HitTestBehavior.opaque,
      child: GetBuilder<ResourceStore>(
        builder: (store) {
          return Container(
            margin: margin,
            padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedAvatar(
                  width: size,
                  height: size,
                  url: store.resource(icon),
                  radius: size / 2,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.w),
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.black, fontSize: 12.sp),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class EmptyChannel extends StatelessWidget {
  ///
  ///
  final double size;

  ///
  final EdgeInsets margin;

  const EmptyChannel({
    super.key,
    required this.size,
    required this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: EdgeInsets.only(left: 2.w, top: 6.w, bottom: 6.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.w),
            child: Text(
              '',
              style: TextStyle(fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }
}
