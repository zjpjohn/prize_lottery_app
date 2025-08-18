import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/resources/styles.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/utils/date_util.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_center_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/views/lottery/widgets/calendar_button.dart';
import 'package:prize_lottery_app/views/lottery/widgets/lottery_calendar.dart';
import 'package:prize_lottery_app/widgets/animate_view.dart';
import 'package:prize_lottery_app/widgets/common_widgets.dart';
import 'package:prize_lottery_app/widgets/lottery_hint_widget.dart';

class LotteryCenterView extends StatefulWidget {
  ///
  const LotteryCenterView({super.key});

  @override
  LotteryCenterViewState createState() => LotteryCenterViewState();
}

class LotteryCenterViewState extends State<LotteryCenterView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  ///
  late AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Get.put<LotteryCenterController>(LotteryCenterController());
    return AnnotatedRegion(
      value: UiStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Container(
                  color: const Color(0xFFF8F8FB),
                  child: RefreshWidget<LotteryCenterController>(
                    enableLoad: false,
                    bottomBouncing: false,
                    builder: (controller) {
                      return ListView(
                        padding: EdgeInsets.only(top: 10.w),
                        children: _buildAnimateLotteryView(controller),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAnimateLotteryView(LotteryCenterController controller) {
    List<Widget> views = [];
    List<LotteryInfo> lotteries = controller.channelLotteries;
    int count = lotteries.length;
    for (int i = 0; i < count; i++) {
      Animation<double> animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      animationController.forward();
      views.add(
        AnimateView(
          animation: animation,
          controller: animationController,
          child: _buildLotteryItem(lotteries[i]),
        ),
      );
    }
    views.add(
      Padding(
        padding: EdgeInsets.only(top: 8.w, bottom: 20.w),
        child: const LotteryHintWidget(
          hint: '本应用不提供购彩服务，请理性购彩',
        ),
      ),
    );
    return views;
  }

  Widget _buildLotteryItem(LotteryInfo lottery) {
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 12.w,
              right: 12.w,
              top: 17.w,
              bottom: 12.w,
            ),
            child: Column(
              children: [
                _buildLotteryInfo(lottery),
                _buildLotteryBall(lottery),
                _buildLotteryChannel(lottery),
              ],
            ),
          ),
          Positioned(
            top: 0.4.w,
            left: 0.4.w,
            child: Constants.todayOpen(
                    type: lottery.type, dateTime: DateTime.now())
                ? Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.w),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.w),
                        bottomRight: Radius.circular(8.w),
                      ),
                    ),
                    child: Text(
                      '今日开奖',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: const Color(0xFFFF0033),
                      ),
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  Widget _buildLotteryInfo(LotteryInfo lottery) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  Constants.lottery(lottery.type),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.w, right: 4.w),
                  child: Text(
                    '${lottery.period}期',
                    style: TextStyle(color: Colors.black87, fontSize: 13.sp),
                  ),
                ),
                Text(
                  DateUtil.formatDate(
                      DateUtil.parse(lottery.lotDate, pattern: 'yyyy/MM/dd'),
                      format: 'yy/MM/dd'),
                  style: TextStyle(fontSize: 13.sp, color: Colors.black54),
                ),
                Text(
                  lottery.lotDate.isEmpty
                      ? ''
                      : Constants.dayWeek(
                          DateUtil.parse(
                            lottery.lotDate,
                            pattern: "yy/MM/dd",
                          ),
                        ),
                  style: TextStyle(fontSize: 12.sp, color: Colors.black54),
                )
              ],
            ),
          ),
          Constants.todayOpen(type: lottery.type, dateTime: DateTime.now())
              ? GestureDetector(
                  onTap: () {
                    if (lottery.type == 'fc3d' ||
                        lottery.type == 'ssq' ||
                        lottery.type == 'qlc' ||
                        lottery.type == 'kl8') {
                      Get.toNamed(AppRoutes.fucaiLive);
                      return;
                    }
                    Get.toNamed(AppRoutes.sportLive);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 2.w),
                        child: Icon(
                          const IconData(0xe68a, fontFamily: 'iconfont'),
                          size: 17.w,
                          color: const Color(0xFFFF0033),
                        ),
                      ),
                      Text(
                        '直播开奖',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: const Color(0xFFFF0033),
                        ),
                      )
                    ],
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    if (lottery.type == 'fc3d' ||
                        lottery.type == 'ssq' ||
                        lottery.type == 'qlc' ||
                        lottery.type == 'kl8') {
                      Get.toNamed(AppRoutes.fucaiHistory);
                      return;
                    }
                    Get.toNamed(
                        '${AppRoutes.sportHistory}?date=${lottery.lotDate}');
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 1.w),
                        child: Icon(
                          const IconData(0xe679, fontFamily: 'iconfont'),
                          size: 17.w,
                          color: Colors.black38,
                        ),
                      ),
                      Text(
                        '开奖回放',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black38,
                        ),
                      )
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildLotteryBall(LotteryInfo lottery) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.w),
      child: Row(
        mainAxisAlignment: lottery.shi.isNotEmpty
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
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
          lottery.shi.isNotEmpty
              ? Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: CommonWidgets.ballView(
                      lottery.shiBalls(),
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
    );
  }

  Widget _buildLotteryChannel(LotteryInfo lottery) {
    return GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 10.w,
      crossAxisSpacing: 12.w,
      childAspectRatio: 2.75,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: channelEntries[lottery.type]!.map((entry) {
        return GestureDetector(
          onTap: () {
            entry.route();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: Text(
              entry.name,
              style: TextStyle(
                color: Colors.red.withValues(alpha: 0.8),
                fontSize: 12.5.sp,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  ///
  ///
  Widget _buildHeader() {
    return Container(
      height: 44.w,
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CalendarButton(
            day: DateTime.now().day,
            handle: () {
              _showLotteryCalendar();
            },
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.assistant);
            },
            behavior: HitTestBehavior.opaque,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '助手',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xAA000000),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.w),
                  child: Image.asset(
                    R.assistIcon,
                    height: 15.w,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// 今日开奖日历
  void _showLotteryCalendar() {
    Constants.bottomSheet(const LotteryCalendar());
  }

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
