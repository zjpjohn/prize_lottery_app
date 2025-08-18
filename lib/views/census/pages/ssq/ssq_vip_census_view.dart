import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/widgets/fee_request_widget.dart';
import 'package:prize_lottery_app/resources/constants.dart';
import 'package:prize_lottery_app/views/census/controller/ssq/ssq_vip_census_controller.dart';
import 'package:prize_lottery_app/views/census/widgets/census_item_widget.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:prize_lottery_app/widgets/scrollable_tabs.dart';
import 'package:prize_lottery_app/widgets/tag_mark.dart';

class SsqVipCensusView extends StatelessWidget {
  ///
  ///
  const SsqVipCensusView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '综合分析',
      content: Container(
        color: const Color(0xFFF6F6FB),
        child: FeeCensusRequestWidget<SsqVipCensusController>(
          title: '查看双色球综合趋势分析',
          adsName: '综合趋势分析',
          header: (controller) => _buildTitleHeader(controller),
          description: (controller) => _buildDescription(),
          content: (controller) {
            return Column(
              children: [
                _buildLevelFilter(controller),
                _buildBlueTrendChart(controller),
                _buildRedTrendChart(controller),
              ],
            );
          },
          notice: (controller) => _buildNoticeView(),
        ),
      ),
    );
  }

  Widget _buildTitleHeader(SsqVipCensusController controller) {
    return Container(
      margin: EdgeInsets.only(top: 40.w, bottom: 20.w),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            '第${controller.period}期推荐综合分析',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8.w),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TagView(name: '#双色球'),
                TagView(name: '#综合分析'),
                TagView(name: '#汇总推荐'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      margin: EdgeInsets.only(bottom: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(
        '双色球综合分析通过对上一期预测推荐排名前10、20、50、100以及150的付费专家本期推荐方案'
        '进行分级分指标综合计算分析，计算出本期预测推荐在不同指标维度下综合推荐和杀码热度趋势。'
        '综合统计趋势非开奖日19、22点更新，开奖日当天15点开始更新，每小时更新一次直至19点结束。',
        style: TextStyle(
          height: 1.3,
          fontSize: 15.sp,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildLevelFilter(SsqVipCensusController controller) {
    List<MapEntry<int, String>> entries = vipLevels.entries.toList();
    return Container(
      padding: EdgeInsets.only(left: 16.w),
      margin: EdgeInsets.only(right: 16.w, top: 16.w),
      child: ScrollableTabs(
        length: entries.length,
        builder: (index) {
          var entry = entries[index];
          if (controller.level == entry.key) {
            return Container(
              height: 50.w,
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 10.w),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 14.w, right: 14.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF0045),
                  borderRadius: BorderRadius.only(
                    topLeft: index == 0 ? Radius.zero : Radius.circular(25.w),
                    bottomLeft:
                        index == 0 ? Radius.zero : Radius.circular(25.w),
                    topRight: index == entries.length - 1
                        ? Radius.zero
                        : Radius.circular(25.w),
                    bottomRight: index == entries.length - 1
                        ? Radius.zero
                        : Radius.circular(25.w),
                  ),
                ),
                child: Text(
                  '${entry.value}名',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }
          return Container(
            height: 50.w,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 8.w, right: 8.w),
            color: Colors.white,
            child: Text(
              '${entry.value}名',
              style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xBB000000),
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
        onSelected: (index) {
          controller.level = entries[index].key;
        },
      ),
    );
  }

  Widget _buildTrendHint(String channel) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 4.w),
            child: Text(
              '$channel热度趋势',
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                width: 160.w,
                alignment: Alignment.center,
                child: Text(
                  '推荐热度',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 13.sp,
                  ),
                ),
              ),
              SizedBox(width: 18.w),
              Container(
                width: 160.w,
                alignment: Alignment.center,
                child: Text(
                  '杀码热度',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRedTrendChart(SsqVipCensusController controller) {
    List<Widget> items = [];
    Map<String, List<int>> recCensus = controller.census.redRecCensus;
    Map<String, List<int>> killCensus = controller.census.redKillCensus;
    for (var entry in recCensus.entries) {
      items.add(CensusItemWidget(
        width: 160.w,
        height: 18.w,
        ballWidth: 18.w,
        fontSize: 11,
        recMax: controller.census.redRecMax,
        killMax: controller.census.redKillMax,
        ball: entry.key,
        recList: entry.value,
        killList: killCensus[entry.key]!,
      ));
      items.add(SizedBox(height: 6.w));
    }
    return Container(
      margin: EdgeInsets.only(top: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          _buildTrendHint('红球'),
          ...items,
          _buildLegendView(ssqRedLegends),
        ],
      ),
    );
  }

  Widget _buildBlueTrendChart(SsqVipCensusController controller) {
    List<Widget> items = [];
    Map<String, List<int>> recCensus = controller.census.blueRecCensus;
    Map<String, List<int>> killCensus = controller.census.blueKillCensus;
    for (var entry in recCensus.entries) {
      items.add(CensusItemWidget(
        width: 160.w,
        height: 18.w,
        ballWidth: 18.w,
        fontSize: 11,
        recMax: controller.census.blueRecMax,
        killMax: controller.census.blueKillMax,
        ball: entry.key,
        recList: entry.value,
        killList: killCensus[entry.key]!,
      ));
      items.add(SizedBox(height: 6.w));
    }
    return Container(
      margin: EdgeInsets.only(top: 12.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          _buildTrendHint('蓝球'),
          ...items,
          _buildLegendView(ssqBlueLegends),
        ],
      ),
    );
  }

  Widget _buildLegendView(Map<String, Color> legends) {
    return Padding(
      padding: EdgeInsets.only(top: 8.w, left: 8.w, right: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: legends.entries
            .map((e) => _chartLegend(hint: e.key, color: e.value))
            .toList(),
      ),
    );
  }

  Widget _chartLegend({required String hint, required Color color}) {
    return Row(
      children: [
        Container(
          width: 10.w,
          height: 10.w,
          color: color,
          margin: EdgeInsets.only(right: 4.w),
        ),
        Text(
          hint,
          style: TextStyle(
            color: Colors.black45,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  ///
  ///
  Widget _buildNoticeView() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 16.w, bottom: 24.w),
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '1、整体趋势指标包含三胆、12码、20码、25码、杀三码、杀六码、蓝球三码、蓝球五码以及蓝球杀码等，并进行选号统计分析。',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black45,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.w),
            child: Text(
              '2、其中三胆、12码、20码、25码的趋势表示红球号码选号推荐热度，杀三码、杀六码标识排除红球号码的热度，'
              '蓝球三码、篮球五码的趋势标识蓝球号码选号推荐热度，蓝球杀码标识排除蓝球号码的热度。',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black45,
              ),
            ),
          ),
          Text(
            '3、关于综合统计指标使用，需要您在使用过程中结合自身选号经验多观察、多总结，相信一定能为您带来意想不到的收获。',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}
