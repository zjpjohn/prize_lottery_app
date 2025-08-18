import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/master/controllers/feature/qlc_master_feature_controller.dart';
import 'package:prize_lottery_app/views/master/model/master_feature.dart';
import 'package:prize_lottery_app/views/master/widgets/rate_feature_chart.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class QlcMasterFeatureView extends StatelessWidget {
  ///
  ///
  const QlcMasterFeatureView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '专家画像',
      content: RequestWidget<QlcMasterFeatureController>(
        builder: (controller) => _buildMasterFeature(controller),
      ),
    );
  }

  Widget _buildMasterFeature(QlcMasterFeatureController controller) {
    return ScrollConfiguration(
      behavior: CustomScrollBehavior(),
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
          child: Column(
            children: [
              _buildRateFeature(controller.rate),
              _buildHitFeature(controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRateFeature(QlcMasterRate rate) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.w),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 12.w),
            child: Text(
              '专家命中率',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black,
              ),
            ),
          ),
          RateFeatureChart(
            title: '双胆',
            level: rate.r2Level(),
            delta: rate.r2Delta(),
            rate: rate.red2,
            average: rate.red2Avg,
            bottom: 4.w,
          ),
          RateFeatureChart(
            title: '三胆',
            level: rate.r3Level(),
            delta: rate.r3Delta(),
            rate: rate.red3,
            average: rate.red3Avg,
            bottom: 4.w,
          ),
          RateFeatureChart(
            title: '12码',
            level: rate.r12Level(),
            delta: rate.r12Delta(),
            rate: rate.red12,
            average: rate.red12Avg,
            bottom: 4.w,
          ),
          RateFeatureChart(
            title: '18码',
            level: rate.r18Level(),
            delta: rate.r18Delta(),
            rate: rate.red18,
            average: rate.red18Avg,
            bottom: 4.w,
          ),
          RateFeatureChart(
            title: '22码',
            level: rate.r22Level(),
            delta: rate.r22Delta(),
            rate: rate.red22,
            average: rate.red22Avg,
            bottom: 4.w,
          ),
          RateFeatureChart(
            title: '杀码',
            level: rate.k3Level(),
            delta: rate.k3Delta(),
            rate: rate.kill3,
            average: rate.kill3Avg,
            bottom: 12.w,
          ),
          Row(
            children: [
              _chartHint(hint: '真实命中率', color: Colors.blueAccent),
              _chartHint(hint: '平均命中率', color: const Color(0xFFF1F1F1))
            ],
          ),
        ],
      ),
    );
  }

  Widget _chartHint({required String hint, required Color color}) {
    return Padding(
      padding: EdgeInsets.only(right: 32.w),
      child: Row(
        children: [
          Container(
            width: 10.w,
            height: 10.w,
            color: color,
            margin: EdgeInsets.only(right: 6.w, top: 2.w),
          ),
          Text(
            hint,
            style: TextStyle(
              color: Colors.black26,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHitFeature(QlcMasterFeatureController controller) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(bottom: 12.w),
          child: Text(
            '专家近10期战绩',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          width: 337.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.w),
            border: Border.all(color: const Color(0xFFECECEC), width: 0.4.w),
          ),
          child: Column(
            children: [
              _buildHitHeader(),
              _buildHitsView(controller.hits),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHitHeader() {
    return Row(
      children: [
        _cell(title: '期号', color: Colors.black, fontSize: 12),
        _cell(title: '双胆', color: Colors.black, fontSize: 12),
        _cell(title: '三胆', color: Colors.black, fontSize: 12),
        _cell(title: '12码', color: Colors.black, fontSize: 12),
        _cell(title: '18码', color: Colors.black, fontSize: 12),
        _cell(title: '22码', color: Colors.black, fontSize: 12),
        _cell(title: '杀码', color: Colors.black, right: false, fontSize: 12),
      ],
    );
  }

  Widget _buildHitsView(List<QlcICaiHit> hits) {
    List<Widget> items = [];
    for (int i = 0; i < hits.length; i++) {
      QlcICaiHit hit = hits[i];
      items.add(
        Row(
          children: [
            _cell(title: hit.hitPeriod(), color: Colors.black, fontSize: 12),
            _hitCell(pair: hit.r2Hit(), bottom: i < hits.length - 1),
            _hitCell(pair: hit.r3Hit(), bottom: i < hits.length - 1),
            _hitCell(pair: hit.r12Hit(), bottom: i < hits.length - 1),
            _hitCell(pair: hit.r18Hit(), bottom: i < hits.length - 1),
            _hitCell(pair: hit.r22Hit(), bottom: i < hits.length - 1),
            _hitCell(
              pair: hit.k3Hit(),
              right: false,
              bottom: i < hits.length - 1,
            ),
          ],
        ),
      );
    }
    return Column(
      children: items,
    );
  }

  Widget _hitCell(
      {required HitPair pair, bool right = true, bool bottom = true}) {
    return _cell(
      title: pair.hit,
      color: pair.color,
      right: right,
      bottom: bottom,
    );
  }

  Widget _cell({
    required String title,
    required Color color,
    double fontSize = 11,
    bool right = true,
    bool bottom = true,
  }) {
    return Container(
      height: 28.w,
      width: 48.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border(
        right: right
            ? BorderSide(color: const Color(0xFFF1F1F1), width: 0.4.w)
            : BorderSide.none,
        bottom: bottom
            ? BorderSide(color: const Color(0xFFF1F1F1), width: 0.4.w)
            : BorderSide.none,
      )),
      child: Text(
        title,
        style: TextStyle(color: color, fontSize: fontSize.sp),
      ),
    );
  }
}
