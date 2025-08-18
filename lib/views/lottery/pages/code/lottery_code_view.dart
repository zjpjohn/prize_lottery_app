import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_code_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_code.dart';
import 'package:prize_lottery_app/views/lottery/model/slide_direction.dart';
import 'package:prize_lottery_app/views/lottery/utils/trend_constants.dart';

///
final double code4Width = 1.2 * trendCellSize;

final double code5Width = 1.4 * trendCellSize;

///顶部高度
final double cell = trendCellSize;

///左侧宽度
final double left = 46.w;

Widget _buildLottoCell(LotteryCode code) {
  return Container(
    height: cell,
    width: left,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      border: Border(
        right: const BorderSide(color: blackFont, width: 0.4),
        bottom: BorderSide(color: greyBorder, width: 0.4),
      ),
    ),
    child: Text(
      code.lottery,
      style: TextStyle(
        color: blackFont,
        fontSize: 13.sp,
      ),
    ),
  );
}

List<Widget> _buildTailOmit(LotteryCode code) {
  return List.generate(
      10,
      (index) => Container(
            width: cell,
            height: cell,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 0.4,
                  color: index == 9 ? blackFont : greyBorder,
                ),
                bottom: BorderSide(
                  color: greyBorder,
                  width: 0.4,
                ),
              ),
            ),
            child: code.tails.contains(index)
                ? Container(
                    width: cell * 0.65,
                    height: cell * 0.65,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(cell),
                    ),
                    child: Text(
                      '$index',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  )
                : null,
          ));
}

List<Widget> _build012Omit(LotteryCode code) {
  return [0, 1, 2]
      .map((index) => Container(
            width: cell,
            height: cell,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 0.4,
                  color: index == 2 ? blackFont : greyBorder,
                ),
                bottom: BorderSide(
                  color: greyBorder,
                  width: 0.4,
                ),
              ),
            ),
            child: code.zot.contains(index)
                ? Container(
                    width: cell * 0.65,
                    height: cell * 0.65,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: redFont,
                      borderRadius: BorderRadius.circular(cell),
                    ),
                    child: Text(
                      '$index',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  )
                : null,
          ))
      .toList();
}

List<Widget> _build147Omit(LotteryCode code) {
  return [1, 4, 7]
      .map((index) => Container(
            width: cell,
            height: cell,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 0.4,
                  color: index == 7 ? blackFont : greyBorder,
                ),
                bottom: BorderSide(
                  color: greyBorder,
                  width: 0.4,
                ),
              ),
            ),
            child: code.ofs.contains(index)
                ? Container(
                    width: cell * 0.65,
                    height: cell * 0.65,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(cell),
                    ),
                    child: Text(
                      '$index',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  )
                : null,
          ))
      .toList();
}

List<Widget> _build258Omit(LotteryCode code) {
  return [2, 5, 8]
      .map((index) => Container(
            width: cell,
            height: cell,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 0.4,
                  color: index == 8 ? blackFont : greyBorder,
                ),
                bottom: BorderSide(
                  color: greyBorder,
                  width: 0.4,
                ),
              ),
            ),
            child: code.tfe.contains(index)
                ? Container(
                    width: cell * 0.65,
                    height: cell * 0.65,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: redFont,
                      borderRadius: BorderRadius.circular(cell),
                    ),
                    child: Text(
                      '$index',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  )
                : null,
          ))
      .toList();
}

List<Widget> _buildOeOmit(LotteryCode code) {
  return ['奇', '偶']
      .map((index) => Container(
            width: cell,
            height: cell,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 0.4,
                  color: index == '偶' ? blackFont : greyBorder,
                ),
                bottom: BorderSide(
                  color: greyBorder,
                  width: 0.4,
                ),
              ),
            ),
            child: code.oe.contains(index)
                ? Container(
                    width: cell * 0.65,
                    height: cell * 0.65,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(cell),
                    ),
                    child: Text(
                      index,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                      ),
                    ),
                  )
                : null,
          ))
      .toList();
}

