import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_census.dart';
import 'package:prize_lottery_app/views/lottery/model/slide_direction.dart';
import 'package:prize_lottery_app/views/lottery/utils/trend_constants.dart';

class QlcStateView extends StatefulWidget {
  ///
  const QlcStateView({
    super.key,
    required this.rows,
    required this.censuses,
  });

  final int rows;
  final List<LotteryCensus> censuses;

  @override
  QlcStateViewState createState() => QlcStateViewState();
}

class QlcStateViewState extends State<QlcStateView>
    with AutomaticKeepAliveClientMixin {
  ///顶部左右滑动
  late ScrollController _topController;

  ///左侧上下滑动
  late ScrollController _leftController;

  ///body区域滑动(左右)
  late ScrollController _bodyHController;

  ///body区域滑动(上下)
  late ScrollController _bodyVController;

  ///滑动方向
  late SlideDirection _direction;

  ///上一次结束时滑动的位置
  late Offset last;

  ///顶部高度
  double cell = trendCellSize;

  ///左侧宽度
  double left = trendLeftWidth;

  List<CensusCell> cells = [
    CensusCell(title: '开奖号码', width: 150.w, height: trendCellSize),
    CensusCell(title: '和值', width: 38.w, height: trendCellSize),
    CensusCell(title: '跨度', width: 38.w, height: trendCellSize),
    CensusCell(title: '大小形态', width: 120.w, height: trendCellSize),
    CensusCell(title: '大小比', width: 66.w, height: trendCellSize),
    CensusCell(title: '奇偶形态', width: 120.w, height: trendCellSize),
    CensusCell(title: '奇偶比', width: 66.w, height: trendCellSize),
    CensusCell(title: '质合形态', width: 120.w, height: trendCellSize),
    CensusCell(title: '质合比', width: 66.w, height: trendCellSize),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ///屏幕尺寸
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onPanStart: handleStart,
      onPanEnd: handleEnd,
      onPanUpdate: handleUpdate,
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
            child: Container(
              height: cell * (widget.rows - 1),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: greyBorder, width: 0.4),
                ),
              ),
              child: Row(
                children: [
                  _buildLeft(),
                  SizedBox(
                    width: width - left,
                    child: _buildBodyContent(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: _topController,
      child: SizedBox(
        height: cell,
        child: Row(
          children: _buildHeaderCells(),
        ),
      ),
    );
  }

  List<Widget> _buildHeaderCells() {
    return cells
        .map((e) => Container(
              width: e.width,
              height: cell,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.05),
                border: Border(
                  right: BorderSide(
                      color: Colors.grey.withValues(alpha: 0.2), width: 0.4),
                  top: BorderSide(
                      color: Colors.grey.withValues(alpha: 0.2), width: 0.4),
                  bottom: BorderSide(
                      color: Colors.grey.withValues(alpha: 0.2), width: 0.4),
                ),
              ),
              child: Text(
                e.title,
                style: TextStyle(color: blackFont, fontSize: 12.sp),
              ),
            ))
        .toList();
  }

  Widget _buildLeft() {
    return SingleChildScrollView(
      controller: _leftController,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: _leftCells(widget.censuses),
      ),
    );
  }

  List<Widget> _leftCells(List<LotteryCensus> censuses) {
    List<Widget> views = [];
    for (int i = 0; i < censuses.length; i++) {
      LotteryCensus omit = censuses[i];
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

  Widget _buildBodyContent() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: _bodyHController,
      child: SizedBox(
        height: cell * widget.censuses.length,
        width: getCellsWidth(),
        child: ListView.builder(
          padding: const EdgeInsets.all(0),
          controller: _bodyVController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.censuses.length,
          itemBuilder: (context, index) {
            return Container(
              height: cell,
              width: MediaQuery.of(context).size.width - left,
              decoration: BoxDecoration(
                color: index % 2 == 0
                    ? Colors.white
                    : Colors.grey.withValues(alpha: 0.05),
              ),
              child: _bodyRow(widget.censuses[index]),
            );
          },
        ),
      ),
    );
  }

  Widget _bodyRow(LotteryCensus census) {
    List<Widget> views = [];
    views.add(
      _buildRowCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: census.balls
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
        index: 0,
      ),
    );
    views.add(
      _buildRowCell(
        child: Text(
          '${census.sum}',
          style: TextStyle(
            color: blackFont,
            fontSize: 13.sp,
          ),
        ),
        index: 1,
      ),
    );
    views.add(
      _buildRowCell(
        child: Text(
          '${census.kua}',
          style: TextStyle(
            color: blackFont,
            fontSize: 13.sp,
          ),
        ),
        index: 2,
      ),
    );
    views.add(
      _buildRowCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: census.bs.trend
              .map(
                (e) => Text(
                  e,
                  style: TextStyle(
                    color: e == '大' ? redFont : blueFont,
                    fontSize: 13.sp,
                  ),
                ),
              )
              .toList(),
        ),
        index: 3,
      ),
    );
    views.add(
      _buildRowCell(
        child: Text(
          census.bs.ratio,
          style: TextStyle(
            color: blackFont,
            fontSize: 13.sp,
          ),
        ),
        index: 4,
      ),
    );
    views.add(
      _buildRowCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: census.oe.trend
              .map(
                (e) => Text(
                  e,
                  style: TextStyle(
                    color: e == '偶' ? redFont : blueFont,
                    fontSize: 13.sp,
                  ),
                ),
              )
              .toList(),
        ),
        index: 5,
      ),
    );
    views.add(
      _buildRowCell(
        child: Text(
          census.oe.ratio,
          style: TextStyle(
            color: blackFont,
            fontSize: 13.sp,
          ),
        ),
        index: 6,
      ),
    );
    views.add(
      _buildRowCell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: census.pc.trend
              .map(
                (e) => Text(
                  e,
                  style: TextStyle(
                    color: e == '合' ? redFont : blueFont,
                    fontSize: 13.sp,
                  ),
                ),
              )
              .toList(),
        ),
        index: 7,
      ),
    );
    views.add(
      _buildRowCell(
        child: Text(
          census.pc.ratio,
          style: TextStyle(
            color: blackFont,
            fontSize: 13.sp,
          ),
        ),
        index: 8,
      ),
    );
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: views,
      ),
    );
  }

  Widget _buildRowCell({required Widget child, required int index}) {
    return Container(
      width: cells[index].width,
      height: cells[index].height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: greyBorder, width: 0.4),
          bottom: BorderSide(color: greyBorder, width: 0.4),
        ),
      ),
      child: child,
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
          _topController.jumpTo(_topController.offset + distanceX);
        }
        break;
      case SlideDirection.right:
        if (_topController.offset > _topController.position.minScrollExtent) {
          _bodyHController.jumpTo(_topController.offset - distanceX);
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
            _topController.jumpTo(_bodyHController.offset - ddx);
            _bodyHController.jumpTo(_bodyHController.offset - ddx);
          }
        } else {
          if (_bodyHController.offset <
                  _bodyHController.position.maxScrollExtent &&
              _topController.offset < _topController.position.maxScrollExtent) {
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

  double getCellsWidth() {
    return cells.map((e) => e.width).reduce((v, e) => v + e);
  }

  @override
  void initState() {
    _leftController = ScrollController();
    _topController = ScrollController();
    _bodyHController = ScrollController();
    _bodyVController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _leftController.dispose();
    _topController.dispose();
    _bodyHController.dispose();
    _bodyVController.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
