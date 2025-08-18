import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/views/recom/controller/fc3d_warning_controller.dart';
import 'package:prize_lottery_app/views/recom/model/n3_warn_recommend.dart';
import 'package:prize_lottery_app/views/recom/widgets/member_hint_widget.dart';
import 'package:prize_lottery_app/views/recom/widgets/warn_mock_widget.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class Fc3dWarningView extends StatelessWidget {
  ///
  ///
  const Fc3dWarningView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '预警推荐',
      right: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return _headerDialog(context);
              });
        },
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Icon(
            const IconData(0xe607, fontFamily: 'iconfont'),
            size: 20.sp,
            color: Colors.black87,
          ),
        ),
      ),
      content: RequestWidget<Fc3dWarningController>(
        emptyText: '暂无预警推荐内容',
        builder: (controller) {
          return Stack(
            children: [
              ScrollConfiguration(
                behavior: CustomScrollBehavior(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildWarnHeader(controller),
                      _buildLastAnalyze(controller),
                      _buildWarnContent(controller),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 16.w,
                bottom: Get.height / 2 - 88.h,
                child: _buildPeriodView(controller),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _headerDialog(BuildContext context) {
    return Center(
      child: Container(
        width: 280.w,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '预警分析说明',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.w),
              child: Text(
                '1.预警分析功能是系统对本期开奖数据进行分析给出定胆、杀码以及跨度等预警，并给出优选的组选号码。'
                '\n2.预警分析最新分析数据会在下午17:30点至19点发布，期间可能会对数据进行多次修正。'
                '\n3.预警分析给出的组选号码相对较多，请用户结合自身选号经验，选择自己看中的组合。',
                style: TextStyle(
                  color: const Color(0xFF666666),
                  fontSize: 14.sp,
                  height: 1.5,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 200.w,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 8.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2254F4).withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                  child: Text(
                    '我知道啦',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodView(Fc3dWarningController controller) {
    return Container(
      width: 34.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.w),
        border: Border.all(color: Colors.black26, width: 0.4.w),
      ),
      padding: EdgeInsets.symmetric(vertical: 10.w),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (!controller.isFirst()) {
                controller.prevPeriod();
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Column(
              children: [
                Icon(
                  const IconData(0xe682, fontFamily: 'iconfont'),
                  size: 14.w,
                  color: controller.isFirst()
                      ? Colors.black26
                      : const Color(0xFFFF0033),
                ),
                Text(
                  '上期',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: controller.isFirst()
                        ? Colors.black26
                        : const Color(0xFFFF0033),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.4.w,
            width: 34.w,
            color: Colors.black26,
            margin: EdgeInsets.symmetric(vertical: 10.w),
          ),
          GestureDetector(
            onTap: () {
              if (!controller.isEnd()) {
                controller.nextPeriod();
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Column(
              children: [
                Text(
                  '下期',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: controller.isEnd()
                        ? Colors.black26
                        : const Color(0xFFFF0033),
                  ),
                ),
                Icon(
                  const IconData(0xe683, fontFamily: 'iconfont'),
                  size: 14.w,
                  color: controller.isEnd()
                      ? Colors.black26
                      : const Color(0xFFFF0033),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarnHeader(Fc3dWarningController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.w),
            child: Text(
              controller.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '福彩3D',
                    style: TextStyle(
                      color: const Color(0xFFFF0033),
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    '·第${controller.recommend.period}期',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              RichText(
                text: TextSpan(
                  text: '${controller.recommend.data!.browses}',
                  style: TextStyle(
                    color: const Color(0xFFFF0033),
                    fontSize: 14.sp,
                  ),
                  children: [
                    TextSpan(
                      text: '人查看',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLastAnalyze(Fc3dWarningController controller) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        bottom: 12.w,
      ),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 6.w),
            child: Text(
              '第${controller.recommend.data!.last.period}期开奖回顾:',
              style: TextStyle(
                fontSize: 17.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ..._buildLottery(controller.recommend.data!.last),
        ],
      ),
    );
  }

  List<Widget> _buildLottery(Lottery lottery) {
    return [
      RichText(
        text: TextSpan(
          text: '本期开奖号码：',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.sp,
          ),
          children: [
            TextSpan(
              text: lottery.red.join('、'),
            ),
          ],
        ),
      ),
      Row(
        children: [
          SizedBox(
            width: 156.w,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                ),
                children: [
                  const TextSpan(text: '开奖号码形态：'),
                  TextSpan(
                    text: '${lottery.pattern}',
                    style: TextStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 156.w,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                ),
                children: [
                  const TextSpan(
                    text: '开奖号码跨度：',
                  ),
                  TextSpan(
                    text: '${lottery.kua}',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          SizedBox(
            width: 156.w,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                ),
                children: [
                  const TextSpan(
                    text: '开奖号码和值：',
                  ),
                  TextSpan(
                    text: '${lottery.sum}',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 156.w,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                ),
                children: [
                  const TextSpan(
                    text: '开奖和值尾数：',
                  ),
                  TextSpan(
                    text: '${lottery.sumTail}',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          SizedBox(
            width: 156.w,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                ),
                children: [
                  const TextSpan(
                    text: '开奖号码奇偶：',
                  ),
                  TextSpan(
                    text: '${lottery.oddEven}',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 156.w,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                ),
                children: [
                  const TextSpan(
                    text: '开奖号码质合：',
                  ),
                  TextSpan(
                    text: '${lottery.primeRatio}',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ];
  }

  Widget _buildWarnContent(Fc3dWarningController controller) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        bottom: 16.w,
      ),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.w),
            child: Text(
              '第${controller.recommend.period}期预警分析:',
              style: TextStyle(
                fontSize: 17.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 12.w),
            child: Text(
              '根据上期开奖数据及形态多维指标，结合本期专家推荐数据通过系统算法综合计算分析，本期可能选号预警推荐如下:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
              ),
            ),
          ),
          controller.recommend.feeRequired
              ? _buildUnAuthedContent(controller)
              : _buildAuthedContent(controller)
        ],
      ),
    );
  }

  Widget _buildAuthedContent(Fc3dWarningController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.recommend.data!.warning(key: 'DAN_WARNING') != null)
          warnItem(
            '胆码预警',
            controller.recommend.data!.warning(key: 'DAN_WARNING')!,
          ),
        if (controller.recommend.data!.warning(key: 'KILL_WARNING') != null)
          warnItem(
            '杀码预警',
            controller.recommend.data!.warning(key: 'KILL_WARNING')!,
          ),
        SizedBox(height: 8.w),
        if (controller.recommend.data!.warning(key: 'KUA_WARNING', limit: 7) !=
            null)
          warnItem(
            '跨度预警',
            controller.recommend.data!.warning(key: 'KUA_WARNING')!,
          ),
        if (controller.recommend.data!.warning(key: 'TAIL_WARNING', limit: 7) !=
            null)
          warnItem(
            '和尾预警',
            controller.recommend.data!.warning(key: 'TAIL_WARNING')!,
          ),
        if (controller.recommend.data!.warning(key: 'SUM_WARNING') != null)
          warnItem(
            '和值预警',
            controller.recommend.data!.warning(key: 'SUM_WARNING')!,
          ),
        SizedBox(height: 8.w),
        recommendItem(controller.recommend.data!.zu3!),
        recommendItem(controller.recommend.data!.zu6!),
        SizedBox(height: 12.w),
        if (controller.recommend.data!.current != null)
          ..._buildLottery(controller.recommend.data!.current!),
        _buildWarnHint(),
      ],
    );
  }

  Widget _buildUnAuthedContent(Fc3dWarningController controller) {
    return GestureDetector(
      onTap: () {
        Get.offNamed(AppRoutes.member);
      },
      child: Column(
        children: [
          Stack(
            children: [
              ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 2.5.w, sigmaY: 2.5.w),
                child: const WarnMockWidget(),
              ),
              MemberHintWidget(
                width: Get.width - 32.w,
                height: 200.w,
                period: controller.recommend.period,
                name: '预警推荐',
              ),
            ],
          ),
          _buildWarnHint(),
        ],
      ),
    );
  }

  Widget warnItem(String title, List<String> values) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 22.w,
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: 4.w),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
            ),
          ),
        ),
        Expanded(
          child: Wrap(
            children: values.map((e) {
              return Container(
                height: 22.w,
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Text(
                  e,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontFamily: 'shuhei',
                    color: const Color(0xCC000000),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget recommendItem(ComRecommend recommend) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 22.w,
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: 4.w),
          child: Text(
            '${recommend.channel}推荐',
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(
          child: Wrap(
            children: recommend.items.map((e) {
              return Container(
                height: 22.w,
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: e.valueView(),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildWarnHint() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.w),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            '以上内容仅供参考，不作为投注依据，请您理性购彩',
            style: TextStyle(
              color: Colors.black26,
              fontSize: 11.sp,
            ),
          ),
          Text(
            '奖金说明：预警分析推荐按理论命中中奖计算，非实际购买中奖',
            style: TextStyle(
              color: Colors.black26,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }
}
