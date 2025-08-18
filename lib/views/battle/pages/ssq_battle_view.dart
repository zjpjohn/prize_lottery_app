import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/model/forecast_value.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/battle/controller/ssq_battle_controller.dart';
import 'package:prize_lottery_app/views/battle/model/master_battle.dart';
import 'package:prize_lottery_app/views/battle/widgets/battle_request_widget.dart';
import 'package:prize_lottery_app/views/battle/widgets/battle_scroll_widget.dart';
import 'package:prize_lottery_app/views/forecast/model/ssq_forecast_info.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';

class SsqBattleView extends StatefulWidget {
  ///
  const SsqBattleView({super.key});

  @override
  SsqBattleViewState createState() => SsqBattleViewState();
}

final double cellWidth240 = 300.h;
final double cellWidth220 = 240.h;
final double cellWidth160 = 160.h;
final double cellWidth140 = 140.h;
final double cellWidth100 = 100.h;
final double cellWidth80 = 80.h;
final double cellHeaderWidth = 100.h;
final double headerHeight = 34.h;
final double cellHeight = 60.h;
final double contentWidth = 1600.h;

class SsqBattleViewState extends State<SsqBattleView> {
  ///顶部左右滑动
  late ScrollController _topController;

  ///钉在上侧的滑动
  late ScrollController _dingController;

  ///左侧上下滑动
  late ScrollController _leftController;

  ///body区域滑动(左右)
  late ScrollController _bodyHController;

  ///body区域滑动(上下)
  late ScrollController _bodyVController;

  ///底部左右滑动
  late ScrollController _bottomController;

  late SsqBattleController controller;

  @override
  Widget build(BuildContext context) {
    return BattleRequestWidget<SsqForecastInfo, SsqBattleController>(
      title: '双色球专家PK',
      init: controller,
      rankRoute: AppRoutes.ssqBattleRank,
      builder: (controller) {
        double top = MediaQuery.of(context).padding.top;
        double height = MediaQuery.of(context).size.height;
        double blockHeight =
            height - top - 44.h - headerHeight - cellHeight - 24.h;
        int rows = blockHeight ~/ cellHeight;
        return _buildBattleView(controller, rows);
      },
    );
  }

  Widget _buildBattleView(SsqBattleController controller, int rows) {
    return BattleScrollWidget(
      leftWidth: cellHeaderWidth,
      headerHeight: headerHeight,
      battleSize: () => controller.battleSize(),
      battleDing: () => controller.ding,
      topController: _topController,
      dingController: _dingController,
      leftController: _leftController,
      bodyHController: _bodyHController,
      bodyVController: _bodyVController,
      bottomController: _bottomController,
      child: SizedBox(
        width: Get.width,
        child: Column(
          children: [
            _buildBattleHeader(),
            _buildBattleDing(controller),
            _buildBattleContent(controller, rows),
            if (controller.battleSize() >= 6) _buildBattleBottom(controller)
          ],
        ),
      ),
    );
  }

