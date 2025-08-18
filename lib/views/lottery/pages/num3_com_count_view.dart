import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/lottery/controller/num3_com_count_controller.dart';
import 'package:prize_lottery_app/views/shrink/widgets/clip_button.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

Map<int, String> limitLevel = {
  90: '三个月',
  180: '近半年',
  365: '近一年',
  540: '一年半',
};

class Num3ComCountView extends StatelessWidget {
  const Num3ComCountView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '出号统计',
      border: false,
      content: Container(
        color: Colors.white,
        child: RequestWidget<Num3ComCountController>(
          builder: (controller) {
            return ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildLimitLevel(controller),
                    _buildComCount(controller),
                    _buildHelpHint(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLimitLevel(Num3ComCountController controller) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: Text(
              '统计期数',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14.sp,
              ),
            ),
          ),
          ...limitLevel.entries.map((e) => ClipButton(
                text: e.value,
                value: e.key,
                width: 58.w,
                height: 24.w,
                margin: 10.w,
                selected: controller.limit == e.key,
                onTap: (value) {
                  controller.limit = value;
                },
              )),
        ],
      ),
    );
  }

  Widget _buildHelpHint() {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 24.w),
      child: Text(
        '统计指定期数内号码组选出现次数，点击号码可查询详细出现情况',
        style: TextStyle(
          fontSize: 13.sp,
          color: Colors.black38,
        ),
      ),
    );
  }

  Widget _buildComCount(Num3ComCountController controller) {
    return Container(
      padding: EdgeInsets.only(bottom: 8.w),
      child: Column(
        children: controller.counts.entries
            .map((entry) => _buildCountItem(entry, controller.type))
            .toList(),
      ),
    );
  }

  Widget _buildCountItem(MapEntry<int, List<String>> entry, String type) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.w, horizontal: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.w)),
        border: Border.all(color: Colors.black12, width: 0.6.w),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 28.w,
              alignment: Alignment.center,
              color: Colors.deepOrangeAccent.withValues(alpha: 0.15),
              child: Text(
                '${entry.key}',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.deepOrangeAccent,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 8.w),
                child: Wrap(
                  spacing: 10.w,
                  runSpacing: 4.w,
                  children: entry.value
                      .map((e) => GestureDetector(
                            onTap: () {
                              Get.toNamed('/num3/com/follow/$type?com=$e');
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Text(
                              e.replaceAll(RegExp(r'(\s+)'), ''),
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black87,
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
