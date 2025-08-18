import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/utils/date_util.dart';
import 'package:prize_lottery_app/views/glad/widgets/master_recommend_panel.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_detail_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_detail.dart';
import 'package:prize_lottery_app/views/master/model/random_master.dart';
import 'package:prize_lottery_app/widgets/common_widgets.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:visibility_detector/visibility_detector.dart';

class LotteryDetailView extends StatelessWidget {
  ///
  ///
  const LotteryDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '${lotteryZhCns[Get.parameters['type'] ?? ''] ?? ''}开奖详情',
      content: Container(
        color: Colors.white,
        child: RequestWidget<LotteryDetailController>(
          builder: (controller) {
            return  ScrollConfiguration(
                behavior: CustomScrollBehavior(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildRecommendView(controller.masters),
                      Container(height: 8.w, color: const Color(0xFFF6F7F9)),
                      _buildLotteryView(controller.lottery!),
                      Container(height: 8.w, color: const Color(0xFFF6F7F9)),
                      _buildLotteryLevel(controller),
                    ],
                  ),
                ),
              );
          },
        ),
      ),
    );
  }

  ///
  /// 开奖数据
  Widget _buildLotteryView(LotteryDetail detail) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.w),
                        child: Text(
                          '${detail.lottery.period}期',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            DateUtil.formatDate(
                              DateUtil.parse(
                                detail.lottery.lotDate,
                                pattern: 'yyyy/MM/dd',
                              ),
                              format: 'yyyy-MM-dd',
                            ),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black45,
                            ),
                          ),
                          Container(
                            width: 2.w,
                            height: 2.w,
                            margin: EdgeInsets.symmetric(horizontal: 6.w),
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(4.w),
                            ),
                          ),
                          Text(
                            Constants.dayWeek(DateUtil.parse(
                                detail.lottery.lotDate,
                                pattern: "yyyy/MM/dd")),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (detail.lottery.type == 'fc3d' ||
                        detail.lottery.type == 'ssq' ||
                        detail.lottery.type == 'qlc' ||
                        detail.lottery.type == 'kl8') {
                      Get.toNamed(AppRoutes.fucaiHistory);
                      return;
                    }
                    Get.toNamed(
                        '${AppRoutes.sportHistory}?date=${detail.lottery.lotDate}');
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 26.w,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.circular(20.w),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 2.w),
                          child: Icon(
                            const IconData(0xe679, fontFamily: 'iconfont'),
                            size: 17.w,
                            color: const Color(0xBB000000),
                          ),
                        ),
                        Text(
                          '回放',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: const Color(0xBB000000),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/${detail.lottery.type}/trend/0');
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 26.w,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 8.w),
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.circular(20.w),
                    ),
                    child: Text(
                      '走势分析',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: const Color(0xBB000000),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16.w),
            child: Row(
              mainAxisAlignment: detail.lottery.shi.isNotEmpty
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Wrap(
                    alignment: detail.lottery.shi.isEmpty &&
                            detail.lottery.type != 'kl8'
                        ? WrapAlignment.center
                        : WrapAlignment.start,
                    runSpacing: 4.w,
                    children: CommonWidgets.ballView(
                      detail.lottery.redBalls(),
                      detail.lottery.blueBalls(),
                      false,
                    ),
                  ),
                ),
                detail.lottery.shi.isNotEmpty
                    ? Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: CommonWidgets.ballView(
                            detail.lottery.shiBalls(),
                            [],
                            true,
                          ),
                        ),
                      )
                    : const Offstage(
                        offstage: true,
                      ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 4.w),
                      child: Text(
                        '本期销售',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    Text(
                      '${detail.award.sales}',
                      style: TextStyle(
                        color: const Color(0xFFFF0033),
                        fontSize: 17.sp,
                        fontFamily: 'bebas',
                      ),
                    )
                  ],
                ),
              ),
              Constants.verticalLine(
                width: 0.08,
                height: 24.w,
                color: Colors.black,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 4.w),
                      child: Text(
                        '下期奖池',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    Text(
                      '${detail.award.pool}',
                      style: TextStyle(
                        color: const Color(0xFFFF0033),
                        fontSize: 17.sp,
                        fontFamily: 'bebas',
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLotteryLevel(LotteryDetailController controller) {
    List<LotteryLevel> levels = controller.lottery!.levels;
    if (levels.isEmpty) {
      return Container();
    }
    List<TableRow> rows = [];
    rows.add(
      TableRow(
        decoration: BoxDecoration(
            color: Colors.black12.withValues(alpha: 0.01),
            borderRadius: BorderRadius.circular(4.w)),
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 6.w, bottom: 6.w),
            child: Text(
              '等级',
              style: TextStyle(
                color: Colors.black38,
                fontSize: 13.sp,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 6.w, bottom: 6.w),
            child: Text(
              '注数',
              style: TextStyle(
                color: Colors.black38,
                fontSize: 13.sp,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 6.w, bottom: 6.w),
            child: Text(
              '单注奖金',
              style: TextStyle(
                color: Colors.black38,
                fontSize: 13.sp,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 6.w, bottom: 6.w),
            child: Text(
              '总金额',
              style: TextStyle(
                color: Colors.black38,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
    int limit =
        controller.limit >= levels.length ? levels.length : controller.limit;
    for (int i = 0; i < limit; i++) {
      LotteryLevel level = levels[i];
      rows.add(
        TableRow(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 12.w),
              child: Text(
                Constants.level(level.type, level.level),
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 12.sp,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 12.w),
              child: Text(
                '${level.quantity}',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 11.sp,
                  fontFamily: 'bebas',
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 12.w),
              child: Text(
                '${level.bonus == 0 ? '-' : level.bonus}',
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 11.sp,
                  fontFamily: level.bonus == 0 ? null : 'bebas',
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 12.w),
              child: Text(
                '${level.amount}',
                style: TextStyle(
                  color: const Color(0xFFFF0033),
                  fontSize: 11.sp,
                  fontFamily: 'bebas',
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      color: const Color(0xFFF6F7F9),
      padding: EdgeInsets.only(bottom: 8.w),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          left: 12.w,
          right: 12.w,
          top: 12.w,
          bottom: 16.w,
        ),
        child: Column(
          children: [
            Table(
              columnWidths: const {
                0: FlexColumnWidth(),
                1: FlexColumnWidth(),
                2: FlexColumnWidth(),
                3: FlexColumnWidth(),
              },
              children: rows,
            ),
            if (limit < levels.length)
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  controller.showAllLevel();
                },
                child: Container(
                  padding: EdgeInsets.only(top: 16.w, bottom: 4.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '展开全部',
                        style:
                            TextStyle(color: Colors.black54, fontSize: 14.sp),
                      ),
                      Icon(
                        const IconData(0xe636, fontFamily: 'iconfont'),
                        size: 14.w,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendView(List<RandomMaster> masters) {
    if (masters.isEmpty) {
      return const SizedBox.shrink();
    }
    return MasterRecommendPanel<RandomMaster>(
      masters: masters,
      tapCallback: (e) {
        Get.toNamed('/${e.type}/master/${e.master.masterId}');
      },
      hitCallback: (master) {
        return master.achieve;
      },
    );
  }
}
