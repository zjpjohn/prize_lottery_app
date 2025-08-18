import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/lottery/controller/assistant_detail_controller.dart';

class AssistantDetailView extends StatelessWidget {
  const AssistantDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '问题详情',
      content: Container(
        color: const Color(0xFFF6F6FB),
        child: RequestWidget<AssistantDetailController>(
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 24.w, bottom: 12.w),
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    controller.assistant.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    controller.assistant.content,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15.sp,
                      height: 1.4,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40.w),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '问题没解决？',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 13.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.feedback);
                        },
                        child: Text(
                          '去反馈',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 13.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
