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
import 'package:prize_lottery_app/utils/quick_table.dart';
import 'package:prize_lottery_app/views/lottery/controller/hunt_table_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:prize_lottery_app/widgets/tag_mark.dart';

class HuntTableView extends StatelessWidget {
  const HuntTableView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '选号寻宝',
      content: Container(
        color: Colors.white,
        child: RequestWidget<HuntTableController>(
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
                  bottom: Get.height / 2 + 166.h,
                  child: _buildPeriodView(controller),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeaderView(HuntTableController controller) {
    return Container(
      margin: EdgeInsets.only(top: 20.w, bottom: 8.w),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            '第${controller.huntTable.current.period}期${lotteryZhCns[controller.type]!}寻宝图',
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
                const TagView(name: '#寻宝选号'),
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
        '寻宝图是专为选三型彩票提供的一种选号参考工具。首先在表中找到上期开奖号码，最佳位置就是三个号码的最直线或者三角排列；'
        '然后结合本期试机号进行精细定位，重点考虑周围的号码进行组号。本表可根据自身选号经验，探索更多灵活使用技巧。'
        '寻宝图每天下午17:00左右试机号更新完成后会显示最新一期的数据。用户可长按选号图表，将本图表保存至本地更方便地查看。',
        style: TextStyle(
          fontSize: 15.sp,
          color: Colors.black,
          height: 1.3,
        ),
      ),
    );
  }

  Widget _buildPeriodView(HuntTableController controller) {
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

  Widget _buildLayoutContent(HuntTableController controller) {
    return GestureDetector(
      onLongPress: () {
        PosterUtils.saveWidget(() => _buildPosterWidget(controller));
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            _buildLotteryView(controller),
            _buildHuntTable(controller),
            _buildHelpView(),
          ],
        ),
      ),
    );
  }

  Widget _buildPosterWidget(HuntTableController controller) {
    return Container(
      color: Colors.white,
      width: Get.width,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 24.w),
      child: Column(
        children: [
          _buildLotteryView(controller),
          _buildHuntTable(controller),
          _buildSharePosterQr(),
        ],
      ),
    );
  }

  Widget _buildLotteryView(HuntTableController controller) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 20.w),
          child: _buildLotteryInfo(controller.huntTable.current),
        ),
        _buildLotteryBall(
          controller.huntTable.current,
          current: Colors.pinkAccent,
        ),
        _buildHistoryTitle(),
        Padding(
          padding: EdgeInsets.only(
            left: 24.w,
            right: 16.w,
            top: 8.w,
            bottom: 16.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _lotteryBall(
                controller.huntTable.last,
                font: Colors.white,
                color: const Color(0xff168c8c),
              ),
              _lotteryBall(
                controller.huntTable.before,
                font: Colors.white,
                color: const Color(0xff68ac7a),
              ),
              _lotteryBall(
                controller.huntTable.lastBefore,
                font: const Color(0xff168c8c),
                color: const Color(0xffB1D9C4),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHuntTable(HuntTableController controller) {
    List<TableRow> rows = [];
    List<List<RenderCell>> renders = controller.huntTable.treasureTable;
    for (int i = 0; i < renders.length; i++) {
      List<RenderCell> row = renders[i];
      List<Widget> cells = [];
      for (int j = 0; j < row.length; j++) {
        RenderCell render = row[j];
        Widget cell = Container(
          height: 31.w,
          alignment: Alignment.center,
          child: Container(
            height: 28.w,
            width: 28.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: render.color,
              borderRadius: BorderRadius.circular(1.5.w),
              boxShadow: render.font == Colors.white
                  ? [
                      if (j < row.length - 1)
                        BoxShadow(
                          color: render.color.withValues(alpha: 0.2),
                          offset: const Offset(0, 1),
                          blurRadius: 2,
                        ),
                      if (j > 0)
                        BoxShadow(
                          color: render.color.withValues(alpha: 0.2),
                          offset: const Offset(0, -1),
                          blurRadius: 2,
                        ),
                      if (i > 0)
                        BoxShadow(
                          color: render.color.withValues(alpha: 0.2),
                          offset: const Offset(-1, 0),
                          blurRadius: 2,
                        ),
                      if (i < renders.length - 1)
                        BoxShadow(
                          color: render.color.withValues(alpha: 0.2),
                          offset: const Offset(1, 0),
                          blurRadius: 2,
                        ),
                    ]
                  : [],
            ),
            child: Text(
              render.key,
              style: TextStyle(
                color: render.font,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
        cells.add(cell);
      }
      TableRow tableRow = TableRow(children: cells);
      rows.add(tableRow);
    }
    return RepaintBoundary(
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.w),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 14.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFF6F6F6),
            borderRadius: BorderRadius.circular(3.w),
            border: Border.all(width: 3.w, color: const Color(0xFFF6F6F6)),
          ),
          child: Table(
            defaultColumnWidth: FixedColumnWidth(31.w),
            children: rows,
          ),
        ),
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

  Widget _buildHelpView() {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 24.w),
      child: Text(
        '一般情况，今日开奖号码很大可能在昨天开奖号码附近；'
        '尽可能地在昨日开奖号码周围寻找今日的开奖号码，'
        '同时参考今日的试机号，尽可能的缩小选号范围。'
        '准确使用寻宝图，需要不断观察，不断总结经验。',
        style: TextStyle(
          color: Colors.black38,
          fontSize: 12.sp,
        ),
      ),
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
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.w),
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

  Widget _buildHistoryTitle() {
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
                '往期开奖',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _lotteryBall(LotteryInfo lottery,
      {required Color font, required Color color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 4.w),
          child: Text(
            '${lottery.period}期',
            style: TextStyle(
              color: Colors.black45,
              fontSize: 13.sp,
            ),
          ),
        ),
        Row(
          children: lottery
              .redBalls()
              .map((ball) => Container(
                    width: 22.w,
                    height: 22.w,
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
                          fontSize: 13.sp,
                          fontFamily: 'bebas',
                          color: font,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
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
          width: 26.w,
          height: 26.w,
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 8.w),
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20.w),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.2),
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                ),
                BoxShadow(
                  color: color.withValues(alpha: 0.2),
                  offset: const Offset(0, -1),
                  blurRadius: 2,
                ),
                BoxShadow(
                  color: color.withValues(alpha: 0.2),
                  offset: const Offset(1, 0),
                  blurRadius: 2,
                ),
                BoxShadow(
                  color: color.withValues(alpha: 0.2),
                  offset: const Offset(-1, 0),
                  blurRadius: 2,
                ),
              ]),
          child: Padding(
            padding: EdgeInsets.only(bottom: 2.w),
            child: Text(
              ball,
              style: TextStyle(
                fontSize: 14.5.sp,
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
}
