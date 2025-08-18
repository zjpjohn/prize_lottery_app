import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/model/forecast_value.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/battle/controller/pl3_battle_controller.dart';
import 'package:prize_lottery_app/views/battle/model/master_battle.dart';
import 'package:prize_lottery_app/views/battle/widgets/battle_request_widget.dart';
import 'package:prize_lottery_app/views/battle/widgets/battle_scroll_widget.dart';
import 'package:prize_lottery_app/views/forecast/model/pl3_forecast_info.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';

class Pl3BattleView extends StatefulWidget {
  ///
  ///
  const Pl3BattleView({super.key});

  @override
  Pl3BattleViewState createState() => Pl3BattleViewState();
}

final double cellWidth = 120.h;
final double cellHeaderWidth = 104.h;
final double headerHeight = 34.h;
final double cellHeight = 58.h;
final double dingHeight = 58.h;
final double bottomHeight = 58.h;

class Pl3BattleViewState extends State<Pl3BattleView> {
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

  late Pl3BattleController controller;

  @override
  Widget build(BuildContext context) {
    return BattleRequestWidget<Pl3ForecastInfo, Pl3BattleController>(
      title: '排列三专家PK',
      init: controller,
      rankRoute: AppRoutes.pl3BattleRank,
      builder: (controller) {
        double top = MediaQuery.of(context).padding.top;
        double height = MediaQuery.of(context).size.height;
        double blockHeight =
            height - top - 44.h - headerHeight - bottomHeight - 24.h;
        int rows = blockHeight ~/ cellHeight;
        return _buildBattleView(controller, rows);
      },
    );
  }

