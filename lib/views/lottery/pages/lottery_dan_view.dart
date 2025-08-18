import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_dan_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_dan.dart';
import 'package:prize_lottery_app/views/lottery/model/slide_direction.dart';
import 'package:prize_lottery_app/views/lottery/utils/trend_constants.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:prize_lottery_app/widgets/lottery_hint_widget.dart';

class LotteryDanView extends StatelessWidget {
  const LotteryDanView({super.key});

  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height;
    double blockHeight = height - top - 44.w - 38.w;
    int rows = blockHeight ~/ trendCellSize;
    return LayoutContainer(
      title: '选号定胆',
      right: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return _headerDialog(context);
              });
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
      content: RequestWidget<LotteryDanController>(
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LotteryDanWidget(
                rows: rows,
                data: controller.danList,
                current: controller.current,
                maxOmit: controller.maxOmit,
                avgOmit: controller.avgOmit,
                frequent: controller.frequent,
              ),
              _buildBottomHint(),
            ],
          );
        },
      ),
    );
  }

  Widget _headerDialog(BuildContext context) {
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
              '使用说明',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.w),
              child: Text(
                '1.指标一是和尾，指标二是最小数，指标三是最大数，指标四是大数加中数取尾， '
                '指标五是小数加中数取尾，指标六七八分别是百十个位数，指标九是积尾'
                '\n2.指标出现频率过低出号的可能性较大，过高出现可能性较小，具体使用请结合自身选号经验。',
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

  Widget _buildBottomHint() {
    return SizedBox(
      height: 38.w,
      child: const LotteryHintWidget(
        hint: '定胆推荐仅供参考，请您结合自己选号经验使用',
      ),
    );
  }
}

class LotteryDanWidget extends StatefulWidget {
  const LotteryDanWidget({
    super.key,
    required this.rows,
    required this.data,
    required this.current,
    required this.maxOmit,
    required this.avgOmit,
    required this.frequent,
  });

  final int rows;
  final List<LotteryDan> data;
  final DanOmitCensus current;
  final DanOmitCensus maxOmit;
  final DanOmitCensus avgOmit;
  final DanOmitCensus frequent;

  @override
  State<LotteryDanWidget> createState() => _LotteryDanWidgetState();
}

const List<String> bottomHeaders = ['当前遗漏', '平均遗漏', '最大遗漏', '出现次数'];

class _LotteryDanWidgetState extends State<LotteryDanWidget> {
  ///
  Map<String, LotteryDan> lottos = {};

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

