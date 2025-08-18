import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/user/controller/about_account_controller.dart';
import 'package:prize_lottery_app/widgets/common_widgets.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_phasics.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class AboutAccountView extends StatelessWidget {
  ///
  ///
  const AboutAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '关于账户',
      content: RequestWidget<AboutAccountController>(
        builder: (controller) {
          return _buildNoticeView(controller);
        },
      ),
    );
  }

  Widget _buildNoticeView(AboutAccountController controller) {
    return ScrollConfiguration(
      behavior: CustomScrollBehavior(),
      child: SingleChildScrollView(
        physics: const EasyRefreshPhysics(topBouncing: false),
        child: Column(
          children: controller.assistants.map((e) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.withValues(alpha: 0.3),
                    width: 0.25.w,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 4.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 6.w, top: 7.w),
                          child: CommonWidgets.dotted(
                            size: 5.w,
                            color: Colors.blueAccent,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            e.title.trim(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    e.content.trim(),
                    style: TextStyle(
                      height: 1.5,
                      fontSize: 13.sp,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