  Widget _buildBattleView(Pl3BattleController controller, int rows) {
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
            if (controller.battleSize() >= 6) _buildBattleBottom(controller),
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
          _buildTopLeftHeader(controller),
          SizedBox(
            width: Get.width - cellHeaderWidth,
            child: _buildTopHeader(controller),
          ),
        ],
      ),
    );
  }

  Widget _buildTopLeftHeader(Pl3BattleController controller) {
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

  Widget _buildTopHeader(Pl3BattleController controller) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: _topController,
      child: Row(
        children: [
          _headerCell('杀一码', controller),
          _headerCell('杀二码', controller),
          _headerCell('组合七码', controller),
          _headerCell('组合六码', controller),
          _headerCell('组合五码', controller),
          _headerCell('三胆', controller),
          _headerCell('双胆', controller),
          _headerCell('独胆', controller),
        ],
      ),
    );
  }

  Widget _headerCell(String title, Pl3BattleController controller) {
    return Container(
      width: cellWidth,
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

  Widget _buildBattleDing(Pl3BattleController controller) {
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

  Widget _buildDingMaster(MasterBattle<Pl3ForecastInfo> battle) {
    return Container(
      width: cellHeaderWidth,
      height: dingHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right:
              BorderSide(color: Colors.grey.withValues(alpha: 0.2), width: 0.4),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Get.toNamed('/pl3/forecast/${battle.master.masterId}');
        },
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 2.w),
              child: CachedAvatar(
                width: 22.w,
                height: 22.w,
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

  Widget _buildDingContent(Pl3ForecastInfo forecast) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: _dingController,
      child: SizedBox(
        height: dingHeight,
        width: cellWidth * 8,
        child: Row(
          children: [
            _contentRowCell(forecast.kill1,
                bottomBorder: false, color: const Color(0xFFFAFAFA)),
            _contentRowCell(forecast.kill2,
                bottomBorder: false, color: const Color(0xFFFAFAFA)),
            _contentRowCell(forecast.com7,
                bottomBorder: false, color: const Color(0xFFFAFAFA)),
            _contentRowCell(forecast.com6,
                bottomBorder: false, color: const Color(0xFFFAFAFA)),
            _contentRowCell(forecast.com5,
                bottomBorder: false, color: const Color(0xFFFAFAFA)),
            _contentRowCell(forecast.dan3,
                bottomBorder: false, color: const Color(0xFFFAFAFA)),
            _contentRowCell(forecast.dan2,
                bottomBorder: false, color: const Color(0xFFFAFAFA)),
            _contentRowCell(forecast.dan1,
                bottomBorder: false, color: const Color(0xFFFAFAFA)),
          ],
        ),
      ),
    );
  }

  Widget _buildBattleContent(Pl3BattleController controller, int rows) {
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

  Widget _buildLeftContent(Pl3BattleController controller) {
    return SingleChildScrollView(
      controller: _leftController,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: controller.battles.map((e) => _buildMaster(e)).toList(),
      ),
    );
  }

  Widget _buildMaster(MasterBattle<Pl3ForecastInfo> battle) {
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
              Get.toNamed('/pl3/forecast/${battle.master.masterId}');
            },
            child: Padding(
              padding: EdgeInsets.only(top: 4.w, bottom: 6.w),
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

  Widget _buildBodyContent(Pl3BattleController controller) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: _bodyHController,
      child: SizedBox(
        width: cellWidth * 8,
        height: controller.battleSize() * cellHeight,
        child: ListView.builder(
          itemCount: controller.battles.length,
          padding: EdgeInsets.zero,
          controller: _bodyVController,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            Pl3ForecastInfo forecast = controller.battles[index].forecast;
            Color color =
                index % 2 == 1 ? const Color(0xFFFAFAFA) : Colors.white;
            return _bodyContentRow(forecast, color);
          },
        ),
      ),
    );
  }

  Widget _bodyContentRow(Pl3ForecastInfo forecast, Color color) {
    return SizedBox(
      height: cellHeight,
      width: Get.width - cellWidth,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _contentRowCell(forecast.kill1, color: color),
            _contentRowCell(forecast.kill2, color: color),
            _contentRowCell(forecast.com7, color: color),
            _contentRowCell(forecast.com6, color: color),
            _contentRowCell(forecast.com5, color: color),
            _contentRowCell(forecast.dan3, color: color),
            _contentRowCell(forecast.dan2, color: color),
            _contentRowCell(forecast.dan1, color: color),
          ],
        ),
      ),
    );
  }

  Widget _buildBattleBottom(Pl3BattleController controller) {
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

  Widget _buildLeftBottom(Pl3BattleController controller) {
    return Container(
      width: cellHeaderWidth,
      height: bottomHeight,
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

  Widget _buildBottomContent(Pl3BattleController controller) {
    Future.delayed(const Duration(milliseconds: 50),
        () => _bottomController.jumpTo(_topController.offset));
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: _bottomController,
      child: SizedBox(
        height: bottomHeight,
        width: cellWidth * 8,
        child: Row(
          children: [
            _bottomContentCell(views: controller.views((e) => e.k1)),
            _bottomContentCell(views: controller.views((e) => e.k2)),
            _bottomContentCell(views: controller.views((e) => e.com7)),
            _bottomContentCell(views: controller.views((e) => e.com6)),
            _bottomContentCell(views: controller.views((e) => e.com5)),
            _bottomContentCell(views: controller.views((e) => e.d3)),
            _bottomContentCell(views: controller.views((e) => e.d2)),
            _bottomContentCell(views: controller.views((e) => e.d1)),
          ],
        ),
      ),
    );
  }

  Widget _bottomContentCell({List<Widget>? views}) {
    return Container(
      width: cellWidth,
      height: bottomHeight,
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

  Widget _contentRowCell(ForecastValue value,
      {bool bottomBorder = true, Color color = Colors.white}) {
    return Container(
      width: cellWidth,
      height: cellHeight,
      alignment: Alignment.center,
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

  @override
  void initState() {
    _leftController = ScrollController();
    _topController = ScrollController();
    _dingController = ScrollController();
    _bodyHController = ScrollController();
    _bodyVController = ScrollController();
    _bottomController = ScrollController();
    super.initState();
    controller = Pl3BattleController();
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
