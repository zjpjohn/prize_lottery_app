import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/env/env_profile.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/store/user.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/utils/date_util.dart';
import 'package:prize_lottery_app/utils/poster_util.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_palace_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/views/lottery/widgets/diamond_widget.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:prize_lottery_app/widgets/tag_mark.dart';

class LotteryPalaceView extends StatelessWidget {
  const LotteryPalaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '蜂巢选号图',
      content: Container(
        color: Colors.white,
        child: RequestWidget<LotteryPalaceController>(
          builder: (controller) {
            return Stack(
              children: [
                ScrollConfiguration(
                  behavior: CustomScrollBehavior(),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildHeaderView(controller),
                        _buildTableDescription(),
                        _buildLayoutContent(controller),
                        SizedBox(height: 16.w),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 16.w,
                  bottom: Get.height / 2 + 100.h,
                  child: _buildPeriodView(controller),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPeriodView(LotteryPalaceController controller) {
    return Container(
      width: 34.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.w),
        border: Border.all(color: Colors.black26, width: 0.3.w),
      ),
      padding: EdgeInsets.symmetric(vertical: 10.w),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (!controller.isFirst()) {
                controller.prevPeriod();
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Column(
              children: [
                Icon(
                  const IconData(0xe682, fontFamily: 'iconfont'),
                  size: 14.w,
                  color: controller.isFirst()
                      ? Colors.black26
                      : const Color(0xFFFF0033),
                ),
                Text(
                  '上期',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: controller.isFirst()
                        ? Colors.black26
                        : const Color(0xFFFF0033),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.3.w,
            width: 34.w,
            color: Colors.black26,
            margin: EdgeInsets.symmetric(vertical: 10.w),
          ),
          GestureDetector(
            onTap: () {
              if (!controller.isEnd()) {
                controller.nextPeriod();
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Column(
              children: [
                Text(
                  '下期',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: controller.isEnd()
                        ? Colors.black26
                        : const Color(0xFFFF0033),
                  ),
                ),
                Icon(
                  const IconData(0xe683, fontFamily: 'iconfont'),
                  size: 14.w,
                  color: controller.isEnd()
                      ? Colors.black26
                      : const Color(0xFFFF0033),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLayoutContent(LotteryPalaceController controller) {
    return GestureDetector(
      onLongPress: () {
        PosterUtils.saveLongWidget(() => _buildPosterWidget(controller));
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            _buildLotteryView(controller),
            _buildTableView(controller),
            _buildHelpView(),
          ],
        ),
      ),
    );
  }

  Widget _buildPosterWidget(LotteryPalaceController controller) {
    return Container(
      color: Colors.white,
      width: Get.width,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 24.w),
      child: Column(
        children: [
          _buildLotteryView(controller),
          _buildTableView(controller),
          _buildSharePosterQr(),
        ],
      ),
    );
  }

  Widget _buildSharePosterQr() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 16.w),
      child: Row(
        children: [
          SizedBox(
            width: 50.w,
            height: 50.w,
            child: PrettyQrView.data(
              data: UserStore().shareUri,
              errorCorrectLevel: QrErrorCorrectLevel.H,
              decoration: const PrettyQrDecoration(
                shape: PrettyQrSmoothSymbol(
                  roundFactor: 0.5,
                ),
                image: PrettyQrDecorationImage(
                  scale: 0.30,
                  image: AssetImage(R.logo),
                ),
              ),
            ),
          ),
          Container(
            height: 50.w,
            margin: EdgeInsets.only(left: 12.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Profile.props.appName,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '扫码下载APP获取更多精彩内容',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableView(LotteryPalaceController controller) {
    List<Widget> views = [];
    for (int i = 0; i < controller.cells.length; i++) {
      views.add(_buildRows(i, controller.cells[i]));
    }
    return RepaintBoundary(
      child: SizedBox(
        width: 21.4.w * 16,
        height: _calcTableHeight(controller),
        child: Stack(
          children: views,
        ),
      ),
    );
  }

  double _calcTableHeight(LotteryPalaceController controller) {
    return (controller.cells.length - 1) * (27.w - 10.7.w * tan(pi / 6)) + 27.w;
  }

  Widget _buildRows(int index, List<Cell> rows) {
    double left = index % 2 == 1 ? 0 : 10.7.w;
    double top = index * (27.w - 10.7.w * tan(pi / 6));
    return Positioned(
      left: left,
      top: top,
      child: Row(
        children: rows
            .map((e) => DiamondWidget(
                  width: 21.4.w,
                  height: 27.w,
                  border: isBorder(e) ? 1.w : 0.w,
                  margin: 1.2.w,
                  borderColor: Colors.black.withValues(alpha: 0.08),
                  color: _background(e),
                  child: Text(
                    '${e.key}',
                    style: TextStyle(
                      color: _textColor(e),
                      fontSize: 16.sp,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildHeaderView(LotteryPalaceController controller) {
    return Container(
      margin: EdgeInsets.only(top: 20.w, bottom: 8.w),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            '第${controller.lotteries[0].period}期${lotteryZhCns[controller.type]!}蜂巢选号图',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TagView(name: '#${lotteryZhCns[controller.type]!}'),
                const TagView(name: '#秘制图表'),
                const TagView(name: '#实用工具'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableDescription() {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.w),
      child: Text(
        '蜂巢选号图是专门为选三型彩票设计的一款选号参考工具。在上一期开奖号码中找到临近数字，'
        '以其中一个数字为轴，找到下一期三个临近数字，即有可能为当期的开奖号码。具体使用请根据过去开奖数据进行验证总结，找到选号规律做出判断。'
        '用户可长按选号图表，将本图表保存至本地更方便地查看。',
        style: TextStyle(
          fontSize: 15.sp,
          color: Colors.black,
          height: 1.3,
        ),
      ),
    );
  }

  Widget _buildHelpView() {
    return Container(
      padding:
          EdgeInsets.only(left: 16.w, right: 16.w, top: 12.w, bottom: 24.w),
      child: Text(
        '一般情况，今日开奖号码很大可能在昨天开奖号码附近；'
        '尽可能地在昨日开奖号码附近寻找今日的开奖号码，'
        '同时参考今日的试机号，尽可能的缩小选号范围。准确使用该图表，'
        '需要不断观察，不断总结经验。',
        style: TextStyle(
          color: Colors.black38,
          fontSize: 12.sp,
        ),
      ),
    );
  }

  Widget _buildLotteryView(LotteryPalaceController controller) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 16.w),
          child: _buildLotteryInfo(controller.lotteries[0]),
        ),
        _buildLotteryBall(
          controller.lotteries[0],
          current: Colors.pinkAccent,
        ),
        Container(
          child: _buildLotteryInfo(controller.lotteries[1]),
        ),
        _buildLotteryBall(
          controller.lotteries[1],
          current: const Color(0xff168c8c),
        ),
        Container(
          child: _buildLotteryInfo(controller.lotteries[2]),
        ),
        _buildLotteryBall(
          controller.lotteries[2],
          current: const Color(0xff68ac7a),
        ),
      ],
    );
  }

  Widget _buildLotteryInfo(LotteryInfo lottery) {
    return Container(
      padding: EdgeInsets.only(left: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 3.w,
                height: 10.w,
                margin: EdgeInsets.only(right: 8.w, bottom: 1.w),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(3.w),
                ),
              ),
              Text(
                '${lottery.period}期',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 6.w, bottom: 2.w),
            child: Text(
              lottery.lotDate.isEmpty
                  ? ''
                  : DateUtil.formatDate(
                      DateUtil.parse(
                        lottery.lotDate,
                        pattern: "yyyy/MM/dd",
                      ),
                      format: 'yy.MM.dd',
                    ),
              style: TextStyle(
                color: Colors.black38,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLotteryBall(LotteryInfo lottery, {required Color current}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
      child: Row(
        mainAxisAlignment: lottery.shi.isNotEmpty
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: _lotteryTxt(
                reds: lottery.redBalls(),
                color: current,
                title: '开奖号',
              ),
            ),
          ),
          lottery.shi.isNotEmpty
              ? Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: _lotteryTxt(
                      reds: lottery.shiBalls(),
                      color: const Color(0xFFC7EDCC),
                      font: const Color(0xff168c8c),
                      title: '试机号',
                    ),
                  ),
                )
              : const Offstage(offstage: true),
        ],
      ),
    );
  }

  List<Widget> _lotteryTxt({
    required List<String> reds,
    required Color color,
    required String title,
    Color font = Colors.white,
  }) {
    List<Widget> views = [
      Padding(
        padding: EdgeInsets.only(right: 8.w, top: 2.w),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.black45,
          ),
        ),
      ),
    ];
    for (var ball in reds) {
      views.add(
        Container(
          width: 24.w,
          height: 24.w,
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 8.w),
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20.w),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.18),
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                ),
                BoxShadow(
                  color: color.withValues(alpha: 0.18),
                  offset: const Offset(0, -1),
                  blurRadius: 2,
                ),
                BoxShadow(
                  color: color.withValues(alpha: 0.18),
                  offset: const Offset(1, 0),
                  blurRadius: 2,
                ),
                BoxShadow(
                  color: color.withValues(alpha: 0.18),
                  offset: const Offset(-1, 0),
                  blurRadius: 2,
                ),
              ]),
          child: Padding(
            padding: EdgeInsets.only(bottom: 2.w),
            child: Text(
              ball,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'bebas',
                color: font,
              ),
            ),
          ),
        ),
      );
    }
    return views;
  }

  Color _textColor(Cell cell) {
    if (cell.current || cell.last || cell.before) {
      return Colors.white;
    }
    if (cell.currentShi) {
      return const Color(0xff168c8c);
    }
    return Colors.brown;
  }

  bool isBorder(Cell cell) {
    if (cell.current || cell.last || cell.before) {
      return false;
    }
    return true;
  }

  Color _background(Cell cell) {
    if (cell.current) {
      return Colors.pinkAccent;
    }
    if (cell.last) {
      return const Color(0xff168c8c);
    }
    if (cell.before) {
      return const Color(0xff68ac7a);
    }
    if (cell.currentShi) {
      return const Color(0xFFC7EDCC);
    }
    return cellColors[cell.key % 3];
  }
}
