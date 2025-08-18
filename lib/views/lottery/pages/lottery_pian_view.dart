import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_pian_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_omit.dart';
import 'package:prize_lottery_app/views/lottery/model/slide_direction.dart';
import 'package:prize_lottery_app/views/lottery/pages/fc3d/fc3d_number_trend_view.dart';
import 'package:prize_lottery_app/views/lottery/utils/trend_constants.dart';
import 'package:prize_lottery_app/views/lottery/widgets/draw_line_painter.dart';
import 'package:prize_lottery_app/views/lottery/widgets/page_query_widget.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class LotteryPianView extends StatefulWidget {
  const LotteryPianView({super.key});

  @override
  State<LotteryPianView> createState() => _LotteryPianViewState();
}

class _LotteryPianViewState extends State<LotteryPianView>
    with TickerProviderStateMixin {
  ///
  ///
  late TabController tabController;

  ///tab选项卡
  List<Widget> tabs = [
    Container(
      height: trendTabBarHeight,
      alignment: Alignment.center,
      child: const Text('百位偏态'),
    ),
    Container(
      height: trendTabBarHeight,
      alignment: Alignment.center,
      child: const Text('十位偏态'),
    ),
    Container(
      height: trendTabBarHeight,
      alignment: Alignment.center,
      child: const Text('个位偏态'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height;
    double blockHeight = height - top - 44.h - 34.h - 32.h;
    int rows = blockHeight ~/ trendCellSize;
    return LayoutContainer(
      title: '偏态走势',
      content: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTabBar(),
            _buildTabView(rows),
            GetBuilder<LotteryPianController>(builder: (controller) {
              return PageQueryWidget(
                page: controller.size,
                pages: pianList,
                toMaster: '${controller.type}/mul_rank',
                onTap: (size) {
                  controller.size = size;
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTabView(int rows) {
    return SizedBox(
      height: rows * trendCellSize,
      child: RequestWidget<LotteryPianController>(
        builder: (controller) {
          return TabBarView(
            controller: tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              PianTrendView(
                rows: rows,
                data: controller.cb1,
                census: controller.census.cb1,
              ),
              PianTrendView(
                rows: rows,
                data: controller.cb2,
                census: controller.census.cb2,
              ),
              PianTrendView(
                rows: rows,
                data: controller.cb3,
                census: controller.census.cb3,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: trendTabBarHeight,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 10.w),
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        dividerHeight: 0,
        tabAlignment: TabAlignment.start,
        controller: tabController,
        labelPadding: EdgeInsets.only(left: 5.w, right: 5.w),
        labelColor: const Color(0xFFEF3454),
        unselectedLabelColor: Colors.black87,
        unselectedLabelStyle:
            TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
        labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        indicator: const BoxDecoration(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}

const Map<int, String> nameMap = {
  0: '基础遗漏',
  1: '偏态遗漏一',
  2: '偏态遗漏二',
  3: '偏态遗漏三',
  4: '偏态遗漏四',
  5: '偏态遗漏五',
  6: '偏态遗漏六',
  7: '偏态遗漏七',
  8: '偏态遗漏八',
  9: '偏态遗漏九',
  10: '偏态遗漏十',
};

typedef OmitExtractor = List<OmitValue> Function(PianCensusItem);

class PianTrendView extends StatefulWidget {
  ///
  ///
  const PianTrendView(
      {super.key,
      required this.rows,
      required this.data,
      required this.census});

  final int rows;

  final List<PianValue> data;
  final Map<int, PianCensusItem> census;

  @override
  State<PianTrendView> createState() => _PianTrendViewState();
}

class _PianTrendViewState extends State<PianTrendView>
    with AutomaticKeepAliveClientMixin {
  ///顶部左右滑动
  late ScrollController _topController;

  ///左侧上下滑动
  late ScrollController _leftController;

  ///body区域滑动(左右)
  late ScrollController _bodyHController;

  ///body区域滑动(上下)
  late ScrollController _bodyVController;

  ///底部左右滑动
  late ScrollController _bottomController;

  ///滑动方向
  late SlideDirection _direction;

  ///上一次结束时滑动的位置
  late Offset last;

  ///顶部高度
  double cell = trendCellSize;

  ///左侧宽度
  double left = trendLeftWidth;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ///屏幕尺寸
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onPanStart: handleStart,
      onPanEnd: handleEnd,
      onPanUpdate: handleUpdate,
      child: SizedBox(
        width: width,
        height: cell * widget.rows,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Row(
                children: [
                  Container(
                    width: left,
                    height: cell * 2,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(color: greyBorder, width: 0.4),
                        top: BorderSide(color: greyBorder, width: 0.4),
                        bottom: BorderSide(color: greyBorder, width: 0.4),
                      ),
                    ),
                    child: Text(
                      '期次',
                      style: TextStyle(
                        color: blackFont,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width - left,
                    child: _buildHeader(),
                  )
                ],
              ),
            ),
            Positioned(
              left: 0,
              top: cell * 2,
              child: SizedBox(
                height: cell * (widget.rows - 6),
                child: Row(
                  children: [
                    _buildLeftContent(),
                    SizedBox(
                      width: width - left,
                      child: _buildBodyContent(),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: cell * (widget.rows - 4),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: Colors.grey.withValues(alpha: 0.2), width: 0.4),
                    bottom: BorderSide(
                        color: Colors.grey.withValues(alpha: 0.2), width: 0.4),
                  ),
                ),
                child: Row(
                  children: [
                    _bottomLeftHeader(),
                    _bottomBodyContent(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: _topController,
      child: SizedBox(
        height: cell * 2,
        width: cell * 100 + trendLeftWidth,
        child: Row(
          children: [
            _buildLottoHeader(),
            ...widget.census.keys.map((e) => _buildGroupHeader(nameMap[e]!)),
          ],
        ),
      ),
    );
  }

  Widget _buildLottoHeader() {
    return Container(
      width: trendLeftWidth,
      height: cell * 2,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.05),
        border: Border(
          right: BorderSide(color: greyBorder, width: 1.0),
          top: BorderSide(color: greyBorder, width: 0.4),
          bottom: BorderSide(color: greyBorder, width: 0.4),
        ),
      ),
      child: Text(
        '开奖号',
        style: TextStyle(
          color: blackFont,
          fontSize: 13.sp,
        ),
      ),
    );
  }

  Widget _buildGroupHeader(String title) {
    return SizedBox(
      width: cell * 10,
      height: cell * 2,
      child: Column(
        children: [
          Container(
            width: cell * 10,
            height: cell,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(color: greyBorder, width: 1),
                top: BorderSide(color: greyBorder, width: 0.4),
                bottom: BorderSide(color: greyBorder, width: 1.0),
              ),
            ),
            child: Text(
              title,
              style: TextStyle(color: blackFont, fontSize: 13.sp),
            ),
          ),
          Row(
            children: List.generate(
              10,
              (index) => Container(
                width: cell,
                height: cell,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.05),
                  border: Border(
                    bottom: BorderSide(color: greyBorder, width: 0.4),
                    right: BorderSide(
                      color: greyBorder,
                      width: index < 9 ? 0.4 : 1,
                    ),
                  ),
                ),
                child: Text(
                  '$index',
                  style: TextStyle(color: blackFont, fontSize: 12.sp),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLeftContent() {
    return SingleChildScrollView(
      controller: _leftController,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: _leftContentCells(),
      ),
    );
  }

  Widget _buildBodyContent() {
    List<PianValue> omits = widget.data;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: _bodyHController,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _bodyVController,
        child: CustomPaint(
          size: Size(cell * 100 + trendLeftWidth, cell * omits.length),
          foregroundPainter: PianDrawLinePainter(omits),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildBodyRows(),
          ),
        ),
      ),
    );
  }

  List<Widget> _leftContentCells() {
    List<Widget> views = [];
    List<PianValue> omits = widget.data;
    for (int i = 0; i < omits.length; i++) {
      PianValue omit = omits[i];
      views.add(
        Container(
          width: left,
          height: cell,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color:
                i % 2 == 0 ? Colors.white : Colors.grey.withValues(alpha: 0.05),
            border: Border(
              right: BorderSide(
                color: greyBorder,
                width: 0.4,
              ),
              bottom: BorderSide(
                color: greyBorder,
                width: 0.4,
              ),
            ),
          ),
          child: Text(
            '${omit.period.substring(4)} 期',
            style: TextStyle(color: blackFont, fontSize: 13.sp),
          ),
        ),
      );
    }
    return views;
  }

  List<Widget> _buildBodyRows() {
    List<PianValue> omits = widget.data;
    List<Widget> views = [];
    for (int index = 0; index < omits.length; index++) {
      views.add(
        Container(
          height: cell,
          color: index % 2 == 0
              ? Colors.white
              : Colors.grey.withValues(alpha: 0.05),
          child: _buildBodyRow(omits[index]),
        ),
      );
    }
    return views;
  }

  Widget _buildBodyRow(PianValue omit) {
    List<Widget> views = [
      _buildLottoCell(omit),
    ];
    Iterable<int> keys = omit.omits.keys;
    for (var i in keys) {
      views.addAll(_buildGroupCells(omit.omits[i]!.values));
    }
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(children: views),
    );
  }

  Widget _buildLottoCell(PianValue value) {
    return Container(
      height: cell,
      width: trendLeftWidth,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: greyBorder, width: 1.0),
          bottom: BorderSide(color: greyBorder, width: 0.4),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: value
            .balls()
            .map(
              (e) => Padding(
                padding: EdgeInsets.only(right: 2.w),
                child: Text(
                  e,
                  style: TextStyle(
                    color: blackFont,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  List<Widget> _buildGroupCells(List<OmitValue> values) {
    return values
        .map(
          (e) => Container(
            width: cell,
            height: cell,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: greyBorder,
                  width: e.key == '9' ? 1 : 0.4,
                ),
                bottom: BorderSide(
                  color: greyBorder,
                  width: 0.4,
                ),
              ),
            ),
            child: e.value == 0
                ? _cellBall(e)
                : Text(
                    '${e.value}',
                    style: TextStyle(
                      color: e.value == 0 ? redFont : blackFont,
                      fontSize: 12.sp,
                    ),
                  ),
          ),
        )
        .toList();
  }

  bool _isRepeat(String extra) {
    if (extra == '' || extra == '0' || extra == '1') {
      return false;
    }
    return true;
  }

  Widget _cellBall(OmitValue value) {
    if (_isRepeat(value.extra)) {
      return Stack(
        children: [
          Container(
            width: cell,
            height: cell,
            alignment: Alignment.center,
            child: Container(
              width: cellRadius * 2,
              height: cellRadius * 2,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: blueFont,
                borderRadius: BorderRadius.circular(cell / 2),
              ),
              child: Text(
                value.key,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
          Positioned(
            top: 2.h,
            right: 2.h,
            child: Container(
              height: 9.w,
              width: 9.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.pinkAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6.w),
                  topRight: Radius.circular(6.w),
                  bottomRight: Radius.circular(6.w),
                ),
              ),
              child: Text(
                value.extra,
                style: TextStyle(
                  fontSize: 8.sp,
                  height: .85,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
    }
    return Container(
      width: cell - 8.w,
      height: cell - 8.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: redFont,
        borderRadius: BorderRadius.circular(cell / 2),
      ),
      child: Text(
        value.key,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
        ),
      ),
    );
  }

  Widget _bottomLeftHeader() {
    return Column(
      children: bottomHeaders
          .map((e) => Container(
                width: left,
                height: cell,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    right: BorderSide(color: greyBorder, width: 0.4),
                    bottom: BorderSide(color: greyBorder, width: 0.4),
                  ),
                ),
                child: Text(
                  e,
                  style: TextStyle(
                    color: blackFont,
                    fontSize: 12.sp,
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _bottomBodyContent() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - left,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        controller: _bottomController,
        child: SizedBox(
          height: cell * 4,
          width: cell * 100 + trendLeftWidth,
          child: Column(
            children: [
              _buildCensusRow(widget.census, (e) => e.max),
              _buildCensusRow(widget.census, (e) => e.avg),
              _buildCensusRow(widget.census, (e) => e.freq),
              _buildCensusRow(widget.census, (e) => e.series),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCensusRow(
    Map<int, PianCensusItem> census,
    OmitExtractor extractor,
  ) {
    List<Widget> views = [
      Container(
        width: trendLeftWidth,
        height: cell,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            right: BorderSide(color: greyBorder, width: 1.0),
            bottom: BorderSide(color: greyBorder, width: 0.4),
          ),
        ),
      ),
    ];
    Iterable<int> keys = census.keys;
    for (var key in keys) {
      PianCensusItem item = census[key]!;
      List<OmitValue> values = extractor(item);
      views.addAll(
        values.map(
          (e) => _censusCell(
            value: e.value,
            color: greyBorder,
            width: e.key == '9' ? 1.0 : 0.4,
          ),
        ),
      );
    }
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(children: views),
    );
  }

  Widget _censusCell({int? value, required Color color, double width = 0.4}) {
    return SizedBox(
      width: cell,
      height: cell,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            right: BorderSide(
              color: color,
              width: width,
            ),
            bottom: BorderSide(
              color: greyBorder,
              width: 0.4,
            ),
          ),
        ),
        child: Text(
          '${value ?? ''}',
          style: TextStyle(
            color: blackFont,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  void handleStart(DragStartDetails details) {
    last = details.localPosition;
  }

  void handleEnd(DragEndDetails details) {}

  void handleUpdate(DragUpdateDetails details) {
    double dx = details.localPosition.dx;
    double dy = details.localPosition.dy;
    if (dx < left) {
      _direction = dy - last.dy > 0 ? SlideDirection.down : SlideDirection.up;
    } else if (dy < cell * 2) {
      _direction =
          dx - last.dx > 0 ? SlideDirection.right : SlideDirection.left;
    } else {
      _direction = SlideDirection.all;
    }

    double distanceX = (dx - last.dx).abs();
    double distanceY = (dy - last.dy).abs();
    switch (_direction) {
      case SlideDirection.left:
        if (_topController.offset < _topController.position.maxScrollExtent) {
          _bodyHController.jumpTo(_topController.offset + distanceX);
          _bottomController.jumpTo(_topController.offset + distanceX);
          _topController.jumpTo(_topController.offset + distanceX);
        }
        break;
      case SlideDirection.right:
        if (_topController.offset > _topController.position.minScrollExtent) {
          _bodyHController.jumpTo(_topController.offset - distanceX);
          _bottomController.jumpTo(_topController.offset - distanceX);
          _topController.jumpTo(_topController.offset - distanceX);
        }
        break;
      case SlideDirection.up:
        if (_leftController.offset < _leftController.position.maxScrollExtent) {
          _bodyVController.jumpTo(_leftController.offset + distanceY);
          _leftController.jumpTo(_leftController.offset + distanceY);
        }
        break;
      case SlideDirection.down:
        if (_leftController.offset > _leftController.position.minScrollExtent) {
          _bodyVController.jumpTo(_leftController.offset - distanceY);
          _leftController.jumpTo(_leftController.offset - distanceY);
        }
        break;
      case SlideDirection.all:
        double ddx = details.localPosition.dx - last.dx;
        double ddy = details.localPosition.dy - last.dy;

        ///向右移动
        if (ddx > 0) {
          if (_bodyHController.offset >
                  _bodyHController.position.minScrollExtent &&
              _topController.offset > _topController.position.minScrollExtent) {
            _bottomController.jumpTo(_bodyHController.offset - ddx);
            _topController.jumpTo(_bodyHController.offset - ddx);
            _bodyHController.jumpTo(_bodyHController.offset - ddx);
          }
        } else {
          if (_bodyHController.offset <
                  _bodyHController.position.maxScrollExtent &&
              _topController.offset < _topController.position.maxScrollExtent) {
            _bottomController.jumpTo(_bodyHController.offset - ddx);
            _topController.jumpTo(_bodyHController.offset - ddx);
            _bodyHController.jumpTo(_bodyHController.offset - ddx);
          }
        }

        ///向下移动
        if (ddy > 0) {
          if (_bodyVController.offset >
                  _bodyVController.position.minScrollExtent &&
              _leftController.offset >
                  _leftController.position.minScrollExtent) {
            _leftController.jumpTo(_bodyVController.offset - ddy);
            _bodyVController.jumpTo(_bodyVController.offset - ddy);
          }
        } else {
          if (_bodyVController.offset <
                  _bodyVController.position.maxScrollExtent &&
              _leftController.offset <
                  _leftController.position.maxScrollExtent) {
            _leftController.jumpTo(_bodyVController.offset - ddy);
            _bodyVController.jumpTo(_bodyVController.offset - ddy);
          }
        }
        break;
    }
    last = details.localPosition;
  }

  @override
  void initState() {
    super.initState();
    _leftController = ScrollController();
    _topController = ScrollController();
    _bodyHController = ScrollController();
    _bodyVController = ScrollController();
    _bottomController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _leftController.dispose();
    _topController.dispose();
    _bodyHController.dispose();
    _bodyVController.dispose();
    _bottomController.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