List<Widget> _buildBsOmit(LotteryCode code) {
  return ['大', '小']
      .map((index) => Container(
            width: cell,
            height: cell,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 0.4,
                  color: index == '小' ? blackFont : greyBorder,
                ),
                bottom: BorderSide(
                  color: greyBorder,
                  width: 0.4,
                ),
              ),
            ),
            child: code.bs.contains(index)
                ? Container(
                    width: cell * 0.65,
                    height: cell * 0.65,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: redFont,
                      borderRadius: BorderRadius.circular(cell),
                    ),
                    child: Text(
                      index,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                      ),
                    ),
                  )
                : null,
          ))
      .toList();
}

List<Widget> _buildPcOmit(LotteryCode code) {
  return ['质', '合']
      .map((index) => Container(
            width: cell,
            height: cell,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 0.4,
                  color: index == '合' ? blackFont : greyBorder,
                ),
                bottom: BorderSide(
                  color: greyBorder,
                  width: 0.4,
                ),
              ),
            ),
            child: code.pc.contains(index)
                ? Container(
                    width: cell * 0.65,
                    height: cell * 0.65,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(cell),
                    ),
                    child: Text(
                      index,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                      ),
                    ),
                  )
                : null,
          ))
      .toList();
}

Widget _buildCodeHint() {
  return Container(
    height: 80.h,
    margin: EdgeInsets.only(top: 6.h),
    padding: EdgeInsets.only(left: 12.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '使用说明:',
          style: TextStyle(color: Colors.black54, fontSize: 12.sp),
        ),
        Text(
          '1.质合尾数—质数代表尾数12357、合数代表尾数04689;',
          style: TextStyle(color: Colors.black54, fontSize: 12.sp),
        ),
        Text(
          '2.012路尾数—0代表尾数0369、1代表尾数147、2代表尾数258;',
          style: TextStyle(color: Colors.black54, fontSize: 12.sp),
        ),
        Text(
          '3.147路尾数—1代表尾数1569、4代表尾数024、7代表尾数378;',
          style: TextStyle(color: Colors.black54, fontSize: 12.sp),
        ),
        Text(
          '4.258路尾数—2代表尾数279、5代表尾数035、8代表尾数1468;',
          style: TextStyle(color: Colors.black54, fontSize: 12.sp),
        ),
      ],
    ),
  );
}

class LotteryCodeView extends StatefulWidget {
  const LotteryCodeView({
    super.key,
    required this.rows,
    required this.lotto,
    required this.type,
  });

  final int rows;
  final int type;
  final String lotto;

  @override
  State<LotteryCodeView> createState() => _LotteryCodeViewState();
}

class _LotteryCodeViewState extends State<LotteryCodeView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RequestWidget<LotteryCodeController>(
        global: false,
        init: LotteryCodeController(lotto: widget.lotto, type: widget.type),
        builder: (controller) {
          if (widget.type == 1) {
            return LotteryCode4View(rows: widget.rows, codes: controller.codes);
          }
          if (widget.type == 2) {
            return LotteryCode5View(rows: widget.rows, codes: controller.codes);
          }
          return const SizedBox.shrink();
        });
  }

  @override
  bool get wantKeepAlive => true;
}

class LotteryCode4View extends StatefulWidget {
  const LotteryCode4View({
    super.key,
    required this.rows,
    required this.codes,
  });

  final int rows;
  final List<LotteryCode> codes;

  @override
  State<LotteryCode4View> createState() => _LotteryCode4ViewState();
}

