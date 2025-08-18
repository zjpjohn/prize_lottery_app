import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_around_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_around.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

const Map<int, Color> colors = {
  1: Color(0xFF32CD32),
  2: Colors.pinkAccent,
  3: Color(0xFF1E90FF),
  4: Colors.orangeAccent,
};

const Map<int, String> levels = {
  1: '开奖号',
  2: '一级胆码',
  3: '二级胆码',
  4: '拖码',
};

class LotteryAroundView extends StatelessWidget {
  const LotteryAroundView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '绕胆工具',
      content: Container(
        color: const Color(0xFFF8F8FB),
        child: RequestWidget<LotteryAroundController>(
          builder: (controller) {
            return Column(
              children: [
                _buildAroundHeader(controller),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: CustomScrollBehavior(),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildAroundContent(controller),
                          _buildAroundUsage(),
                        ],
                      ),
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

  Widget _buildAroundHeader(LotteryAroundController controller) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (!controller.isFirst()) {
                controller.prevPeriod();
              }
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
                    color:
                        controller.isFirst() ? Colors.black26 : Colors.black87,
                  ),
                ),
                Text(
                  '上一期',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color:
                        controller.isFirst() ? Colors.black26 : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    '${controller.period}期',
                    style: TextStyle(
                      height: 1.0,
                      color: Colors.black87,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    controller.around.dateText(),
                    style: TextStyle(
                      height: 1.0,
                      color: Colors.black87,
                      fontSize: 13.sp,
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (!controller.isEnd()) {
                controller.nextPeriod();
              }
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
                    color: controller.isEnd() ? Colors.black26 : Colors.black87,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Icon(
                    const IconData(0xe613, fontFamily: 'iconfont'),
                    size: 14.sp,
                    color: controller.isEnd() ? Colors.black26 : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAroundContent(LotteryAroundController controller) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
      padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: Column(
        children: [
          Text(
            '${controller.around.lotto.description}${controller.around.type.description}绕胆图',
            style: TextStyle(
              fontSize: 17.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          _buildAroundView(controller.around),
          _buildRecommendDan(controller.around),
          _buildAroundHint(controller.around),
        ],
      ),
    );
  }

  Widget _buildAroundView(LotteryAround around) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 16.w),
      child: Column(
        children: [
          _buildAroundRow(around.around.cells.sublist(0, 3), top: true),
          _buildAroundRow(around.around.cells.sublist(3, 8),
              top: true, bottom: true),
          _buildAroundRow(around.around.cells.sublist(8, 11), bottom: true),
        ],
      ),
    );
  }

  Widget _buildAroundRow(List<AroundCell> cells,
      {bool top = false, bool bottom = false}) {
    List<Widget> cellList = [];
    for (int i = 0; i < cells.length; i++) {
      cellList.add(
        Container(
          width: 54.w,
          height: 38.w,
          alignment: Alignment.center,
          color: Colors.white,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: top && i == 0 ? Radius.circular(8.w) : Radius.zero,
              bottomLeft: bottom && i == 0 ? Radius.circular(8.w) : Radius.zero,
              topRight: top && i == cells.length - 1
                  ? Radius.circular(8.w)
                  : Radius.zero,
              bottomRight: bottom && i == cells.length - 1
                  ? Radius.circular(8.w)
                  : Radius.zero,
            ),
            child: Container(
              width: 53.7.w,
              height: top && bottom && (i == 0 || i == cells.length - 1)
                  ? 38.w
                  : 37.7.w,
              alignment: Alignment.center,
              color: colors[cells[i].type],
              child: Text(
                cells[i].value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: cellList,
    );
  }

  Widget _buildRecommendDan(LotteryAround around) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/${around.lotto.value}/pivot');
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.w),
        decoration: BoxDecoration(
          color: Colors.orangeAccent.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: Text(
          '查看系统推荐定胆',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.orangeAccent,
          ),
        ),
      ),
    );
  }

  Widget _buildAroundHint(LotteryAround around) {
    return Container(
      margin: EdgeInsets.only(top: 16.w),
      child: Column(
        children: [
          aroundResult(around.result),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: levels.entries.map((e) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.w,
                      color: colors[e.key],
                      margin: EdgeInsets.only(right: 2.w),
                    ),
                    Text(
                      e.key == 1 ? around.type.description : levels[e.key]!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          Text(
            '仅供参考，谨慎使用，系统不做任何承诺',
            style: TextStyle(
              color: Colors.black26,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget aroundResult(AroundResult? result) {
    if (result == null) {
      return const SizedBox.shrink();
    }
    List<InlineSpan> spans = [];
    if (result.level1 > 0) {
      spans.add(
        TextSpan(
          text: '一级胆码命中',
          children: [
            TextSpan(
              text: '${result.level1}',
              style: const TextStyle(
                color: Color(0xFFFF0033),
              ),
            ),
            const TextSpan(
              text: '个',
              style: TextStyle(
                color: Color(0xFFFF0033),
              ),
            ),
          ],
        ),
      );
    }
    if (result.level2 > 0) {
      if (spans.isNotEmpty) {
        spans.add(
          WidgetSpan(child: SizedBox(width: 6.w)),
        );
      }
      spans.add(
        TextSpan(
          text: '二级胆码命中',
          children: [
            TextSpan(
              text: '${result.level2}',
              style: const TextStyle(
                color: Color(0xFFFF0033),
              ),
            ),
            const TextSpan(
              text: '个',
              style: TextStyle(
                color: Color(0xFFFF0033),
              ),
            ),
          ],
        ),
      );
    }
    if (result.tuo > 0) {
      if (spans.isNotEmpty) {
        spans.add(
          WidgetSpan(child: SizedBox(width: 6.w)),
        );
        spans.add(
          TextSpan(
            text: '拖码命中',
            children: [
              TextSpan(
                text: '${result.tuo}',
                style: const TextStyle(
                  color: Color(0xFFFF0033),
                ),
              ),
              const TextSpan(
                text: '个',
                style: TextStyle(
                  color: Color(0xFFFF0033),
                ),
              ),
            ],
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: '非常遗憾，本期仅拖码命中',
            children: [
              TextSpan(
                text: '${result.tuo}',
                style: const TextStyle(
                  color: Color(0xFFFF0033),
                ),
              ),
              const TextSpan(
                text: '个',
                style: TextStyle(
                  color: Color(0xFFFF0033),
                ),
              ),
            ],
          ),
        );
      }
    }
    if (spans.isEmpty) {
      return RichText(
        text: TextSpan(
          text: '非常遗憾，绕胆图未能命中胆码',
          style: TextStyle(color: Colors.black, fontSize: 12.sp),
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 8.w),
      child: RichText(
        text: TextSpan(
          children: spans,
          style: TextStyle(color: Colors.black, fontSize: 12.sp),
        ),
      ),
    );
  }

  Widget _buildAroundUsage() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w, bottom: 16.w),
      padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '使用说明',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontFamily: 'shuhei',
            ),
          ),
          _buildUsageItem(
              title: '举例一',
              text: '一级胆码有2个，请注意，这两个一级胆码一起同时出现的可能性比较低，一般择其一而用之。'
                  '同理，二级胆码也有2个但两个二级胆码一起同时出现的可能性较低。您可将一级胆码与二级胆码搭配使用。'),
          _buildUsageItem(
              title: '举例二',
              text: '如当天的绕胆图中，中间一个开奖号的上下有胆码色块存在就看这两个胆码色块的左右色块中，'
                  '如存在拖码色块，就可从拖码色块中获得出现可能性较大的号码(即:拖码可以提升到胆码的地位)。'),
          _buildUsageItem(
              title: '举例三',
              text: '如上一期开奖号出现组三形态，则此组三号的2个相同号码的周围绕号可提升参考地位。'
                  '绕胆图的用法是灵活多样的，您可根据自己的心得体会活学活用。以上介绍方法是根据大家的心得体会整理而成的，'
                  '不一定完全准确，请大家结合自己的研究灵活应用。'),
        ],
      ),
    );
  }

  Widget _buildUsageItem({required String title, required String text}) {
    return Padding(
      padding: EdgeInsets.only(top: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.black45,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}
