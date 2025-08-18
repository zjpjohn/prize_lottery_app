import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/utils/date_util.dart';
import 'package:prize_lottery_app/views/lottery/controller/qlc_calculator_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/award_level.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/widgets/common_widgets.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_phasics.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:prize_lottery_app/widgets/modal_sheet_view.dart';
import 'package:prize_lottery_app/widgets/radio_btn_widget.dart';

class QlcCalculatorView extends StatelessWidget {
  ///
  ///
  const QlcCalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '算奖工具',
      content: Container(
        color: Colors.white,
        child: RequestWidget<QlcCalculatorController>(
          builder: (controller) {
            return ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: SingleChildScrollView(
                physics: const EasyRefreshPhysics(topBouncing: false),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.w),
                  child: Column(
                    children: [
                      _buildLotteryInfo(controller.lottery),
                      _buildCalcView(controller),
                      _buildAwardCounter(controller),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLotteryInfo(LotteryInfo lottery) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.w, bottom: 8.w),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    '第${lottery.period}期',
                    style: TextStyle(color: Colors.black87, fontSize: 16.sp),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(
                          '/lotto/detail/${lottery.type}/${lottery.period}');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 2.w, right: 4.w),
                          child: Text(
                            lottery.lotDate,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        Text(
                          Constants.dayWeek(DateUtil.parse(lottery.lotDate,
                              pattern: "yyyy/MM/dd")),
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black54,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 2.w),
                          child: Icon(
                            const IconData(0xe613, fontFamily: 'iconfont'),
                            size: 12.w,
                            color: Colors.black38,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    runSpacing: 4.w,
                    children: CommonWidgets.ballView(
                      lottery.redBalls(),
                      lottery.blueBalls(),
                      false,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              lotteryTimes['qlc']![1],
              style: TextStyle(
                color: Colors.black38,
                fontSize: 12.sp,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCalcView(QlcCalculatorController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          _buildPickerView(controller),
          _buildHitView(controller),
          _buildCalcBtn(controller),
        ],
      ),
    );
  }

  Widget _buildPickerView(QlcCalculatorController controller) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: Get.context!,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.w),
                topRight: Radius.circular(10.w),
              ),
            ),
            isScrollControlled: true,
            builder: (BuildContext context) {
              return _showPickerPanel();
            });
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.only(bottom: 14.w, top: 14.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black12, width: 0.2.w),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10.w),
              child: Text(
                '我的投注',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  width: 12.w,
                  height: 12.w,
                  margin: EdgeInsets.only(right: 4.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF0000),
                    borderRadius: BorderRadius.circular(15.w),
                  ),
                ),
                Text(
                  '基本号码',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14.sp,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.w, top: 1.5.w),
                  child: Text(
                    '${controller.pRed}',
                    style: TextStyle(
                      color: const Color(0xFFFF0000),
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                Text(
                  '个',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _showPickerPanel() {
    return GetBuilder<QlcCalculatorController>(
      builder: (controller) {
        return ModalSheetView(
          title: '我的投注',
          height: Get.height * 9 / 16,
          child: Container(
            padding: EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 12.w,
                          height: 12.w,
                          margin: EdgeInsets.only(right: 4.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF0000),
                            borderRadius: BorderRadius.circular(15.w),
                          ),
                        ),
                        Text(
                          '基本号码-投注',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14.sp,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Text(
                            '${controller.pRed}',
                            style: TextStyle(
                              color: const Color(0xFFFF0000),
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        Text(
                          '个',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12.w),
                      child: Wrap(
                        runSpacing: 10.w,
                        spacing: 8.w,
                        children: controller.reds
                            .map(
                              (e) => RadioButton(
                                text: '$e',
                                size: 42.w,
                                labelColor: Colors.red,
                                selected: controller.pRed == e,
                                handle: (value) {
                                  controller.pRed = int.parse(value);
                                },
                              ),
                            )
                            .toList(),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHitView(QlcCalculatorController controller) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: Get.context!,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.w),
                topRight: Radius.circular(10.w),
              ),
            ),
            isScrollControlled: true,
            builder: (BuildContext context) {
              return _showHitPanel();
            });
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.only(bottom: 14.w, top: 14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10.w),
              child: Text(
                '我的命中',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 12.w,
                        height: 12.w,
                        margin: EdgeInsets.only(right: 4.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF0000),
                          borderRadius: BorderRadius.circular(15.w),
                        ),
                      ),
                      Text(
                        '基本号码',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14.sp,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12.w, top: 1.5.w),
                        child: Text(
                          '${controller.hitRed}',
                          style: TextStyle(
                            color: const Color(0xFFFF0000),
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                      Text(
                        '个',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 12.w,
                        height: 12.w,
                        margin: EdgeInsets.only(right: 4.w),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(15.w),
                        ),
                      ),
                      Text(
                        '特殊号码',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14.sp,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12.w, top: 1.5.w),
                        child: Text(
                          '${controller.hitBlue}',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                      Text(
                        '个',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _showHitPanel() {
    return GetBuilder<QlcCalculatorController>(builder: (controller) {
      return ModalSheetView(
        title: '我的命中',
        height: Get.height * 9 / 16,
        child: Container(
          padding: EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12.w,
                        height: 12.w,
                        margin: EdgeInsets.only(right: 4.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF0000),
                          borderRadius: BorderRadius.circular(15.w),
                        ),
                      ),
                      Text(
                        '基本号码-命中',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14.sp,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Text(
                          '${controller.hitRed}',
                          style: TextStyle(
                            color: const Color(0xFFFF0000),
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      Text(
                        '个',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.w),
                    child: Wrap(
                      runSpacing: 10.w,
                      spacing: 8.w,
                      children: List.generate(
                        8,
                        (index) => RadioButton(
                          text: '$index',
                          size: 42.w,
                          labelColor: Colors.red,
                          selected: controller.hitRed == index,
                          handle: (value) {
                            controller.hitRed = int.parse(value);
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 12.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 12.w,
                          height: 12.w,
                          margin: EdgeInsets.only(right: 4.w),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(15.w),
                          ),
                        ),
                        Text(
                          '特殊号码-命中',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14.sp,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Text(
                            '${controller.hitBlue}',
                            style: TextStyle(
                              color: const Color(0xFFFF0000),
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        Text(
                          '个',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12.w),
                      child: Row(
                        children: List.generate(
                          2,
                          (index) => RadioButton(
                            text: '$index',
                            size: 42.w,
                            margin: EdgeInsets.only(right: 10.w),
                            labelColor: Colors.blueAccent,
                            selected: controller.hitBlue == index,
                            handle: (value) {
                              controller.hitBlue = int.parse(value);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildCalcBtn(QlcCalculatorController controller) {
    return Container(
      margin: EdgeInsets.only(top: 10.w, bottom: 16.w),
      child: GestureDetector(
        onTap: () {
          controller.calcAwardCounter();
        },
        child: Container(
          width: 200.w,
          height: 34.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFFF0000),
            borderRadius: BorderRadius.circular(20.w),
          ),
          child: Text(
            '计算奖金',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAwardCounter(QlcCalculatorController controller) {
    if (controller.counters.isEmpty) {
      return Container();
    }

    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
          child: Text(
            '总计投注${controller.total}注，所需资金${controller.total * 2}元',
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF888800).withValues(alpha: 0.75),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 12.w, right: 12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: const Color(0xFF888800).withValues(alpha: 0.2),
                width: 0.8.w),
            borderRadius: BorderRadius.circular(4.w),
          ),
          child: Column(
            children: [
              _buildHeader(),
              ..._buildCounterList(controller.counters),
            ],
          ),
        ),
        _buildBottomHint(),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      width: 348.w,
      decoration: BoxDecoration(
        color: const Color(0xFF888800).withValues(alpha: 0.05),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4.w),
          topRight: Radius.circular(4.w),
        ),
      ),
      child: Row(
        children: [
          _buildHeaderCell(
            title: '奖项',
            width: 60.w,
            border: true,
            leftRadius: true,
          ),
          _buildHeaderCell(
            title: '单注奖金',
            width: 72.w,
            border: true,
          ),
          _buildHeaderCell(
            title: '中奖形态',
            width: 72.w,
            border: true,
          ),
          _buildHeaderCell(
            title: '中奖注数',
            width: 72.w,
            border: true,
          ),
          _buildHeaderCell(
            title: '中奖金额',
            width: 72.w,
            rightRadius: true,
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell({
    required String title,
    required double width,
    bool border = false,
    bool leftRadius = false,
    bool rightRadius = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(leftRadius ? 4.w : 0),
          topRight: Radius.circular(rightRadius ? 4.w : 0),
        ),
      ),
      child: Container(
        width: width,
        height: 30.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                color: const Color(0xFF888800).withValues(alpha: 0.2),
                width: 0.5.w),
            right: border
                ? BorderSide(
                    color: const Color(0xFF888800).withValues(alpha: 0.2),
                    width: 0.5.w)
                : BorderSide.none,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: const Color(0xFF888800),
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCounterList(List<AwardCounter> counters) {
    List<Widget> rows = [];
    for (int i = 0; i < counters.length; i++) {
      rows.add(
        _buildCounter(
          counters[i],
          i % 2 == 1 ? const Color(0xFFF8F8F8) : Colors.white,
          i == counters.length - 1,
        ),
      );
    }
    return rows;
  }

  Widget _buildCounter(
    AwardCounter counter,
    Color color,
    bool radius,
  ) {
    return Container(
      width: 348.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(radius ? 4.w : 0),
          bottomRight: Radius.circular(radius ? 4.w : 0),
        ),
      ),
      child: Row(
        children: [
          _buildCounterCell(
            title: counter.level.level,
            width: 60.w,
            right: true,
            color: color,
            leftRadius: radius,
            bottom: !radius,
          ),
          _buildCounterCell(
            title:
                '${counter.level.idx <= 3 ? '${levelAwards[counter.level.idx]}浮动' : counter.level.award}',
            width: 72.w,
            right: true,
            color: color,
            bottom: !radius,
          ),
          _buildCounterCell(
            title: '${counter.level.red}+${counter.level.blue}',
            width: 72.w,
            right: true,
            color: color,
            bottom: !radius,
          ),
          _buildCounterCell(
            title: '${counter.count}',
            width: 72.w,
            right: true,
            color: color,
            bottom: !radius,
          ),
          _buildCounterCell(
            title: counter.getAward(3),
            width: 72.w,
            color: color,
            bottom: !radius,
            rightRadius: radius,
          ),
        ],
      ),
    );
  }

  Widget _buildCounterCell({
    required String title,
    required double width,
    Color txtColor = Colors.black45,
    Color color = const Color(0xFFF6F6F6),
    bool right = false,
    bool bottom = false,
    bool leftRadius = false,
    bool rightRadius = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(leftRadius ? 4.w : 0),
          bottomRight: Radius.circular(rightRadius ? 4.w : 0),
        ),
      ),
      child: Container(
        width: width,
        height: 28.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            bottom: bottom
                ? BorderSide(
                    color: const Color(0xFF888800).withValues(alpha: 0.2),
                    width: 0.5.w)
                : BorderSide.none,
            right: right
                ? BorderSide(
                    color: const Color(0xFF888800).withValues(alpha: 0.2),
                    width: 0.5.w)
                : BorderSide.none,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(color: txtColor, fontSize: 12.sp),
        ),
      ),
    );
  }

  Widget _buildBottomHint() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 1.w),
            child: Icon(
              const IconData(0xe63d, fontFamily: 'iconfont'),
              size: 11.sp,
              color: const Color(0xFFD2B48C).withValues(alpha: 0.5),
            ),
          ),
          Text(
            '开奖信息仅供参考，请以官方开奖信息为准',
            style: TextStyle(
              color: Colors.black12,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