class _LotteryCode4ViewState extends State<LotteryCode4View> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onPanStart: handleStart,
          onPanEnd: handleEnd,
          onPanUpdate: handleUpdate,
          child: SizedBox(
            width: Get.width,
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
                        width: Get.width - left,
                        child: _buildHeader(),
                      )
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  top: cell * 2,
                  child: SizedBox(
                    height: cell * (widget.rows - 2),
                    child: Row(
                      children: [
                        _buildLeft(widget.codes),
                        SizedBox(
                          width: Get.width - left,
                          child: _buildBodyContent(widget.codes),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: _buildCodeHint(),
        ),
      ],
    );
  }

  Widget _buildLeft(List<LotteryCode> codes) {
    return SingleChildScrollView(
      controller: _leftController,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: leftCells(codes),
      ),
    );
  }

  List<Widget> leftCells(List<LotteryCode> codes) {
    List<Widget> views = [];
    for (int i = 0; i < codes.length; i++) {
      LotteryCode code = codes[i];
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
            '${code.period.substring(4)}期',
            style: TextStyle(color: blackFont, fontSize: 13.sp),
          ),
        ),
      );
    }
    return views;
  }

  Widget _buildBodyContent(List<LotteryCode> codes) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: _bodyHController,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _bodyVController,
        child: SizedBox(
          height: cell * codes.length,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _bodyContentRows(codes),
          ),
        ),
      ),
    );
  }

  List<Widget> _bodyContentRows(List<LotteryCode> codes) {
    List<Widget> views = [];
    for (int index = 0; index < codes.length; index++) {
      views.add(
        Container(
          height: cell,
          color: index % 2 == 0
              ? Colors.white
              : Colors.grey.withValues(alpha: 0.05),
          child: _buildBodyRow(codes[index]),
        ),
      );
    }
    return views;
  }

  Widget _buildBodyRow(LotteryCode code) {
    List<Widget> views = [
      _buildLottoCell(code),
      ..._buildCodeOmit(code),
      ..._buildTailOmit(code),
      ..._build012Omit(code),
      ..._build147Omit(code),
      ..._build258Omit(code),
      ..._buildOeOmit(code),
      ..._buildBsOmit(code),
      ..._buildPcOmit(code),
    ];
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: views,
      ),
    );
  }

  List<Widget> _buildCodeOmit(LotteryCode code) {
    return List.generate(
        30,
        (index) => Container(
              width: code4Width,
              height: cell,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 0.4,
                    color: index == 29 ? blackFont : greyBorder,
                  ),
                  bottom: BorderSide(
                    color: greyBorder,
                    width: 0.4,
                  ),
                ),
              ),
              child: code.positions.contains(index + 1)
                  ? Container(
                      width: 0.70 * code4Width,
                      height: 0.6 * cell,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: code.positions.contains(index + 1)
                            ? redFont
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(cell),
                      ),
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: code.positions.contains(index + 1)
                              ? Colors.white
                              : blackFont,
                          fontSize: 12.sp,
                        ),
                      ),
                    )
                  : null,
            ));
  }

  Widget _buildHeader() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: _topController,
      child: SizedBox(
        height: cell * 2,
        child: Row(
          children: _buildHeaderCells(),
        ),
      ),
    );
  }

  List<Widget> _buildHeaderCells() {
    List<Widget> views = [];
    views.add(_lottoHeader());
    views.addAll(fourCodes.entries
        .map((e) => _codeHeaderCell(
            code: e.value,
            index: e.key,
            color: e.key == 30 ? blackFont : greyBorder,
            width: 0.4))
        .toList());

    views.add(_groupHeader(
        '1-30组尾数', ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']));
    views.add(_groupHeader('尾数012路', ['0', '1', '2']));
    views.add(_groupHeader('尾数147路', ['1', '4', '7']));
    views.add(_groupHeader('尾数258路', ['2', '5', '8']));
    views.add(_groupHeader('奇偶', ['奇', '偶']));
    views.add(_groupHeader('大小', ['大', '小']));
    views.add(_groupHeader('质合', ['质', '合']));
    return views;
  }

  Widget _lottoHeader() {
    return Container(
      width: left,
      height: cell * 2,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          right: const BorderSide(color: blackFont, width: 0.4),
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

  Widget _codeHeaderCell(
      {required String code,
      required int index,
      required Color color,
      double width = 0.4}) {
    return SizedBox(
      width: code4Width,
      height: cell * 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: code4Width,
            height: cell,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: greyBorder, width: 0.4),
                right: BorderSide(color: color, width: width),
                bottom: const BorderSide(color: blackFont, width: 0.4),
              ),
            ),
            child: Text(
              code,
              style: TextStyle(color: blackFont, fontSize: 12.sp),
            ),
          ),
          Container(
            height: cell,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: color, width: width),
                bottom: BorderSide(color: greyBorder, width: 0.4),
              ),
            ),
            child: Text(
              '$index',
              style: TextStyle(color: blackFont, fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _groupHeader(String title, List<String> cells) {
    List<Widget> items = [];
    for (int i = 0; i < cells.length; i++) {
      items.add(Container(
        width: cell,
        height: cell,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: greyBorder, width: 0.4),
            right: BorderSide(
              width: 0.4,
              color: i < cells.length - 1 ? greyBorder : blackFont,
            ),
          ),
        ),
        child: Text(
          cells[i],
          style: TextStyle(color: blackFont, fontSize: 12.sp),
        ),
      ));
    }
    return SizedBox(
      width: cell * cells.length,
      height: cell * 2,
      child: Column(
        children: [
          Container(
            height: cell,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: const BorderSide(color: blackFont, width: 0.4),
                top: BorderSide(color: greyBorder, width: 0.4),
                bottom: const BorderSide(color: blackFont, width: 0.4),
              ),
            ),
            child: Text(
              title,
              style: TextStyle(color: blackFont, fontSize: 12.sp),
            ),
          ),
          Row(children: items),
        ],
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

  @override
  void initState() {
    _leftController = ScrollController();
    _topController = ScrollController();
    _bodyHController = ScrollController();
    _bodyVController = ScrollController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
        _leftController.animateTo(_leftController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500), curve: Curves.linear);
        _bodyVController.animateTo(_leftController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500), curve: Curves.linear);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _leftController.dispose();
    _topController.dispose();
    _bodyHController.dispose();
    _bodyVController.dispose();
  }
}

