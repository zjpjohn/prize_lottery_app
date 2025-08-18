import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:prize_lottery_app/widgets/not_found_widget.dart';

class RouteUnknownView extends StatelessWidget {
  ///
  ///
  const RouteUnknownView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      border: false,
      header: const SizedBox.shrink(),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NotFoundView(
            size: 192.w,
            message: '您访问的页面不存在',
          ),
        ],
      ),
    );
  }
}