  Widget _buildBattleHeader() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom:
              BorderSide(color: Colors.grey.withValues(alpha: 0.2), width: 0.4),
        ),
      ),
      child: Row(
        children: [
          _buildTopLeftHeader(),
          SizedBox(
            width: Get.width - cellHeaderWidth,
            child: _buildTopHeader(),
          ),
        ],
      ),
    );
  }

  Widget _buildTopLeftHeader() {
    return Container(
      width: cellHeaderWidth,
      height: headerHeight,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right:
              BorderSide(color: Colors.grey.withValues(alpha: 0.2), width: 0.4),
        ),
      ),
      child: Text(
        '注: 超过6条统计',
        style: TextStyle(
          color: Colors.black38,
          fontSize: 12.sp,
        ),
      ),
    );
  }

  Widget _buildTopHeader() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: _topController,
      child: Row(
        children: [
          _headerCell('红球杀三', cellWidth100),
          _headerCell('红球杀六', cellWidth160),
          _headerCell('红球25码', cellWidth240),
          _headerCell('红球20码', cellWidth220),
          _headerCell('红球12码', cellWidth160),
          _headerCell('红球三胆', cellWidth100),
          _headerCell('红球双胆', cellWidth80),
          _headerCell('红球独胆', cellWidth80),
          _headerCell('蓝球杀码', cellWidth140),
          _headerCell('蓝球五码', cellWidth140),
          _headerCell('蓝球三码', cellWidth100),
        ],
      ),
    );
  }

  Widget _headerCell(String title, double width) {
    return Container(
      width: width,
      height: headerHeight,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right:
              BorderSide(color: Colors.grey.withValues(alpha: 0.2), width: 0.4),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildBattleDing(SsqBattleController controller) {
    if (controller.ding == null) {
      return const SizedBox.shrink();
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom:
              BorderSide(color: Colors.grey.withValues(alpha: 0.2), width: 0.4),
        ),
      ),
      child: Row(
        children: [
          _buildDingMaster(controller.ding!),
          SizedBox(
            width: Get.width - cellHeaderWidth,
            child: _buildDingContent(controller.ding!.forecast),
          ),
        ],
      ),
    );
  }

  Widget _buildDingMaster(MasterBattle<SsqForecastInfo> battle) {
    return Container(
      width: cellHeaderWidth,
      height: cellHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right:
              BorderSide(color: Colors.grey.withValues(alpha: 0.2), width: 0.4),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Get.toNamed('/ssq/forecast/${battle.master.masterId}');
        },
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 2.w),
              child: CachedAvatar(
                width: 22.w,
                height: 24.w,
                url: battle.master.avatar,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Tools.limitText(battle.master.name, 5),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '第${battle.period}期',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.brown,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDingContent(SsqForecastInfo forecast) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: _dingController,
      child: SizedBox(
        height: cellHeight,
        width: contentWidth,
        child: Row(
          children: [
            _contentRowCell(forecast.redKill3, cellWidth100,
                bottomBorder: false, color: const Color(0xFFFAFAFA)),
            _contentRowCell(forecast.redKill6, cellWidth160,
                bottomBorder: false, color: const Color(0xFFFAFAFA)),
            _contentRowCell(forecast.red25, cellWidth240,
                bottomBorder: false, color: const Color(0xFFFAFAFA)),
            _contentRowCell(forecast.red20, cellWidth220,
                bottomBorder: false, color: const Color(0xFFFAFAFA)),
            _contentRowCell(forecast.red12, cellWidth160,
                bottomBorder: false, color: const Color(0xFFFAFAFA)),
            _contentRowCell(forecast.red3, cellWidth100,
                bottomBorder: false, color: const Color(0xFFFAFAFA)),
            _contentRowCell(forecast.red2, cellWidth80,
                bottomBorder: false, color: const Color(0xFFFAFAFA)),
            _contentRowCell(forecast.red1, cellWidth80,
                bottomBorder: false, color: const Color(0xFFFAFAFA)),
            _contentRowCell(forecast.blueKill, cellWidth140,
                bottomBorder: false, color: const Color(0xFFFAFAFA)),
            _contentRowCell(forecast.blue5, cellWidth140,
                bottomBorder: false, color: const Color(0xFFFAFAFA)),
            _contentRowCell(forecast.blue3, cellWidth100,
                bottomBorder: false, color: const Color(0xFFFAFAFA)),
          ],
        ),
      ),
    );
  }

  Widget _buildBattleContent(SsqBattleController controller, int rows) {
    return SizedBox(
      height: cellHeight * controller.contentSize(rows),
      child: Row(
        children: [
          _buildLeftContent(controller),
          SizedBox(
            width: Get.width - cellHeaderWidth,
            child: _buildBodyContent(controller),
          )
        ],
      ),
    );
  }

  Widget _buildLeftContent(SsqBattleController controller) {
    return SingleChildScrollView(
      controller: _leftController,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: controller.battles.map((e) => _buildMaster(e)).toList(),
      ),
    );
  }

  Widget _buildBodyContent(SsqBattleController controller) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: _bodyHController,
      child: SizedBox(
        height: controller.battleSize() * cellHeight,
        width: contentWidth,
        child: ListView.builder(
          itemCount: controller.battles.length,
          padding: EdgeInsets.zero,
          controller: _bodyVController,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            SsqForecastInfo forecast = controller.battles[index].forecast;
            Color color =
                index % 2 == 1 ? const Color(0xFFFAFAFA) : Colors.white;
            return _bodyContentRow(forecast, color);
          },
        ),
      ),
    );
  }

  Widget _bodyContentRow(SsqForecastInfo forecast, Color color) {
    return SizedBox(
      height: cellHeight,
      width: Get.width - cellHeaderWidth,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _contentRowCell(forecast.redKill3, cellWidth100, color: color),
            _contentRowCell(forecast.redKill6, cellWidth160, color: color),
            _contentRowCell(forecast.red25, cellWidth240, color: color),
            _contentRowCell(forecast.red20, cellWidth220, color: color),
            _contentRowCell(forecast.red12, cellWidth160, color: color),
            _contentRowCell(forecast.red3, cellWidth100, color: color),
            _contentRowCell(forecast.red2, cellWidth80, color: color),
            _contentRowCell(forecast.red1, cellWidth80, color: color),
            _contentRowCell(forecast.blueKill, cellWidth140, color: color),
            _contentRowCell(forecast.blue5, cellWidth140, color: color),
            _contentRowCell(forecast.blue3, cellWidth100, color: color),
          ],
        ),
      ),
    );
  }

  Widget _contentRowCell(ForecastValue value, double width,
      {bool bottomBorder = true, Color color = Colors.white}) {
    return Container(
      width: width,
      height: cellHeight,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 5.w),
      decoration: BoxDecoration(
        color: color,
        border: Border(
          right:
              BorderSide(color: Colors.grey.withValues(alpha: 0.2), width: 0.4),
          bottom: bottomBorder
              ? BorderSide(
                  color: Colors.grey.withValues(alpha: 0.2), width: 0.4)
              : BorderSide.none,
        ),
      ),
      child: Wrap(
        children: value.pkViews(),
      ),
    );
  }

  Widget _buildMaster(MasterBattle<SsqForecastInfo> battle) {
    return Container(
      width: cellHeaderWidth,
      height: cellHeight,
      decoration: BoxDecoration(
        border: Border(
          right:
              BorderSide(color: Colors.grey.withValues(alpha: 0.2), width: 0.4),
          bottom:
              BorderSide(color: Colors.grey.withValues(alpha: 0.2), width: 0.4),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  controller.dingTop(battle.master.masterId, () {
                    Future.delayed(const Duration(milliseconds: 50), () {
                      _dingController.animateTo(
                        _topController.offset,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.linear,
                      );
                    });
                  });
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  height: 18.w,
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(4.w),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        const IconData(0xe659, fontFamily: 'iconfont'),
                        size: 13.sp,
                        color: Colors.black87,
                      ),
                      Text(
                        '钉在上侧',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.removeBattle(battle.id);
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  height: 18.w,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Icon(
                    const IconData(0xe657, fontFamily: 'iconfont'),
                    size: 13.sp,
                    color: Colors.black12,
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed('/ssq/forecast/${battle.master.masterId}');
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 6.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 2.w),
                    child: CachedAvatar(
                      width: 22.w,
                      height: 24.w,
                      url: battle.master.avatar,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Tools.limitText(battle.master.name, 5),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '第${battle.period}期',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.brown,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBattleBottom(SsqBattleController controller) {
    return Row(
      children: [
        _buildLeftBottom(controller),
        SizedBox(
          width: Get.width - cellHeaderWidth,
          child: _buildBottomContent(controller),
        )
      ],
    );
  }

  Widget _buildLeftBottom(SsqBattleController controller) {
    return Container(
      width: cellHeaderWidth,
      height: cellHeight,
      decoration: BoxDecoration(
        border: Border(
          top:
              BorderSide(color: Colors.grey.withValues(alpha: 0.2), width: 0.4),
          right:
              BorderSide(color: Colors.grey.withValues(alpha: 0.2), width: 0.4),
          bottom:
              BorderSide(color: Colors.grey.withValues(alpha: 0.2), width: 0.4),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                controller.show = 1;
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                alignment: Alignment.center,
                color: controller.show == 1
                    ? const Color(0xFFF8F8F8)
                    : Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '由高到低',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: controller.show == 1
                            ? Colors.black54
                            : Colors.black87,
                      ),
                    ),
                    Icon(
                      const IconData(0xe686, fontFamily: 'iconfont'),
                      size: 16.sp,
                      color: controller.show == 1
                          ? Colors.black54
                          : Colors.black87,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                controller.show = 2;
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                alignment: Alignment.center,
                color: controller.show == 2
                    ? const Color(0xFFF8F8F8)
                    : Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '由低到高',
                      style: TextStyle(
                        color: controller.show == 2
                            ? Colors.black54
                            : Colors.black87,
                        fontSize: 13.sp,
                      ),
                    ),
                    Icon(
                      const IconData(0xe687, fontFamily: 'iconfont'),
                      size: 16.sp,
                      color: controller.show == 2
                          ? Colors.black54
                          : Colors.black87,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomContent(SsqBattleController controller) {
    Future.delayed(const Duration(milliseconds: 50),
        () => _bottomController.jumpTo(_topController.offset));
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: _bottomController,
      child: SizedBox(
        height: cellHeight,
        width: contentWidth,
        child: Row(
          children: [
            _bottomContentCell(
                width: cellWidth100, views: controller.views((e) => e.rk3)),
            _bottomContentCell(
                width: cellWidth160, views: controller.views((e) => e.rk6)),
            _bottomContentCell(
                width: cellWidth240, views: controller.views((e) => e.red25)),
            _bottomContentCell(
                width: cellWidth220, views: controller.views((e) => e.red20)),
            _bottomContentCell(
                width: cellWidth160, views: controller.views((e) => e.red12)),
            _bottomContentCell(
                width: cellWidth100, views: controller.views((e) => e.red3)),
            _bottomContentCell(
                width: cellWidth80, views: controller.views((e) => e.red2)),
            _bottomContentCell(
                width: cellWidth80, views: controller.views((e) => e.red1)),
            _bottomContentCell(
                width: cellWidth140, views: controller.views((e) => e.bk)),
            _bottomContentCell(
                width: cellWidth140, views: controller.views((e) => e.blue5)),
            _bottomContentCell(
                width: cellWidth100, views: controller.views((e) => e.blue3)),
          ],
        ),
      ),
    );
  }

  Widget _bottomContentCell({List<Widget>? views, required double width}) {
    return Container(
      width: width,
      height: cellHeight,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          top:
              BorderSide(color: Colors.grey.withValues(alpha: 0.2), width: 0.4),
          right:
              BorderSide(color: Colors.grey.withValues(alpha: 0.2), width: 0.4),
          bottom:
              BorderSide(color: Colors.grey.withValues(alpha: 0.2), width: 0.4),
        ),
      ),
      child: views != null
          ? Wrap(
              children: views,
            )
          : null,
    );
  }

  @override
  void initState() {
    _leftController = ScrollController();
    _topController = ScrollController();
    _dingController = ScrollController();
    _bodyHController = ScrollController();
    _bodyVController = ScrollController();
    _bottomController = ScrollController();
    super.initState();
    controller = SsqBattleController();
    controller.loadBattles();
  }

  @override
  void dispose() {
    _leftController.dispose();
    _topController.dispose();
    _dingController.dispose();
    _bodyHController.dispose();
    _bodyVController.dispose();
    _bottomController.dispose();
    super.dispose();
  }
}
