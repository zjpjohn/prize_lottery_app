import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/lottery/controller/num3_follow_controller.dart';
import 'package:prize_lottery_app/views/lottery/widgets/follow_widget.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class Num3LottoFollowView extends StatelessWidget {
  const Num3LottoFollowView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '历史跟随',
      content: Container(
        color: Colors.white,
        child: RequestWidget<Num3FollowController>(
          builder: (controller) {
            return Column(
              children: [
                _buildPeriodHeader(controller),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: CustomScrollBehavior(),
                    child: SingleChildScrollView(
                      child: FollowWidget(follows: controller.data),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPeriodHeader(Num3FollowController controller) {
    if (controller.isParameter) {
      return const SizedBox.shrink();
    }
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              controller.prevPeriod();
            },
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Icon(
                    const IconData(0xe676, fontFamily: 'iconfont'),
                    size: 14.sp,
                    color: controller.isFirst ? Colors.black26 : Colors.black87,
                  ),
                ),
                Text(
                  '上一期',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: controller.isFirst ? Colors.black26 : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${controller.period}期',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.nextPeriod();
            },
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '下一期',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: controller.isEnd ? Colors.black26 : Colors.black87,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Icon(
                    const IconData(0xe613, fontFamily: 'iconfont'),
                    size: 14.sp,
                    color: controller.isEnd ? Colors.black26 : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
