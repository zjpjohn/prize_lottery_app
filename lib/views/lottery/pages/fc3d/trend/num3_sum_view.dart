import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_sum_omit_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_omit.dart';
import 'package:prize_lottery_app/views/lottery/model/n3_omit_census.dart';
import 'package:prize_lottery_app/views/lottery/model/slide_direction.dart';
import 'package:prize_lottery_app/views/lottery/pages/fc3d/fc3d_number_trend_view.dart';
import 'package:prize_lottery_app/views/lottery/utils/trend_constants.dart';
import 'package:prize_lottery_app/views/lottery/widgets/draw_line_painter.dart';
import 'package:prize_lottery_app/views/lottery/widgets/page_query_widget.dart';

class Num3SumView extends StatefulWidget {
  const Num3SumView({
    super.key,
    required this.rows,
    required this.type,
  });

  final int rows;
  final String type;

  @override
  State<Num3SumView> createState() => _Num3SumViewState();
}

class _Num3SumViewState extends State<Num3SumView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Get.put(LotterySumOmitController(widget.type));
    return Column(
      children: [
        SizedBox(
          height: widget.rows * trendCellSize + 0.5.w,
          child: RequestWidget<LotterySumOmitController>(
            init: LotterySumOmitController(widget.type),
            builder: (controller) {
              return SumOmitView(
                rows: widget.rows,
                lotteries: controller.lotteries,
                census: controller.census,
                omits: controller.omits,
              );
            },
          ),
        ),
        GetBuilder<LotterySumOmitController>(
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
}

class SumOmitView extends StatefulWidget {
  const SumOmitView({
    super.key,
    required this.rows,
    required this.lotteries,
    required this.census,
    required this.omits,
  });

  final int rows;
  final List<SumOmit> omits;
  final N3SumCensus census;
  final List<LotteryInfo> lotteries;

  @override
  State<SumOmitView> createState() => _SumOmitViewState();
}

class _SumOmitViewState extends State<SumOmitView> {
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
        width: left + cellWidth * 58,
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
      _buildBaseHeader(),
      _buildTailHeader(),
      _buildTailAmpHeader(),
      _buildOttHeader(),
      _buildBmsHeader(),
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

  Widget _buildBaseHeader() {
    return SizedBox(
      width: cellWidth * 28,
      height: cell * 2,
      child: Column(
        children: [
          Container(
            width: cellWidth * 28,
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
              '和值遗漏',
              style: TextStyle(color: blackFont, fontSize: 13.sp),
            ),
          ),
          Row(
            children: List.generate(
              28,
              (index) => Container(
                width: cellWidth,
                height: cell,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.05),
                  border: Border(
                    bottom: BorderSide(color: greyBorder, width: 0.4),
                    right: BorderSide(
                      color: index == 9 || index == 17 ? redFont : greyBorder,
                      width: index == 27 ? 1.0 : 0.4,
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

  Widget _buildTailHeader() {
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
              '和尾遗漏',
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

  Widget _buildTailAmpHeader() {
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
              '和尾振幅遗漏',
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

  Widget _buildOttHeader() {
    return SizedBox(
      width: cellWidth * 5,
      height: cell * 2,
      child: Column(
        children: [
          Container(
            width: cellWidth * 5,
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
              '012路',
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
              ...List.generate(
                3,
                (index) => Container(
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
                    '$index',
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
          )
        ],
      ),
    );
  }

  Widget _buildBmsHeader() {
    return SizedBox(
      width: cellWidth * 5,
      height: cell * 2,
      child: Column(
        children: [
          Container(
            width: cellWidth * 5,
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
              '小中大',
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
              ...['小', '中', '大'].map((e) => Container(
                    width: cellWidth,
                    height: cell,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.05),
                      border: Border(
                        bottom: BorderSide(color: greyBorder, width: 0.4),
                        right: BorderSide(width: 0.4, color: greyBorder),
                      ),
                    ),
                    child: Text(
                      e,
                      style: TextStyle(color: blackFont, fontSize: 12.sp),
                    ),
                  )),
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

  Widget _buildLeftContent(List<SumOmit> omits) {
    return SingleChildScrollView(
      controller: _leftController,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: _leftContentCells(omits),
      ),
    );
  }

  List<Widget> _leftContentCells(List<SumOmit> omits) {
    List<Widget> views = [];
    for (int i = 0; i < omits.length; i++) {
      SumOmit omit = omits[i];
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

  Widget _buildBodyContent(List<SumOmit> omits) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: _bodyHController,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _bodyVController,
        child: SizedBox(
          width: cellWidth * 58 + left,
          height: cell * omits.length,
          child: CustomPaint(
            size: Size(cellWidth * 58 + left, cell * omits.length),
            foregroundPainter: RecDrawLinePainter(buildSumPositions(omits)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _bodyContentRows(omits),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _bodyContentRows(List<SumOmit> omits) {
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

  Widget _buildBodyRow(SumOmit omit) {
    List<Widget> views = [
      _buildLottoCell(lotteries[omit.period]),
      ..._buildBaseOmit(omit.baseOmit.values),
      ..._buildTailOmit(omit.tailOmit.values),
      ..._buildTailAmpOmit(omit.tailAmp.values),
      ..._buildOttOmit(omit.ottOmit.values),
      ..._buildBmsOmit(omit.bmsOmit.values),
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

  List<Widget> _buildBaseOmit(List<OmitValue> values) {
    return values
        .map((e) => Container(
              width: cellWidth,
              height: cell,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: e.value == 0 ? redFont : Colors.transparent,
                border: Border(
                  right: BorderSide(
                    color: e.key == '9' || e.key == '17' ? redFont : greyBorder,
                    width: e.key == '27' ? 1.0 : 0.4,
                  ),
                  bottom: BorderSide(
                    color: greyBorder,
                    width: 0.4,
                  ),
                ),
              ),
              child: Text(
                getValueTxt(e),
                style: TextStyle(
                  color: e.value == 0 ? Colors.white : blackFont,
                  fontSize: e.value == 0 ? 14.sp : 12.sp,
                ),
              ),
            ))
        .toList();
  }

  String getValueTxt(OmitValue value, {bool zeroWithKey = true}) {
    if (zeroWithKey && value.value == 0) {
      return value.key;
    }
    if (value.value < 1000) {
      return '${value.value}';
    }
    return '999';
  }

  List<Widget> _buildTailOmit(List<OmitValue> values) {
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

  List<Widget> _buildTailAmpOmit(List<OmitValue> values) {
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

  List<Widget> _buildOttOmit(List<OmitValue> values) {
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
                fontSize: e.value == 0 ? 14.sp : 12.sp,
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

  List<Widget> _buildBmsOmit(List<OmitValue> values) {
    return [
      Container(
        width: cellWidth,
        height: cell,
        alignment: Alignment.center,
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
        alignment: Alignment.center,
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

  Widget _bottomBodyContent(N3SumCensus census) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - left,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        controller: _bottomController,
        child: SizedBox(
          height: cell * 4,
          width: cellWidth * 58 + left,
          child: Column(
            children: [
              _buildCensusRow(
                base: census.baseMax,
                tail: census.tailMax,
                tailAmp: census.ampMax,
                ott: census.ottMax,
                bms: census.bmsMax,
              ),
              _buildCensusRow(
                base: census.baseAvg,
                tail: census.tailAvg,
                tailAmp: census.ampAvg,
                ott: census.ottAvg,
                bms: census.bmsAvg,
              ),
              _buildCensusRow(
                base: census.baseFreq,
                tail: census.tailFreq,
                tailAmp: census.ampFreq,
                ott: census.ottFreq,
                bms: census.bmsFreq,
              ),
              _buildCensusRow(
                base: census.baseSeries,
                tail: census.tailSeries,
                tailAmp: census.ampSeries,
                ott: census.ottSeries,
                bms: census.bmsSeries,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCensusRow({
    required List<OmitValue> base,
    required List<OmitValue> tail,
    required List<OmitValue> tailAmp,
    required List<OmitValue> ott,
    required List<OmitValue> bms,
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
    views.addAll(base
        .map((e) => _censusCell(
              value: getValueTxt(e, zeroWithKey: false),
              color: e.key == '9' || e.key == '17' ? redFont : greyBorder,
              width: e.key == '27' ? 1.0 : 0.4,
            ))
        .toList());
    views.addAll(tail
        .map((e) => _censusCell(
              value: '${e.value}',
              color: greyBorder,
              width: e.key == '9' ? 1.0 : 0.4,
            ))
        .toList());
    views.addAll(tailAmp
        .map((e) => _censusCell(
              value: '${e.value}',
              color: greyBorder,
              width: e.key == '9' ? 1.0 : 0.4,
            ))
        .toList());
    views.add(_censusCell(color: greyBorder));
    views.addAll(ott
        .map((e) =>
            _censusCell(value: '${e.value}', color: greyBorder, width: 0.4))
        .toList());
    views.add(_censusCell(color: greyBorder, width: 1.0));
    views.add(_censusCell(color: greyBorder));
    views.addAll(bms
        .map((e) =>
            _censusCell(value: '${e.value}', color: greyBorder, width: 0.4))
        .toList());
    views.add(_censusCell(color: greyBorder, width: 1.0));
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(children: views),
    );
  }

  Widget _censusCell(
      {String value = '', required Color color, double width = 0.4}) {
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
          value,
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
