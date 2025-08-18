import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_pl5_omit_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_omit.dart';
import 'package:prize_lottery_app/views/lottery/model/n3_omit_census.dart';
import 'package:prize_lottery_app/views/lottery/model/slide_direction.dart';
import 'package:prize_lottery_app/views/lottery/pages/fc3d/fc3d_number_trend_view.dart';
import 'package:prize_lottery_app/views/lottery/utils/trend_constants.dart';
import 'package:prize_lottery_app/views/lottery/widgets/draw_line_painter.dart';
import 'package:prize_lottery_app/views/lottery/widgets/mark_cell.dart';
import 'package:prize_lottery_app/views/lottery/widgets/page_query_widget.dart';

class Pl5TrendView extends StatefulWidget {
  const Pl5TrendView({
    super.key,
    required this.rows,
  });

  final int rows;

  @override
  State<Pl5TrendView> createState() => _Pl5TrendViewState();
}

class _Pl5TrendViewState extends State<Pl5TrendView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Get.put(LotteryPl5OmitController());
    return Column(
      children: [
        SizedBox(
          height: widget.rows * trendCellSize + 0.5.w,
          child: RequestWidget<LotteryPl5OmitController>(
            builder: (controller) {
              return TrendView(
                rows: widget.rows,
                omits: controller.omits,
                census: controller.census,
              );
            },
          ),
        ),
        GetBuilder<LotteryPl5OmitController>(
          builder: (controller) {
            return PageQueryWidget(
              page: controller.size,
              toMaster: 'pl5/mul_rank',
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

class TrendView extends StatefulWidget {
  ///
  ///
  const TrendView({
    super.key,
    required this.rows,
    required this.omits,
    required this.census,
  });

  final int rows;
  final List<LotteryOmit> omits;
  final Pl5OmitCensus census;

  @override
  TrendViewState createState() => TrendViewState();
}

class TrendViewState extends State<TrendView> {
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
                    _buildLeft(widget.omits),
                    SizedBox(
                      width: width - left,
                      child: _buildBodyContent(widget.omits),
                    )
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
        width: cell * 60,
        height: cell * 2,
        child: Row(
          children: _buildHeaderCells(),
        ),
      ),
    );
  }

  List<Widget> _buildHeaderCells() {
    List<Widget> views = [];
    views.add(_buildGroupHeader('组选'));
    views.add(_buildGroupHeader('万位'));
    views.add(_buildGroupHeader('千位'));
    views.add(_buildGroupHeader('百位'));
    views.add(_buildGroupHeader('十位'));
    views.add(_buildGroupHeader('个位'));
    return views;
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

  ///body左侧组件
  Widget _buildLeft(List<LotteryOmit> omits) {
    return SingleChildScrollView(
      controller: _leftController,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          ...leftCells(omits),
          leftMark(),
        ],
      ),
    );
  }

  List<Widget> leftCells(List<LotteryOmit> omits) {
    List<Widget> views = [];
    for (int i = 0; i < omits.length; i++) {
      LotteryOmit omit = omits[i];
      views.add(
        Container(
          width: left,
          height: cell,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color:
                i % 2 == 0 ? Colors.white : Colors.grey.withValues(alpha: 0.05),
            border: Border(
              right: BorderSide(color: greyBorder, width: 0.4),
              bottom: BorderSide(color: greyBorder, width: 0.4),
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

  Widget leftMark() {
    return Container(
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
        '标记行',
        style: TextStyle(color: blackFont, fontSize: 13.sp),
      ),
    );
  }

  Widget _buildBodyContent(List<LotteryOmit> omits) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: _bodyHController,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _bodyVController,
        child: Column(
          children: [
            SizedBox(
              height: cell * omits.length,
              width: cell * 60,
              child: CustomPaint(
                size: Size(cell * 60, cell * omits.length),
                foregroundPainter: DrawLinePainter(omits),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _bodyContentRows(omits),
                ),
              ),
            ),
            markRow(),
          ],
        ),
      ),
    );
  }

  List<Widget> _bodyContentRows(List<LotteryOmit> omits) {
    List<Widget> views = [];
    for (int index = 0; index < omits.length; index++) {
      views.add(Container(
        height: cell,
        color:
            index % 2 == 0 ? Colors.white : Colors.grey.withValues(alpha: 0.05),
        child: bodyRow(omits[index]),
      ));
    }
    return views;
  }

  Widget bodyRow(LotteryOmit omit) {
    List<Widget> views = [];
    views.addAll(_buildCbCells(omit.red!.values));
    views.addAll(_buildCbCells(omit.cb1!.values));
    views.addAll(_buildCbCells(omit.cb2!.values));
    views.addAll(_buildCbCells(omit.cb3!.values));
    views.addAll(_buildCbCells(omit.cb4!.values));
    views.addAll(_buildCbCells(omit.cb5!.values));
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: views,
      ),
    );
  }

  Widget markRow() {
    List<Widget> children = [];
    children.addAll(markCells());
    children.addAll(markCells());
    children.addAll(markCells());
    children.addAll(markCells());
    children.addAll(markCells());
    children.addAll(markCells());
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: children,
      ),
    );
  }

  List<Widget> markCells() {
    return List.generate(
      10,
      (i) => MarkCell(
        ball: '$i',
        size: cell,
        border: Border(
          bottom: BorderSide(color: greyBorder, width: 0.4),
          right: BorderSide(color: greyBorder, width: i == 9 ? 1.0 : 0.4),
        ),
      ),
    ).toList();
  }

  List<Widget> _buildCbCells(List<OmitValue> values) {
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

  Widget _bottomBodyContent(Pl5OmitCensus census) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - left,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        controller: _bottomController,
        child: SizedBox(
          height: cell * 4,
          width: cell * 60,
          child: Column(
            children: [
              _buildCensusRow(
                ball: census.ballMax,
                cb1: census.cb1Max,
                cb2: census.cb2Max,
                cb3: census.cb3Max,
                cb4: census.cb4Max,
                cb5: census.cb5Max,
              ),
              _buildCensusRow(
                ball: census.ballAvg,
                cb1: census.cb1Avg,
                cb2: census.cb2Avg,
                cb3: census.cb3Avg,
                cb4: census.cb4Avg,
                cb5: census.cb5Avg,
              ),
              _buildCensusRow(
                ball: census.ballFreq,
                cb1: census.cb1Freq,
                cb2: census.cb2Freq,
                cb3: census.cb3Freq,
                cb4: census.cb4Freq,
                cb5: census.cb5Freq,
              ),
              _buildCensusRow(
                ball: census.ballSeries,
                cb1: census.cb1Series,
                cb2: census.cb2Series,
                cb3: census.cb3Series,
                cb4: census.cb4Series,
                cb5: census.cb5Series,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCensusRow({
    required List<OmitValue> ball,
    required List<OmitValue> cb1,
    required List<OmitValue> cb2,
    required List<OmitValue> cb3,
    required List<OmitValue> cb4,
    required List<OmitValue> cb5,
  }) {
    List<Widget> cells = [];
    cells.addAll(
      ball.map(
        (e) => _censusCell(
          value: e.value,
          color: greyBorder,
          width: e.key == '9' ? 1 : 0.4,
        ),
      ),
    );
    cells.addAll(
      cb1.map(
        (e) => _censusCell(
          value: e.value,
          color: greyBorder,
          width: e.key == '9' ? 1 : 0.4,
        ),
      ),
    );
    cells.addAll(
      cb2.map(
        (e) => _censusCell(
          value: e.value,
          color: greyBorder,
          width: e.key == '9' ? 1 : 0.4,
        ),
      ),
    );
    cells.addAll(
      cb3.map(
        (e) => _censusCell(
          value: e.value,
          color: greyBorder,
          width: e.key == '9' ? 1 : 0.4,
        ),
      ),
    );
    cells.addAll(
      cb4.map(
        (e) => _censusCell(
          value: e.value,
          color: greyBorder,
          width: e.key == '9' ? 1 : 0.4,
        ),
      ),
    );
    cells.addAll(
      cb5.map(
        (e) => _censusCell(
          value: e.value,
          color: greyBorder,
          width: e.key == '9' ? 1 : 0.4,
        ),
      ),
    );
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: cells,
      ),
    );
  }

  Widget _censusCell(
      {required int value, required Color color, double width = 0.4}) {
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
          '$value',
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
}
