import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/widgets/fee_request_widget.dart';
import 'package:prize_lottery_app/resources/constants.dart';
import 'package:prize_lottery_app/views/census/controller/fc3d/fc3d_vip_census_controller.dart';
import 'package:prize_lottery_app/views/census/widgets/census_item_widget.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:prize_lottery_app/widgets/scrollable_tabs.dart';
import 'package:prize_lottery_app/widgets/tag_mark.dart';

class Fc3dVipCensusView extends StatelessWidget {
  ///
  ///
  const Fc3dVipCensusView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '综合分析',
      content: Container(
        color: const Color(0xFFF6F6FB),
        child: FeeCensusRequestWidget<Fc3dVipCensusController>(
          title: '查看最新号码热度综合趋势',
          adsName: '综合预测分析',
          header: (controller) => _buildTitleHeader(controller),
          description: (controller) => _buildDescription(),
          content: (controller) {
            return Column(
              children: [
                _buildLevelFilter(controller),
                _buildTrendChart(controller),
              ],
            );
          },
          notice: (controller) => _buildNoticeView(),
        ),
      ),
    );
  }

  Widget _buildTitleHeader(Fc3dVipCensusController controller) {
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
                TagView(name: '#福彩3D'),
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
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Text(
        '福彩3D综合分析通过对上一期预测推荐排名前10、20、50、100以及150的付费专家本期推荐方案'
        '进行分级分指标汇总计算分析，计算出本期预测推荐在不同指标下综合推荐和杀码热度趋势。'
        '综合统计趋势每天下午16:20开始更新当期统计，并且每小时更新一次直到到19点结束。',
        style: TextStyle(
          height: 1.3,
          fontSize: 15.sp,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildLevelFilter(Fc3dVipCensusController controller) {
    List<MapEntry<String, String>> entries = n3Channels.entries.toList();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      margin: EdgeInsets.only(top: 16.w),
      child: ScrollableTabs(
        length: entries.length,
        builder: (index) {
          var entry = entries[index];
          if (controller.channel == entry.key) {
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
                  entry.value,
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
              entry.value,
              style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xBB000000),
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
        onSelected: (index) {
          controller.channel = entries[index].key;
        },
      ),
    );
  }

  Widget _buildTrendHint() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 8.w, bottom: 12.w),
      child: Text(
        '选号热度趋势',
        style: TextStyle(
          fontSize: 15.sp,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTrendChart(Fc3dVipCensusController controller) {
    List<Widget> items = [];
    Map<String, List<int>> census = controller.chart.census;
    for (var entry in census.entries) {
      items.add(SyntheticItemWidget(
        width: 320.w,
        height: 22.w,
        ballWidth: 18.w,
        max: controller.chart.maxValue,
        ball: entry.key,
        census: census[entry.key]!,
      ));
      items.add(SizedBox(height: 12.w));
    }
    return Container(
      margin: EdgeInsets.only(top: 12.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          _buildTrendHint(),
          ...items,
          _buildLegendView(controller),
        ],
      ),
    );
  }

  Widget _buildLegendView(Fc3dVipCensusController controller) {
    return Padding(
      padding: EdgeInsets.only(top: 8.w, left: 8.w, right: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: levelLegends.map((e) => _chartLegend(e, controller)).toList(),
      ),
    );
  }

  Widget _chartLegend(ChartLegend legend, Fc3dVipCensusController controller) {
    return GestureDetector(
      onTap: () {
        controller.level = legend.level;
      },
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Container(
            width: 10.w,
            height: 10.w,
            color: legend.level <= controller.level
                ? legend.color
                : Colors.black12,
            margin: EdgeInsets.only(right: 4.w),
          ),
          Text(
            legend.name,
            style: TextStyle(
              color: Colors.black45,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  ///
  ///
  Widget _buildNoticeView() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 16.w, bottom: 32.w),
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '1、综合趋势分析指标主要包含：三胆、五码、六码、七码、杀一码、杀二码等，并进行选号热度统计分析。',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black45,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.w),
            child: Text(
              '2、其中三胆、五码、六码、七码的趋势表示号码选号推荐热度，杀一码、杀二码标识排除号码的热度。',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black45,
              ),
            ),
          ),
          Text(
            '3、关于综合趋势分析指标使用，需要您在使用过程中结合自己的经验多观察、多总结，相信一定能为您带来意想不到的收获。',
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
