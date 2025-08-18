import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/widgets/fee_request_widget.dart';
import 'package:prize_lottery_app/views/census/controller/pl3/pl3_rate_census_controller.dart';
import 'package:prize_lottery_app/views/census/widgets/census_item_widget.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:prize_lottery_app/widgets/tag_mark.dart';

class Pl3RateCensusView extends StatelessWidget {
  ///
  ///
  const Pl3RateCensusView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '牛人汇总',
      content: Container(
          color: const Color(0xFFF6F6FB),
          child: FeeCensusRequestWidget<Pl3RateCensusController>(
            title: '查看最新推荐牛人预测汇总分析',
            adsName: '牛人汇总分析',
            header: (controller) => _buildTitleHeader(controller),
            description: (controller) => _buildDescription(),
            content: (controller) => _buildTrendChart(controller),
            notice: (controller) => _buildNoticeView(),
          )),
    );
  }

  Widget _buildTitleHeader(Pl3RateCensusController controller) {
    return Container(
      margin: EdgeInsets.only(top: 40.w, bottom: 20.w),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            '第${controller.period}期牛人汇总分析',
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
                TagView(name: '#排列三'),
                TagView(name: '#牛人专家'),
                TagView(name: '#汇总分析'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      margin: EdgeInsets.only(bottom: 12.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(
        '排列三牛人汇总通过对“最近15、30期推荐综合命中率最高的牛人专家”本期推荐方案'
        '进行分指标汇总计算分析，计算出本期牛人专家预测推荐在不同指标维度下的推荐热度和杀码热度趋势。'
        '牛人统计趋势每天下午16:20开始更新当期统计，并且每小时更新一次直到到19点结束。',
        style: TextStyle(
          height: 1.3,
          fontSize: 15.sp,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildTrendHint() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 4.w),
            child: Text(
              '选号热度趋势',
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

  Widget _buildTrendChart(Pl3RateCensusController controller) {
    List<Widget> items = [];
    Map<String, List<int>> recCensus = controller.census.recCensus;
    Map<String, List<int>> killCensus = controller.census.killCensus;
    for (var entry in recCensus.entries) {
      items.add(CensusItemWidget(
        width: 160.w,
        height: 22.w,
        ballWidth: 18.w,
        recMax: controller.census.recMax,
        killMax: controller.census.killMax,
        ball: entry.key,
        recList: entry.value,
        killList: killCensus[entry.key]!,
      ));
      items.add(SizedBox(height: 12.w));
    }
    return Container(
      margin: EdgeInsets.only(top: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          _buildTrendHint(),
          ...items,
          _buildLegendView(),
        ],
      ),
    );
  }

  Widget _buildLegendView() {
    return Padding(
      padding: EdgeInsets.only(top: 4.w, left: 8.w, right: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: n3Legends.entries
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

  Widget _buildNoticeView() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 16.w, bottom: 32.w),
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '1、牛人趋势分析指标主要包含：三胆、五码、六码、七码、杀一码、杀二码等，并进行选号热度统计分析。',
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
            '3、关于牛人趋势分析指标使用，需要您在使用过程中结合自己的经验多观察、多总结，相信一定能为您带来意想不到的收获。',
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
