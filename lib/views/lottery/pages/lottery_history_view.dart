import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/utils/date_util.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_history_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/widgets/common_widgets.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class LotteryHistoryView extends StatefulWidget {
  const LotteryHistoryView({super.key});

  @override
  LotteryHistoryViewState createState() => LotteryHistoryViewState();
}

class LotteryHistoryViewState extends State<LotteryHistoryView> {
  ///
  ///
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '${lotteryZhCns[Get.parameters['type'] ?? ''] ?? ''}往期开奖',
      content: Container(
        color: const Color(0xFFF6F6F6),
        child: RefreshWidget<LotteryHistoryController>(
          scrollController: _scrollController,
          topConfig: const ScrollTopConfig(align: TopAlign.right),
          builder: (controller) => ListView.builder(
            padding: EdgeInsets.only(top: 8.w),
            itemCount: controller.lotteries.length,
            itemBuilder: (context, index) => _buildLotteryItem(
              lottery: controller.lotteries[index],
              limit: controller.query.limit,
              index: index,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLotteryItem({
    required LotteryInfo lottery,
    required int limit,
    required int index,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.w),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed('/lotto/detail/${lottery.type}/${lottery.period}');
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 18.w,
                bottom: 8.w,
              ),
              child: Column(
                children: [
                  _buildLotteryInfo(lottery),
                  _buildLotteryBall(lottery),
                  _buildLotteryPattern(lottery),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLotteryInfo(LotteryInfo lottery) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              '${lottery.period}期',
              style: TextStyle(color: Colors.black, fontSize: 14.sp),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 4.w),
                  child: Text(
                    lottery.lotDate,
                    style: TextStyle(fontSize: 13.sp, color: Colors.black54),
                  ),
                ),
                Text(
                  Constants.dayWeek(
                      DateUtil.parse(lottery.lotDate, pattern: "yyyy/MM/dd")),
                  style: TextStyle(fontSize: 12.sp, color: Colors.black54),
                ),
                Icon(
                  const IconData(0xe613, fontFamily: 'iconfont'),
                  size: 12.w,
                  color: Colors.black26,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLotteryBall(LotteryInfo lottery) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.w),
      child: Row(
        mainAxisAlignment: lottery.shi.isNotEmpty
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        children: [
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 4.w,
              children: CommonWidgets.lottery(
                lottery.redBalls(),
                lottery.blueBalls(),
                false,
              ),
            ),
          ),
          lottery.shi.isNotEmpty
              ? Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: CommonWidgets.lottery(
                      lottery.shiBalls(),
                      [],
                      true,
                    ),
                  ),
                )
              : const Offstage(offstage: true),
        ],
      ),
    );
  }

  Widget _buildLotteryPattern(LotteryInfo lottery) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: CommonWidgets.lotteryPattern(
          lottery.redBalls(),
          lottery.type == 'fc3d' || lottery.type == 'pl3',
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
