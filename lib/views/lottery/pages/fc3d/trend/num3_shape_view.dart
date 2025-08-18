import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_trend_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_omit.dart';
import 'package:prize_lottery_app/views/lottery/model/n3_omit_census.dart';
import 'package:prize_lottery_app/views/lottery/model/slide_direction.dart';
import 'package:prize_lottery_app/views/lottery/pages/fc3d/fc3d_number_trend_view.dart';
import 'package:prize_lottery_app/views/lottery/utils/trend_constants.dart';
import 'package:prize_lottery_app/views/lottery/widgets/draw_line_painter.dart';
import 'package:prize_lottery_app/views/lottery/widgets/page_query_widget.dart';

class Num3ShapeView extends StatefulWidget {
  const Num3ShapeView({
    super.key,
    required this.rows,
    required this.type,
  });

  final int rows;
  final String type;

  @override
  State<Num3ShapeView> createState() => _Num3ShapeViewState();
}

class _Num3ShapeViewState extends State<Num3ShapeView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Get.put(LotteryTrendController(widget.type));
    return Column(
      children: [
        SizedBox(
          height: widget.rows * trendCellSize + 0.5.w,
          child: RequestWidget<LotteryTrendController>(
            builder: (controller) {
              return ShapeView(
                rows: widget.rows,
                lotteries: controller.lotteries,
                census: controller.census,
                omits: controller.omits,
              );
            },
          ),
        ),
        GetBuilder<LotteryTrendController>(
          builder: (controller) {
            return PageQueryWidget(
              page: controller.size,
              toMaster: '${widget.type}/mul_rank',
              onTap: (size) {
                controller.size = size;
              },
            );
          },
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ShapeView extends StatefulWidget {
  const ShapeView({
    super.key,
    required this.rows,
    required this.omits,
    required this.census,
    required this.lotteries,
  });

  final int rows;
  final List<TrendOmit> omits;
  final TrendCensus census;
  final List<LotteryInfo> lotteries;

  @override
  State<ShapeView> createState() => _ShapeViewState();
}

const List<String> formKey = ["全顺", "半顺", "杂六", "对子", "豹子"];
const List<String> ottKey = ["00", "01", "02", "012", "11", "12", "22"];
const List<String> modeKey = ["凸上", "凹下", "上升", "下降", "平行"];
const List<String> bsKey = ["全小", "两小", "两大", "全大"];
const List<String> oeKey = ["全奇", "两奇", "两偶", "全偶"];
const List<String> mcKey = ["05", "16", "27", "38", "49"];

class _ShapeViewState extends State<ShapeView> {
  ///
  Map<String, LotteryInfo> lotteries = {};

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
              top: 0,
              left: 0,
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
                  ),
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
                    _buildLeftContent(widget.omits),
                    SizedBox(
                      width: width - left,
                      child: _buildBodyContent(widget.omits),
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
                    Column(
                      children: _bottomLeftHeader(),
                    ),
                    _bottomBodyContent(widget.census),
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
        width: left + shapeCellWidth * 25,
        height: cell * 2,
        child: Row(
          children: _buildHeaderCells(),
        ),
      ),
    );
  }

  List<Widget> _buildHeaderCells() {
    return [
      _buildLottoHeader(),
      _buildOmitHeader('组选形态', formKey),
      _buildOmitHeader('012形态', ottKey),
      _buildOmitHeader('直选形态', modeKey),
      _buildOmitHeader('大小形态', bsKey),
      _buildOmitHeader('奇偶形态', oeKey),
    ];
  }

  Widget _buildLottoHeader() {
    return Container(
      width: left,
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

  Widget _buildOmitHeader(String title, List<String> keys) {
    List<Widget> views = [];
    for (int i = 0; i < keys.length; i++) {
      views.add(
        Container(
          width: shapeCellWidth,
          height: cell,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.05),
            border: Border(
              bottom: BorderSide(color: greyBorder, width: 0.4),
              right: BorderSide(
                color: greyBorder,
                width: i == keys.length - 1 ? 1.0 : 0.4,
              ),
            ),
          ),
          child: Text(
            keys[i],
            style: TextStyle(color: blackFont, fontSize: 12.sp),
          ),
        ),
      );
    }
    return SizedBox(
      width: shapeCellWidth * keys.length,
      height: cell * 2,
      child: Column(
        children: [
          Container(
            width: shapeCellWidth * keys.length,
            height: cell,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(color: greyBorder, width: 1.0),
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
            children: views,
          ),
        ],
      ),
    );
  }

  Widget _buildLeftContent(List<TrendOmit> omits) {
    return SingleChildScrollView(
      controller: _leftController,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: _leftContentCells(omits),
      ),
    );
  }

  List<Widget> _leftContentCells(List<TrendOmit> omits) {
    List<Widget> views = [];
    for (int i = 0; i < omits.length; i++) {
      TrendOmit omit = omits[i];
      views.add(
        GestureDetector(
          onTap: () {
            Get.toNamed(
                '/num3/follow/list/${omit.type.value}?period=${omit.period}');
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: left,
            height: cell,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: i % 2 == 0
                  ? Colors.white
                  : Colors.grey.withValues(alpha: 0.05),
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
        ),
      );
    }
    return views;
  }

  Widget _buildBodyContent(List<TrendOmit> omits) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: _bodyHController,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _bodyVController,
        child: SizedBox(
          width: shapeCellWidth * 25 + left,
          height: cell * omits.length,
          child: CustomPaint(
            size: Size(shapeCellWidth * 25 + left, cell * omits.length),
            foregroundPainter: RecDrawLinePainter(buildTrendPositions(omits)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _bodyContentRows(omits),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _bodyContentRows(List<TrendOmit> omits) {
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

  Widget _buildBodyRow(TrendOmit omit) {
    List<Widget> views = [
      _buildLottoCell(lotteries[omit.period]),
      ..._buildTrendOmits(omit.formOmit.values),
      ..._buildTrendOmits(omit.ottOmit.values),
      ..._buildTrendOmits(omit.modeOmit.values),
      ..._buildTrendOmits(omit.bsOmit.values),
      ..._buildTrendOmits(omit.oeOmit.values),
    ];
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: views,
      ),
    );
  }

  Widget _buildLottoCell(LotteryInfo? census) {
    return Container(
      height: cell,
      width: left,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: greyBorder, width: 1.0),
          bottom: BorderSide(color: greyBorder, width: 0.4),
        ),
      ),
      child: census == null
          ? null
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: census
                  .redBalls()
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

  List<Widget> _buildTrendOmits(List<OmitValue> values) {
    List<Widget> views = [];
    for (int i = 0; i < values.length; i++) {
      OmitValue e = values[i];
      views.add(Container(
        width: shapeCellWidth,
        height: cell,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: e.value == 0 ? redFont : Colors.transparent,
          border: Border(
            right: BorderSide(
              color: greyBorder,
              width: i == values.length - 1 ? 1 : 0.4,
            ),
            bottom: BorderSide(
              color: greyBorder,
              width: 0.4,
            ),
          ),
        ),
        child: Text(
          e.value == 0 ? e.key : '${e.value}',
          style: TextStyle(
            fontSize: 12.sp,
            color: e.value == 0 ? Colors.white : blackFont,
          ),
        ),
      ));
    }
    return views;
  }

  List<Widget> _bottomLeftHeader() {
    return bottomHeaders
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
        .toList();
  }

  Widget _bottomBodyContent(TrendCensus census) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - left,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        controller: _bottomController,
        child: SizedBox(
          height: cell * 4,
          width: shapeCellWidth * 25 + left,
          child: Column(
            children: [
              _buildCensusRow(
                form: census.formMax,
                ott: census.ottMax,
                mode: census.modeMax,
                bs: census.bsMax,
                oe: census.oeMax,
              ),
              _buildCensusRow(
                form: census.formAvg,
                ott: census.ottAvg,
                mode: census.modeAvg,
                bs: census.bsAvg,
                oe: census.oeAvg,
              ),
              _buildCensusRow(
                form: census.formFreq,
                ott: census.ottFreq,
                mode: census.modeFreq,
                bs: census.bsFreq,
                oe: census.oeFreq,
              ),
              _buildCensusRow(
                form: census.formSeries,
                ott: census.ottSeries,
                mode: census.modeSeries,
                bs: census.bsSeries,
                oe: census.oeSeries,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCensusRow({
    required List<OmitValue> form,
    required List<OmitValue> ott,
    required List<OmitValue> mode,
    required List<OmitValue> bs,
    required List<OmitValue> oe,
  }) {
    List<Widget> views = [
      Container(
        width: left,
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
    views.addAll(form
        .map((e) => _censusCell(
              value: e.value,
              color: greyBorder,
              width: e.key == '豹子' ? 1.0 : 0.4,
            ))
        .toList());
    views.addAll(ott
        .map((e) => _censusCell(
              value: e.value,
              color: greyBorder,
              width: e.key == '22' ? 1.0 : 0.4,
            ))
        .toList());
    views.addAll(mode
        .map((e) => _censusCell(
              value: e.value,
              color: greyBorder,
              width: e.key == '平行' ? 1.0 : 0.4,
            ))
        .toList());
    views.addAll(bs
        .map((e) => _censusCell(
              value: e.value,
              color: greyBorder,
              width: e.key == '全大' ? 1.0 : 0.4,
            ))
        .toList());
    views.addAll(oe
        .map((e) => _censusCell(
              value: e.value,
              color: greyBorder,
              width: e.key == '全偶' ? 1.0 : 0.4,
            ))
        .toList());
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(children: views),
    );
  }

  Widget _censusCell({int? value, required Color color, double width = 0.4}) {
    return SizedBox(
      width: shapeCellWidth,
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
    for (var e in widget.lotteries) {
      lotteries[e.period] = e;
    }
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
}