  ///
  double cellWidth = trendCellSize;

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
        height: cell * widget.rows + 1.h,
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
                    _buildLeftContent(widget.data),
                    SizedBox(
                      width: width - left,
                      child: _buildBodyContent(widget.data),
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
                    Column(children: _bottomLeftHeader()),
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
        width: cellWidth * 10 + trendLeftWidth,
        child: Row(
          children: _buildHeaderCells(),
        ),
      ),
    );
  }

  List<Widget> _buildHeaderCells() {
    return [
      _buildLottoHeader(),
      _buildSumHeader(),
      _buildDanHeader(),
    ];
  }

  Widget _buildLottoHeader() {
    return Container(
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
        '开奖号',
        style: TextStyle(
          color: blackFont,
          fontSize: 13.sp,
        ),
      ),
    );
  }

  Widget _buildSumHeader() {
    return Container(
      width: cell,
      height: cell * 2,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: greyBorder, width: 1.2),
          top: BorderSide(color: greyBorder, width: 0.4),
          bottom: BorderSide(color: greyBorder, width: 0.4),
        ),
      ),
      child: Text(
        '和值',
        style: TextStyle(
          color: blackFont,
          fontSize: 13.sp,
        ),
      ),
    );
  }

  Widget _buildDanHeader() {
    return SizedBox(
      height: cell * 2,
      width: cellWidth * 9,
      child: Column(
        children: [
          Container(
            width: cellWidth * 9,
            height: cell,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(color: greyBorder, width: 1.2),
                top: BorderSide(color: greyBorder, width: 0.4),
                bottom: BorderSide(color: greyBorder, width: 0.4),
              ),
            ),
            child: Text(
              '胆码指标',
              style: TextStyle(color: blackFont, fontSize: 13.sp),
            ),
          ),
          Row(
            children: List.generate(
              9,
              (index) {
                int column = index + 1;
                return Container(
                  width: cellWidth,
                  height: cell,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: greyBorder, width: 0.4),
                      right: BorderSide(
                        color: greyBorder,
                        width: column % 3 == 0 ? 1.2 : 0.4,
                      ),
                    ),
                  ),
                  child: Text(
                    '$column',
                    style: TextStyle(color: blackFont, fontSize: 14.sp),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftContent(List<LotteryDan> list) {
    return SingleChildScrollView(
      controller: _leftController,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(children: _leftContentCells(list)),
    );
  }

  List<Widget> _leftContentCells(List<LotteryDan> list) {
    List<Widget> views = [];
    for (int i = 0; i < list.length; i++) {
      LotteryDan dan = list[i];
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
            '${dan.period.substring(4)} 期',
            style: TextStyle(color: blackFont, fontSize: 13.sp),
          ),
        ),
      );
    }
    return views;
  }

  Widget _buildBodyContent(List<LotteryDan> list) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: _bodyHController,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _bodyVController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildContentRows(list),
        ),
      ),
    );
  }

  List<Widget> _buildContentRows(List<LotteryDan> list) {
    List<Widget> views = [];
    for (int index = 0; index < list.length; index++) {
      views.add(
        Container(
          height: cell,
          color: index % 2 == 0
              ? Colors.white
              : Colors.grey.withValues(alpha: 0.05),
          child: _buildBodyRow(list[index]),
        ),
      );
    }
    return views;
  }

  Widget _buildBodyRow(LotteryDan dan) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildLotto(dan),
          _buildSum(dan),
          _buildIndex(index: dan.index1, border: 0.4, color: redFont),
          _buildIndex(index: dan.index2, border: 0.4, color: Colors.blueAccent),
          _buildIndex(index: dan.index3, border: 1.2, color: Colors.deepOrange),
          _buildIndex(index: dan.index4, border: 0.4, color: redFont),
          _buildIndex(index: dan.index5, border: 0.4, color: Colors.blueAccent),
          _buildIndex(index: dan.index6, border: 1.2, color: Colors.deepOrange),
          _buildIndex(index: dan.index7, border: 0.4, color: redFont),
          _buildIndex(index: dan.index8, border: 0.4, color: Colors.blueAccent),
          _buildIndex(index: dan.index9, border: 0.4, color: Colors.deepOrange),
        ],
      ),
    );
  }

  Widget _buildLotto(LotteryDan dan) {
    return Container(
      height: cell,
      width: left,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: greyBorder, width: 0.4),
          bottom: BorderSide(color: greyBorder, width: 0.4),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: dan.balls
            .map(
              (e) => Padding(
                padding: EdgeInsets.only(right: 2.w),
                child: Text(
                  e,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: dan.isThree ? blackFont : redFont,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildSum(LotteryDan dan) {
    return Container(
      height: cell,
      width: cell,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: greyBorder, width: 1.2),
          bottom: BorderSide(color: greyBorder, width: 0.4),
        ),
      ),
      child: Text(
        '${dan.sum()}',
        style: TextStyle(
          fontSize: 14.sp,
          color: blackFont,
        ),
      ),
    );
  }

  Widget _buildIndex({
    required DanIndex index,
    required double border,
    required Color color,
  }) {
    return Container(
      width: cellWidth,
      height: cell,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: index.hit == 1 ? color : Colors.transparent,
        border: Border(
          right: BorderSide(
            color: greyBorder,
            width: border,
          ),
          bottom: BorderSide(
            color: greyBorder,
            width: 0.4,
          ),
        ),
      ),
      child: Text(
        '${index.key}',
        style: TextStyle(
          color: index.hit == 1 ? Colors.white : blackFont,
          fontSize: 14.sp,
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

  Widget _bottomBodyContent() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - left,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        controller: _bottomController,
        child: SizedBox(
          height: cell * 4,
          width: left + cell * 10,
          child: Column(
            children: [
              _buildCensusRow(widget.current),
              _buildCensusRow(widget.avgOmit),
              _buildCensusRow(widget.maxOmit),
              _buildCensusRow(widget.frequent),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCensusRow(DanOmitCensus census) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            width: left + cell,
            height: cell,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(color: greyBorder, width: 1.2),
                bottom: BorderSide(color: greyBorder, width: 0.4),
              ),
            ),
          ),
          _censusCell(value: census.index1),
          _censusCell(value: census.index2),
          _censusCell(value: census.index3, width: 1.2),
          _censusCell(value: census.index4),
          _censusCell(value: census.index5),
          _censusCell(value: census.index6, width: 1.2),
          _censusCell(value: census.index7),
          _censusCell(value: census.index8),
          _censusCell(value: census.index9, width: 1.2),
        ],
      ),
    );
  }

  Widget _censusCell({required int value, double width = 0.4}) {
    return SizedBox(
      width: cellWidth,
      height: cell,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            right: BorderSide(
              color: greyBorder,
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
            fontSize: 14.sp,
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
    lottos = {for (var v in widget.data) v.period: v};
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
