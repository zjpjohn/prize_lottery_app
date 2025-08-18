import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_item_omit_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_omit.dart';
import 'package:prize_lottery_app/views/lottery/model/n3_omit_census.dart';
import 'package:prize_lottery_app/views/lottery/pages/fc3d/fc3d_number_trend_view.dart';
import 'package:prize_lottery_app/views/lottery/utils/trend_constants.dart';
import 'package:prize_lottery_app/views/lottery/widgets/draw_line_painter.dart';

import '../model/slide_direction.dart';

class ItemOmitWidget extends StatefulWidget {
  const ItemOmitWidget({
    super.key,
    required this.type,
    required this.rows,
  });

  final int type;
  final int rows;

  @override
  State<ItemOmitWidget> createState() => _ItemOmitWidgetState();
}

class _ItemOmitWidgetState extends State<ItemOmitWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      height: widget.rows * trendCellSize + 0.5.w,
      child: RequestWidget<LotteryItemOmitController>(
        builder: (controller) {
          MapEntry<ItemOmitCensus, List<CbItemOmit>> entry =
              controller.cbOmits(widget.type);
          return ItemOmitView(
            rows: widget.rows,
            omits: entry.value,
            census: entry.key,
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ItemOmitView extends StatefulWidget {
  const ItemOmitView({
    super.key,
    required this.rows,
    required this.omits,
    required this.census,
  });

  final int rows;
  final List<CbItemOmit> omits;
  final ItemOmitCensus census;

  @override
  State<ItemOmitView> createState() => _ItemOmitViewState();
}

class _ItemOmitViewState extends State<ItemOmitView> {
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
        width: left + cellWidth * 33,
        height: cell * 2,
        child: Row(
          children: [
            _buildLottoHeader(),
            _buildBaseHeader(),
            _buildAmpHeader(),
            _buildOtherHeader('升平降', ['升', '平', '降']),
            _buildOtherHeader('大小', ['大', '小']),
            _buildOtherHeader('奇偶', ['奇', '偶']),
          ],
        ),
      ),
    );
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

  Widget _buildBaseHeader() {
    return SizedBox(
      width: cellWidth * 10,
      height: cell * 2,
      child: Column(
        children: [
          Container(
            width: cellWidth * 10,
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
              '号码走势',
              style: TextStyle(color: blackFont, fontSize: 13.sp),
            ),
          ),
          Row(
            children: List.generate(
              10,
              (index) => Container(
                width: cellWidth,
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

  Widget _buildAmpHeader() {
    return SizedBox(
      width: cellWidth * 10,
      height: cell * 2,
      child: Column(
        children: [
          Container(
            width: cellWidth * 10,
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
              '振幅',
              style: TextStyle(color: blackFont, fontSize: 13.sp),
            ),
          ),
          Row(
            children: List.generate(
              10,
              (index) => Container(
                width: cellWidth,
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

  Widget _buildOtherHeader(String title, List<String> keys) {
    return SizedBox(
      width: cellWidth * (keys.length + 2),
      height: cell * 2,
      child: Column(
        children: [
          Container(
            width: cellWidth * 10,
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
            children: [
              Container(
                width: cellWidth,
                height: cell,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.05),
                  border: Border(
                    bottom: BorderSide(color: greyBorder, width: 0.4),
                    right: BorderSide(color: greyBorder, width: 0.4),
                  ),
                ),
              ),
              ...keys.map(
                (e) => Container(
                  width: cellWidth,
                  height: cell,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.05),
                    border: Border(
                      bottom: BorderSide(color: greyBorder, width: 0.4),
                      right: BorderSide(color: greyBorder, width: 0.4),
                    ),
                  ),
                  child: Text(
                    e,
                    style: TextStyle(color: blackFont, fontSize: 12.sp),
                  ),
                ),
              ),
              Container(
                width: cellWidth,
                height: cell,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.05),
                  border: Border(
                    bottom: BorderSide(color: greyBorder, width: 0.4),
                    right: BorderSide(color: greyBorder, width: 1.0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLeftContent(List<CbItemOmit> omits) {
    return SingleChildScrollView(
      controller: _leftController,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: _leftContentCells(omits),
      ),
    );
  }

  List<Widget> _leftContentCells(List<CbItemOmit> omits) {
    List<Widget> views = [];
    for (int i = 0; i < omits.length; i++) {
      CbItemOmit omit = omits[i];
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

  Widget _buildBodyContent(List<CbItemOmit> omits) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: _bodyHController,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _bodyVController,
        child: SizedBox(
          width: cellWidth * 33 + left,
          height: cell * omits.length,
          child: CustomPaint(
            size: Size(cellWidth * 33 + left, cell * omits.length),
            foregroundPainter: RecDrawLinePainter(buildItemPositions(omits)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _bodyContentRows(omits),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _bodyContentRows(List<CbItemOmit> omits) {
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

  Widget _buildBodyRow(CbItemOmit omit) {
    List<Widget> views = [
      _buildLottoCell(omit),
      ..._buildBaseOrAmpOmit(omit.cb.values),
      ..._buildBaseOrAmpOmit(omit.cbAmp.values),
      ..._buildOtherOmit(omit.cbAod.values),
      ..._buildOtherOmit(omit.cbBos.values),
      ..._buildOtherOmit(omit.cbOe.values),
    ];
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: views,
      ),
    );
  }

  Widget _buildLottoCell(CbItemOmit omit) {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: omit
            .lottery()
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

  List<Widget> _buildBaseOrAmpOmit(List<OmitValue> values) {
    return values
        .map((e) => Container(
              width: cellWidth,
              height: cell,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: e.value == 0 ? redFont : Colors.transparent,
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
              child: Text(
                e.value == 0 ? e.key : '${e.value}',
                style: TextStyle(
                  color: e.value == 0 ? Colors.white : blackFont,
                  fontSize: e.value == 0 ? 14.sp : 12.sp,
                ),
              ),
            ))
        .toList();
  }

  List<Widget> _buildOtherOmit(List<OmitValue> values) {
    return [
      Container(
        width: cellWidth,
        height: cell,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            right: BorderSide(color: greyBorder, width: 0.4),
            bottom: BorderSide(color: greyBorder, width: 0.4),
          ),
        ),
      ),
      ...values.map((e) => Container(
            width: cellWidth,
            height: cell,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: e.value == 0 ? redFont : Colors.transparent,
              border: Border(
                right: BorderSide(color: greyBorder, width: 0.4),
                bottom: BorderSide(color: greyBorder, width: 0.4),
              ),
            ),
            child: Text(
              e.value == 0 ? e.key : '${e.value}',
              style: TextStyle(
                color: e.value == 0 ? Colors.white : blackFont,
                fontSize: e.value == 0 ? 13.sp : 12.sp,
              ),
            ),
          )),
      Container(
        width: cellWidth,
        height: cell,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            right: BorderSide(color: greyBorder, width: 1.0),
            bottom: BorderSide(color: greyBorder, width: 0.4),
          ),
        ),
      ),
    ];
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

  Widget _bottomBodyContent(ItemOmitCensus census) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - left,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        controller: _bottomController,
        child: SizedBox(
          height: cell * 4,
          width: cellWidth * 33 + left,
          child: Column(
            children: [
              _buildCensusRow(
                cb: census.cbMax,
                amp: census.ampMax,
                aod: census.aodMax,
                bos: census.bosMax,
                oe: census.oeMax,
              ),
              _buildCensusRow(
                cb: census.cbAvg,
                amp: census.ampAvg,
                aod: census.aodAvg,
                bos: census.bosAvg,
                oe: census.oeAvg,
              ),
              _buildCensusRow(
                cb: census.cbFreq,
                amp: census.ampFreq,
                aod: census.aodFreq,
                bos: census.bosFreq,
                oe: census.oeFreq,
              ),
              _buildCensusRow(
                cb: census.cbSeries,
                amp: census.ampSeries,
                aod: census.aodSeries,
                bos: census.bosSeries,
                oe: census.oeSeries,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCensusRow({
    required List<OmitValue> cb,
    required List<OmitValue> amp,
    required List<OmitValue> aod,
    required List<OmitValue> bos,
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
    views.addAll(cb
        .map((e) => _censusCell(
              value: e.value,
              color: greyBorder,
              width: e.key == '9' ? 1.0 : 0.4,
            ))
        .toList());
    views.addAll(amp
        .map((e) => _censusCell(
              value: e.value,
              color: greyBorder,
              width: e.key == '9' ? 1.0 : 0.4,
            ))
        .toList());
    views.add(_censusCell(color: greyBorder));
    views.addAll(aod
        .map((e) => _censusCell(
              value: e.value,
              color: greyBorder,
              width: 0.4,
            ))
        .toList());
    views.add(_censusCell(color: greyBorder, width: 1.0));
    views.add(_censusCell(color: greyBorder));
    views.addAll(bos
        .map((e) => _censusCell(
              value: e.value,
              color: greyBorder,
              width: 0.4,
            ))
        .toList());
    views.add(_censusCell(color: greyBorder, width: 1.0));
    views.add(_censusCell(color: greyBorder));
    views.addAll(oe
        .map((e) => _censusCell(
              value: e.value,
              color: greyBorder,
              width: 0.4,
            ))
        .toList());
    views.add(_censusCell(color: greyBorder, width: 1.0));
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(children: views),
    );
  }

  Widget _censusCell({int? value, required Color color, double width = 0.4}) {
    return SizedBox(
      width: cellWidth,
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
    _leftController = ScrollController();
    _topController = ScrollController();
    _bodyHController = ScrollController();
    _bodyVController = ScrollController();
    _bottomController = ScrollController();
    super.initState();
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
