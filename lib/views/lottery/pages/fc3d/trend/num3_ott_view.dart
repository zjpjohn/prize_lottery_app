import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_ott_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_omit.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_ott.dart';
import 'package:prize_lottery_app/views/lottery/model/slide_direction.dart';
import 'package:prize_lottery_app/views/lottery/utils/trend_constants.dart';
import 'package:prize_lottery_app/views/lottery/widgets/page_query_widget.dart';

class Num3OttView extends StatefulWidget {
  const Num3OttView({
    super.key,
    required this.type,
    required this.rows,
  });

  final String type;
  final int rows;

  @override
  State<Num3OttView> createState() => _Num3OttViewState();
}

class _Num3OttViewState extends State<Num3OttView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Get.put(LotteryOttController(widget.type));
    return Column(
      children: [
        SizedBox(
          height: widget.rows * trendCellSize + 0.5.w,
          child: RequestWidget<LotteryOttController>(
            init: LotteryOttController(widget.type),
            builder: (controller) {
              return OttOmitView(
                rows: widget.rows,
                ottList: controller.ottList,
              );
            },
          ),
        ),
        GetBuilder<LotteryOttController>(
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

class OttOmitView extends StatefulWidget {
  const OttOmitView({
    super.key,
    required this.rows,
    required this.ottList,
  });

  final int rows;
  final List<LotteryOtt> ottList;

  @override
  State<OttOmitView> createState() => _OttOmitViewState();
}

class _OttOmitViewState extends State<OttOmitView> {
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

  ///
  double cellWidth = trendCellSize;

  ///左侧宽度
  double left = trendLeftWidth;

  @override
  Widget build(BuildContext context) {
    ///屏幕尺寸
    double width = MediaQuery
        .of(context)
        .size
        .width;
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
                height: cell * (widget.rows - 2),
                child: Row(
                  children: [
                    _buildLeftContent(widget.ottList),
                    SizedBox(
                      width: width - left,
                      child: _buildBodyContent(widget.ottList),
                    )
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
        width: left + cellWidth * 15,
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
      _buildOttHeader('百位'),
      _buildOttHeader('十位'),
      _buildOttHeader('个位'),
    ];
  }

  Widget _buildOttHeader(String title) {
    return SizedBox(
      width: cellWidth * 5,
      height: cell * 2,
      child: Column(
        children: [
          Container(
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
              ...List.generate(
                3,
                    (index) =>
                    Container(
                      width: cellWidth,
                      height: cell,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: greyBorder, width: 0.4),
                          right: BorderSide(
                            color: greyBorder,
                            width: index == 2 ? 1.0 : 0.4,
                          ),
                        ),
                      ),
                      child: Text(
                        '$index',
                        style: TextStyle(color: blackFont, fontSize: 14.sp),
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

  Widget _buildLottoHeader() {
    return Container(
      width: left,
      height: cell * 2,
      alignment: Alignment.center,
      decoration: BoxDecoration(
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

  Widget _buildLeftContent(List<LotteryOtt> ottList) {
    return SingleChildScrollView(
      controller: _leftController,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: _leftContentCells(ottList),
      ),
    );
  }

  List<Widget> _leftContentCells(List<LotteryOtt> ottList) {
    List<Widget> views = [];
    for (int i = 0; i < ottList.length; i++) {
      LotteryOtt omit = ottList[i];
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

  Widget _buildBodyContent(List<LotteryOtt> ottList) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: _bodyHController,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _bodyVController,
        child: SizedBox(
          width: cellWidth * 15 + left,
          height: cell * ottList.length,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _bodyContentRows(ottList),
          ),
        ),
      ),
    );
  }

  List<Widget> _bodyContentRows(List<LotteryOtt> ottList) {
    List<Widget> views = [];
    for (int index = 0; index < ottList.length; index++) {
      views.add(
        Container(
          height: cell,
          color: index % 2 == 0
              ? Colors.white
              : Colors.grey.withValues(alpha: 0.05),
          child: _buildBodyRow(ottList[index]),
        ),
      );
    }
    return views;
  }

  Widget _buildBodyRow(LotteryOtt ott) {
    List<Widget> views = [
      _buildLottoCell(ott),
      ..._buildOttOmit(ott.bott),
      ..._buildOttOmit(ott.sott),
      ..._buildOttOmit(ott.gott),
    ];
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: views,
      ),
    );
  }

  Widget _buildLottoCell(LotteryOtt ott) {
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
        children: ott
            .balls()
            .map(
              (e) =>
              Padding(
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

  Color hitColor(bool hit, int index) {
    if (!hit) {
      return Colors.transparent;
    }
    if (index == 0) {
      return redFont;
    }
    if (index == 1) {
      return Colors.blueAccent;
    }
    return Colors.deepOrange;
  }

  List<Widget> _buildOttOmit(OmitValue omit) {
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
      ...List.generate(
        3,
            (index) =>
            Container(
              width: cellWidth,
              height: cell,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: hitColor(omit.key == index.toString(), index),
                border: Border(
                  bottom: BorderSide(color: greyBorder, width: 0.4),
                  right: BorderSide(color: greyBorder, width: 0.4),
                ),
              ),
              child: Text(
                omit.key == index.toString() ? '$index' : '',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: omit.key == index.toString()
                      ? Colors.white
                      : blackFont,
                ),
              ),
            ),
      ),
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
    super.initState();
    _leftController = ScrollController();
    _topController = ScrollController();
    _bodyHController = ScrollController();
    _bodyVController = ScrollController();
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