class LotteryCode5View extends StatefulWidget {
  const LotteryCode5View({
    super.key,
    required this.rows,
    required this.codes,
  });

  final int rows;
  final List<LotteryCode> codes;

  @override
  State<LotteryCode5View> createState() => _LotteryCode5ViewState();
}

class _LotteryCode5ViewState extends State<LotteryCode5View> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onPanStart: handleStart,
          onPanEnd: handleEnd,
          onPanUpdate: handleUpdate,
          child: SizedBox(
            width: Get.width,
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
                        width: Get.width - left,
                        child: _buildHeader(),
                      )
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  top: cell * 2,
                  child: SizedBox(
                    height: cell * (widget.rows - 2),
                    child: Row(
                      children: [
                        _buildLeft(widget.codes),
                        SizedBox(
                          width: Get.width - left,
                          child: _buildBodyContent(widget.codes),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        _buildCodeHint(),
      ],
    );
  }

  Widget _buildLeft(List<LotteryCode> codes) {
    return SingleChildScrollView(
      controller: _leftController,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: leftCells(codes),
      ),
    );
  }

  List<Widget> leftCells(List<LotteryCode> codes) {
    List<Widget> views = [];
    for (int i = 0; i < codes.length; i++) {
      LotteryCode code = codes[i];
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
            '${code.period.substring(4)}期',
            style: TextStyle(color: blackFont, fontSize: 13.sp),
          ),
        ),
      );
    }
    return views;
  }

  Widget _buildBodyContent(List<LotteryCode> codes) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: _bodyHController,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _bodyVController,
        child: SizedBox(
          height: cell * codes.length,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _bodyContentRows(codes),
          ),
        ),
      ),
    );
  }

  List<Widget> _bodyContentRows(List<LotteryCode> codes) {
    List<Widget> views = [];
    for (int index = 0; index < codes.length; index++) {
      views.add(
        Container(
          height: cell,
          color: index % 2 == 0
              ? Colors.white
              : Colors.grey.withValues(alpha: 0.05),
          child: _buildBodyRow(codes[index]),
        ),
      );
    }
    return views;
  }

  Widget _buildBodyRow(LotteryCode code) {
    List<Widget> views = [
      _buildLottoCell(code),
      ..._buildCodeOmit(code),
      ..._buildTailOmit(code),
      ..._build012Omit(code),
      ..._build147Omit(code),
      ..._build258Omit(code),
      ..._buildOeOmit(code),
      ..._buildBsOmit(code),
      ..._buildPcOmit(code),
    ];
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: views,
      ),
    );
  }

  List<Widget> _buildCodeOmit(LotteryCode code) {
    return List.generate(
        17,
        (index) => Container(
              width: code5Width,
              height: cell,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 0.4,
                    color: index >= 16 ? blackFont : greyBorder,
                  ),
                  bottom: BorderSide(
                    color: greyBorder,
                    width: 0.4,
                  ),
                ),
              ),
              child: code.positions.contains(index + 1)
                  ? Container(
                      width: 0.70 * code5Width,
                      height: 0.6 * cell,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: redFont,
                        borderRadius: BorderRadius.circular(cell),
                      ),
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                    )
                  : null,
            ));
  }

  Widget _buildHeader() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: _topController,
      child: SizedBox(
        height: cell * 2,
        child: Row(
          children: _buildHeaderCells(),
        ),
      ),
    );
  }

  List<Widget> _buildHeaderCells() {
    List<Widget> views = [];
    views.add(_lottoHeader());
    views.addAll(fiveCodes.entries
        .map((e) => _codeHeaderCell(
            code: e.value,
            index: e.key,
            color: e.key == 17 ? blackFont : greyBorder,
            width: 0.4))
        .toList());
    views.add(_groupHeader(
        '1-17组尾数', ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']));
    views.add(_groupHeader('尾数012路', ['0', '1', '2']));
    views.add(_groupHeader('尾数147路', ['1', '4', '7']));
    views.add(_groupHeader('尾数258路', ['2', '5', '8']));
    views.add(_groupHeader('奇偶', ['奇', '偶']));
    views.add(_groupHeader('大小', ['大', '小']));
    views.add(_groupHeader('质合', ['质', '合']));
    return views;
  }

  Widget _lottoHeader() {
    return Container(
      width: left,
      height: cell * 2,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          right: const BorderSide(color: blackFont, width: 0.4),
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

  Widget _codeHeaderCell(
      {required String code,
      required int index,
      required Color color,
      double width = 0.4}) {
    return SizedBox(
      width: code5Width,
      height: cell * 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: code5Width,
            height: cell,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: greyBorder, width: 0.4),
                right: BorderSide(color: color, width: width),
                bottom: const BorderSide(color: blackFont, width: 0.4),
              ),
            ),
            child: Text(
              code,
              style: TextStyle(color: blackFont, fontSize: 12.sp),
            ),
          ),
          Container(
            height: cell,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: color, width: width),
                bottom: BorderSide(color: greyBorder, width: 0.4),
              ),
            ),
            child: Text(
              '$index',
              style: TextStyle(color: blackFont, fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _groupHeader(String title, List<String> cells) {
    List<Widget> items = [];
    for (int i = 0; i < cells.length; i++) {
      items.add(Container(
        width: cell,
        height: cell,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: greyBorder, width: 0.4),
            right: BorderSide(
              width: 0.4,
              color: i < cells.length - 1 ? greyBorder : blackFont,
            ),
          ),
        ),
        child: Text(
          cells[i],
          style: TextStyle(color: blackFont, fontSize: 12.sp),
        ),
      ));
    }
    return SizedBox(
      width: cell * cells.length,
      height: cell * 2,
      child: Column(
        children: [
          Container(
            height: cell,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: const BorderSide(color: blackFont, width: 0.4),
                top: BorderSide(color: greyBorder, width: 0.4),
                bottom: const BorderSide(color: blackFont, width: 0.4),
              ),
            ),
            child: Text(
              title,
              style: TextStyle(color: blackFont, fontSize: 12.sp),
            ),
          ),
          Row(children: items),
        ],
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

  @override
  void initState() {
    _leftController = ScrollController();
    _topController = ScrollController();
    _bodyHController = ScrollController();
    _bodyVController = ScrollController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
        _leftController.animateTo(_leftController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500), curve: Curves.linear);
        _bodyVController.animateTo(_leftController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500), curve: Curves.linear);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _leftController.dispose();
    _topController.dispose();
    _bodyHController.dispose();
    _bodyVController.dispose();
  }
}
