import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:graphic/graphic.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/resources/styles.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/store/store.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/user/controller/agent_account_controller.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/nav_app_bar.dart';

class AgentAccountView extends StatefulWidget {
  const AgentAccountView({super.key});

  @override
  State<AgentAccountView> createState() => _AgentAccountViewState();
}

class _AgentAccountViewState extends State<AgentAccountView> {
  ///
  ///
  final ScrollController _scrollController = ScrollController();

  ///
  final StreamController<double> _streamController =
      StreamController<double>.broadcast();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: UiStyle.dark,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7F9),
        body: SafeArea(
          top: false,
          child: Stack(
            children: [
              RequestWidget<AgentAccountController>(
                builder: (controller) {
                  return ScrollConfiguration(
                    behavior: CustomScrollBehavior(),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          _buildAccountView(controller),
                          _buildAggregatePanel(controller),
                          _buildMetricsPanel(controller),
                          _buildCensusHintPanel(),
                        ],
                      ),
                    ),
                  );
                },
              ),
              StreamBuilder(
                stream: _streamController.stream,
                initialData: 0.0,
                builder: (_, snapshot) {
                  return AgentTopHeader(
                    top: MediaQuery.of(context).padding.top,
                    shrinkOffset: snapshot.data!,
                    onTap: () {
                      showDialog(
                          context: Get.context!,
                          barrierDismissible: false,
                          builder: (context) {
                            return _headerDialog();
                          });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerDialog() {
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
              '账户说明',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.w),
              child: Text(
                '1.流量主需要用户自行申请，经系统运营人员审核用过后开通，分享用户后会产生收益。'
                '\n2.流量主账户获得收益会实时进行结算，收益相关统计指标在每日凌晨进行汇总更新。'
                '\n3.账户收益金币兑换比例为1000金币=1元，收益提现时会自动扣除金币兑换成人民币。',
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

  Widget _buildAccountView(AgentAccountController controller) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 20.w,
        top: MediaQuery.of(context).padding.top + 44.w,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.withValues(alpha: 0.4),
            Colors.blue.withValues(alpha: 0.1),
          ],
        ),
      ),
      child: Container(
        height: 154.h,
        alignment: Alignment.center,
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.w),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              const Color(0xFF2254F4).withValues(alpha: 0.8),
              const Color(0xFF2254F4).withValues(alpha: 0.4),
              const Color(0xFF2254F4).withValues(alpha: 0.25),
            ],
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 6.w),
                  child: Image.asset(
                    controller.avatar,
                    width: 42.h,
                    height: 42.h,
                  ),
                ),
                Container(
                  height: 42.h,
                  padding: EdgeInsets.only(left: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GetBuilder<UserStore>(
                        builder: (store) {
                          return Text(
                            Tools.encodeTel(store.authUser!.phone),
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                      Text(
                        controller.account.agent.description,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10.w,
                bottom: 8.w,
                left: 10.w,
                right: 10.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        '${controller.account.income}',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontFamily: 'bebas',
                        ),
                      ),
                      Text(
                        '账户余额',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      margin: EdgeInsets.only(right: 12.w),
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 5.w,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.w),
                      ),
                      child: Text(
                        '收益提现',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.brown,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: '累计提现：',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12.sp,
                      ),
                      children: [
                        TextSpan(
                          text: controller.account.withdrawText(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp,
                          ),
                        ),
                        const TextSpan(text: '元'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12.w),
                    child: Text(
                      '最近提现日期：${controller.account.withLatest.isEmpty ? '暂未提现' : controller.account.withLatest}',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12.sp,
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
  }

  Widget _buildAggregatePanel(AgentAccountController controller) {
    return Container(
      color: Colors.blue.withValues(alpha: 0.1),
      margin: EdgeInsets.only(bottom: 12.w),
      child: Container(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 16.w,
          bottom: 20.w,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.w),
            topRight: Radius.circular(12.w),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 14.w),
              child: Text(
                '账户汇总指标',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildMetricsItem(
                    title: '总收益',
                    total: controller.account.income,
                    today: controller.account.todayIncome,
                    onTap: () {
                      Get.toNamed(AppRoutes.agentIncome);
                    },
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _buildMetricsItem(
                    title: '邀请人数',
                    total: controller.account.invites,
                    today: controller.account.todayInvites,
                    onTap: () {
                      Get.toNamed(AppRoutes.inviteHistory);
                    },
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _buildMetricsItem(
                    title: '付费人次',
                    total: controller.account.users,
                    today: controller.account.todayUsers,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsItem({
    required String title,
    int total = 0,
    int today = 0,
    GestureTapCallback? onTap,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.w),
        border: Border.all(color: Colors.black12, width: 0.25.w),
      ),
      child: GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black54,
                  ),
                ),
                if (onTap != null)
                  Icon(
                    const IconData(0xe613, fontFamily: 'iconfont'),
                    size: 14.sp,
                    color: Colors.black26,
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.w),
              child: Text(
                '$total',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16.sp,
                  fontFamily: 'bebas',
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '今日',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12.sp,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.w),
                  child: Text(
                    '${today == 0 ? '— —' : today}',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xFF2254F4),
                      fontFamily: 'bebas',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsPanel(AgentAccountController controller) {
    return Container(
      color: Colors.white,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '账户趋势指标',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
            ),
          ),
          _buildMetricsDays(controller),
          _buildMetricsChart(controller),
          _buildChartHint(),
        ],
      ),
    );
  }

  Widget _buildMetricsDays(AgentAccountController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.w),
      child: Container(
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(2.w),
        ),
        child: Row(
          children: metricsDays
              .map(
                (e) => Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.metricsDay = e;
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.w),
                        color: e == controller.metricsDay
                            ? Colors.white
                            : Colors.transparent,
                      ),
                      child: Text(
                        '最近$e天',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: e == controller.metricsDay
                              ? const Color(0xFF2254F4)
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildMetricsChart(AgentAccountController controller) {
    return Container(
      height: 220.w,
      padding: EdgeInsets.only(top: 8.w, bottom: 4.w),
      child: Chart(
        rebuild: true,
        data: controller.datas,
        axes: [
          Defaults.horizontalAxis,
          Defaults.verticalAxis,
        ],
        variables: {
          'day': Variable(
            accessor: (Map map) => map['day'] as String,
            scale: OrdinalScale(tickCount: 7, inflate: true),
          ),
          'name': Variable(
            accessor: (Map map) => map['name'] as String,
          ),
          'value': Variable(
            accessor: (Map map) => (map['value'] ?? 0) as num,
            scale: LinearScale(min: 0, max: controller.maxValue),
          ),
        },
        marks: [
          LineMark(
            position: Varset('day') * Varset('value') / Varset('name'),
            shape: ShapeEncode(value: BasicLineShape(smooth: true)),
            size: SizeEncode(value: 1.8),
            color: ColorEncode(
              variable: 'name',
              values: Defaults.colors10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartHint() {
    return Padding(
      padding: EdgeInsets.only(top: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _chartHintItem(
            title: '账户收益',
            color: Defaults.colors10[0],
          ),
          SizedBox(width: 16.w),
          _chartHintItem(
            title: '邀请人数',
            color: Defaults.colors10[1],
          ),
          SizedBox(width: 16.w),
          _chartHintItem(
            title: '付费人次',
            color: Defaults.colors10[2],
          ),
        ],
      ),
    );
  }

  Widget _chartHintItem({required String title, required Color color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 6.w,
          height: 6.w,
          color: color,
          margin: EdgeInsets.only(right: 4.w),
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.black45,
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildCensusHintPanel() {
    return Container(
      color: Colors.white,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 16.w,
        bottom: 36.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 12.w),
            child: Text(
              '账户指标说明',
              style: TextStyle(
                height: 1.25,
                fontSize: 16.sp,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 4.w),
            child: Text(
              '1.账户趋势统计数据仅支持查询7、14、30天内三个时间段的趋势指标统计图。',
              style: TextStyle(
                height: 1.25,
                fontSize: 13.sp,
                color: Colors.black54,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 4.w),
            child: Text(
              '2.账户统计指标每日凌晨左右更新前一天数据,没有数据数据默认为0。',
              style: TextStyle(
                height: 1.25,
                fontSize: 13.sp,
                color: Colors.black54,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 4.w),
            child: Text(
              '3.账户指标由“账户收益”、“邀请人数”、“贡献收益人数”三个指标组成。',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _streamController.sink.add(_scrollController.offset);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class AgentTopHeader extends StatelessWidget {
  ///
  /// 垂直偏移量
  final double verticalOffset = 50.h;

  ///收缩高度
  final double height = 44.h;

  ///
  final double shrinkOffset;

  ///
  final double top;
  final GestureTapCallback onTap;

  AgentTopHeader({
    super.key,
    required this.top,
    required this.shrinkOffset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: top + height,
      color: shrinkColor(shrinkOffset),
      child: Column(
        children: [
          SizedBox(
            height: top,
            width: Get.width,
          ),
          Container(
            width: Get.width,
            alignment: Alignment.center,
            child: NavAppBar(
              border: false,
              color: Colors.transparent,
              center: Text(
                '流量主账户',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18.sp,
                ),
              ),
              left: Container(
                width: 40.w,
                height: 32.w,
                alignment: Alignment.centerLeft,
                child: Icon(
                  const IconData(0xe669, fontFamily: 'iconfont'),
                  size: 20.w,
                  color: Colors.black87,
                ),
              ),
              right: GestureDetector(
                onTap: () {
                  onTap();
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
            ),
          ),
        ],
      ),
    );
  }

  Color shrinkColor(double shrinkOffset) {
    if (shrinkOffset == 0) {
      return Colors.transparent;
    }
    if (shrinkOffset <= verticalOffset) {
      int alpha = (shrinkOffset / verticalOffset * 255).clamp(0, 255).toInt();
      return Color.fromARGB(alpha, 255, 255, 255);
    }
    return Colors.white;
  }
}
