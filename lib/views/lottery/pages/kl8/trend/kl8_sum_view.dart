import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/views/lottery/model/kl8_omit_census.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_omit.dart';
import 'package:prize_lottery_app/views/lottery/model/slide_direction.dart';
import 'package:prize_lottery_app/views/lottery/pages/fc3d/fc3d_number_trend_view.dart';
import 'package:prize_lottery_app/views/lottery/utils/trend_constants.dart';

final List<String> sumHeaders = [
  '210+',
  '403+',
  '559+',
  '655+',
  '715+',
  '751+',
  '775+',
  '799+',
  '823+',
  '847+',
  '871+',
  '907+',
  '967+',
  '1063+',
  '1219+'
];

class Kl8SumView extends StatefulWidget {
  const Kl8SumView({
    super.key,
    required this.rows,
    required this.omits,
    required this.census,
  });

  final int rows;
  final List<Kl8Omit> omits;
  final Kl8OmitCensus census;

  @override
  State<Kl8SumView> createState() => _Kl8SumViewState();
}

class _Kl8SumViewState extends State<Kl8SumView>
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

  ///表格宽度
  double width = 40.w;

  ///左侧宽度
  double left = trendLeftWidth;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                    height: cell,
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
                        fontSize: 12.sp,
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
              top: cell,
              child: SizedBox(
                height: cell * (widget.rows - 5),
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
                    top: BorderSide(color: greyBorder, width: 0.4),
                    bottom: BorderSide(color: greyBorder, width: 0.4),
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
        width: width * 15,
        height: cell,
        child: Row(
          children: _buildHeaderCells(),
        ),
      ),
    );
  }

  List<Widget> _buildHeaderCells() {
    return List.generate(
      15,
      (index) => Container(
        width: width,
        height: cell,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.05),
          border: Border(
            top: BorderSide(color: greyBorder, width: 0.4),
            bottom: BorderSide(color: greyBorder, width: 0.4),
            right: BorderSide(
              color: index == 2 || index == 11 ? redFont : greyBorder,
              width: index == 2 || index == 11 ? 1 : 0.4,
            ),
          ),
        ),
        child: Text(
          sumHeaders[index],
          style: TextStyle(color: blackFont, fontSize: 12.sp),
        ),
      ),
    );
  }

  Widget _buildLeft(List<Kl8Omit> omits) {
    return SingleChildScrollView(
      controller: _leftController,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: leftCells(omits),
      ),
    );
  }

  List<Widget> leftCells(List<Kl8Omit> omits) {
    List<Widget> views = [];
    for (int i = 0; i < omits.length; i++) {
      Kl8Omit omit = omits[i];
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

  Widget _buildBodyContent(List<Kl8Omit> omits) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: _bodyHController,
      child: SizedBox(
        height: cell * omits.length,
        width: width * 15,
        child: ListView.builder(
          padding: const EdgeInsets.all(0),
          controller: _bodyVController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: omits.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: cell,
              width: MediaQuery.of(context).size.width - left,
              decoration: BoxDecoration(
                color: index % 2 == 0
                    ? Colors.white
                    : Colors.grey.withValues(alpha: 0.05),
              ),
              child: bodyRow(omits[index]),
            );
          },
        ),
      ),
    );
  }

  Widget bodyRow(Kl8Omit omit) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _buildBodyCells(omit.sumOmit.values),
      ),
    );
  }

  List<Widget> _buildBodyCells(List<OmitValue> values) {
    return values
        .map(
          (e) => Container(
            width: width,
            height: cell,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: greyBorder, width: 0.4),
                right: BorderSide(
                  width: e.key == '559+' || e.key == '907+' ? 1 : 0.4,
                  color:
                      e.key == '559+' || e.key == '907+' ? redFont : greyBorder,
                ),
              ),
            ),
            child: e.value == 0
                ? _cellBall(e.extra.isNotEmpty ? e.extra : e.key)
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

  Widget _cellBall(String title) {
    return Container(
      width: width,
      height: cell,
      alignment: Alignment.center,
      color: redFont,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
        ),
      ),
    );
  }

  List<Widget> _bottomLeftHeader() {
    return bottomHeaders
        .map(
          (e) => Container(
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
          ),
        )
        .toList();
  }

  Widget _bottomBodyContent(Kl8OmitCensus census) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - left,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        controller: _bottomController,
        child: SizedBox(
          height: cell * 4,
          width: width * 15,
          child: Column(
            children: [
              _buildCensusRow(census.sumMax),
              _buildCensusRow(census.sumAvg),
              _buildCensusRow(census.sumFreq),
              _buildCensusRow(census.sumSeries),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCensusRow(List<OmitValue> census) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: census
            .map((e) => _censusCell(
                  value: e.value,
                  border: e.key == '559+' || e.key == '907+' ? 1 : 0.4,
                  color:
                      e.key == '559+' || e.key == '907+' ? redFont : greyBorder,
                ))
            .toList(),
      ),
    );
  }

  Widget _censusCell(
      {required int value, required Color color, double border = 0.4}) {
    return Container(
      width: width,
      height: cell,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(
            color: color,
            width: border,
          ),
          bottom: BorderSide(color: greyBorder, width: 0.4),
        ),
      ),
      child: Text(
        '$value',
        style: TextStyle(color: blackFont, fontSize: 12.sp),
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
  bool get wantKeepAlive => true;

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
    _leftController.dispose();
    _topController.dispose();
    _bodyHController.dispose();
    _bodyVController.dispose();
    _bottomController.dispose();
    super.dispose();
  }
}
