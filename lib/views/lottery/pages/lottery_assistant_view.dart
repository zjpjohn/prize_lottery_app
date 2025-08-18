import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_assistant_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_assistant.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';
import 'package:prize_lottery_app/widgets/common_widgets.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_phasics.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class LotteryAssistantView extends StatelessWidget {
  ///
  ///
  const LotteryAssistantView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '哇彩助手',
      content: Container(
        color: Colors.white,
        child: RequestWidget<LotteryAssistantController>(
          builder: (controller) {
            return ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: SingleChildScrollView(
                physics: const EasyRefreshPhysics(
                  bottomBouncing: false,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 6.w),
                    ..._buildCommonView(controller),
                    _buildLottoView(controller),
                    _buildFeedbackView(),
                    SizedBox(height: 16.w)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildCommonView(LotteryAssistantController controller) {
    List<Widget> views = [];
    List<LotteryAssistant> assistants = controller.comAssistant();
    for (int i = 0; i < assistants.length; i++) {
      LotteryAssistant e = assistants[i];
      views.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: EdgeInsets.symmetric(vertical: 14.w),
          decoration: BoxDecoration(
            border: Border(
              bottom: i < assistants.length - 1
                  ? BorderSide(
                      width: 0.1.w,
                      color: Colors.grey.withValues(alpha: 0.75),
                    )
                  : BorderSide.none,
            ),
          ),
          child: GestureDetector(
            onTap: () {
              Get.toNamed('/assistant/detail/${e.id}');
            },
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommonWidgets.dotted(
                  size: 5.w,
                  color: Colors.blueAccent,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6.w),
                  child: Text(
                    e.title.trim(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return views;
  }

  Widget _buildLottoView(LotteryAssistantController controller) {
    return Container(
      color: const Color(0xFFF6F6FB),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 10.w),
            child: Text(
              '彩票知识',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLottery(controller),
              _buildContent(controller),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLottery(LotteryAssistantController controller) {
    return Container(
      color: Colors.white,
      child: Column(
        children: lotteryZhCns.entries
            .where((e) => lotteryIcons[e.key] != null)
            .map(
              (e) => GestureDetector(
                onTap: () {
                  controller.type = e.key;
                },
                child: Container(
                  width: 72.w,
                  height: 50.w,
                  color: controller.type == e.key
                      ? const Color(0xFFF6F6FB)
                      : Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CachedAvatar(
                        width: 24.w,
                        height: 24.w,
                        color: Colors.transparent,
                        url: lotteryIcons[e.key]!,
                      ),
                      Text(
                        e.value,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: controller.type == e.key
                              ? Colors.redAccent
                              : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildContent(LotteryAssistantController controller) {
    return Expanded(
      child: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:
                controller.currents.map((e) => _buildContentItem(e)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildContentItem(LotteryAssistant assistant) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      padding: EdgeInsets.symmetric(vertical: 16.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.1.w,
            color: Colors.grey.withValues(alpha: 0.75),
          ),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Get.toNamed('/assistant/detail/${assistant.id}');
        },
        behavior: HitTestBehavior.opaque,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonWidgets.dotted(
              size: 4.w,
              color: Colors.blueAccent,
            ),
            Padding(
              padding: EdgeInsets.only(left: 6.w),
              child: Text(
                assistant.title.trim(),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackView() {
    return Container(
      margin: EdgeInsets.all(20.w),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.feedback);
        },
        child: Container(
          height: 40.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: Text(
            '建议反馈',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}
