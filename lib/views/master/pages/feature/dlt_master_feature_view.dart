import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/master/controllers/feature/dlt_master_feature_controller.dart';
import 'package:prize_lottery_app/views/master/model/master_feature.dart';
import 'package:prize_lottery_app/views/master/widgets/rate_feature_chart.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class DltMasterFeatureView extends StatelessWidget {
  ///
  ///
  const DltMasterFeatureView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '专家画像',
      content: RequestWidget<DltMasterFeatureController>(
        builder: (controller) => _buildMasterFeature(controller),
      ),
    );
  }

  Widget _buildMasterFeature(DltMasterFeatureController controller) {
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

  Widget _buildRateFeature(DltMasterRate rate) {
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
            title: '红球三胆',
            level: rate.r3Level(),
            delta: rate.r3Delta(),
            rate: rate.red3,
            average: rate.red3Avg,
            bottom: 4.w,
            width: 230,
          ),
          RateFeatureChart(
            title: '红球10码',
            level: rate.r10Level(),
            delta: rate.r10Delta(),
            rate: rate.red10,
            average: rate.red10Avg,
            bottom: 4.w,
            width: 230,
          ),
          RateFeatureChart(
            title: '红球20码',
            level: rate.r20Level(),
            delta: rate.r20Delta(),
            rate: rate.red20,
            average: rate.red20Avg,
            bottom: 4.w,
            width: 230,
          ),
          RateFeatureChart(
            title: '红球杀码',
            level: rate.rk3Level(),
            delta: rate.rk3Delta(),
            rate: rate.rk3,
            average: rate.rk3Avg,
            bottom: 4.w,
            width: 230,
          ),
          RateFeatureChart(
            title: '蓝球六码',
            level: rate.b6Level(),
            delta: rate.b6Delta(),
            rate: rate.blue6,
            average: rate.blue6Avg,
            bottom: 4.w,
            width: 230,
          ),
          RateFeatureChart(
            title: '蓝球杀码',
            level: rate.bkLevel(),
            delta: rate.bkDelta(),
            rate: rate.bk,
            average: rate.bkAvg,
            bottom: 12.w,
            width: 230,
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

  Widget _buildHitFeature(DltMasterFeatureController controller) {
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
        _cell(title: '三胆', color: Colors.black, fontSize: 12),
        _cell(title: '10码', color: Colors.black, fontSize: 12),
        _cell(title: '20码', color: Colors.black, fontSize: 12),
        _cell(title: '杀红', color: Colors.black, fontSize: 12),
        _cell(title: '蓝六', color: Colors.black, fontSize: 12),
        _cell(title: '杀蓝', color: Colors.black, right: false, fontSize: 12),
      ],
    );
  }

  Widget _buildHitsView(List<DltICaiHit> hits) {
    List<Widget> items = [];
    for (int i = 0; i < hits.length; i++) {
      DltICaiHit hit = hits[i];
      items.add(
        Row(
          children: [
            _cell(title: hit.hitPeriod(), color: Colors.black, fontSize: 12),
            _hitCell(pair: hit.r3Hit(), bottom: i < hits.length - 1),
            _hitCell(pair: hit.r10Hit(), bottom: i < hits.length - 1),
            _hitCell(pair: hit.r20Hit(), bottom: i < hits.length - 1),
            _hitCell(pair: hit.rk3Hit(), bottom: i < hits.length - 1),
            _hitCell(pair: hit.b6Hit(), bottom: i < hits.length - 1),
            _hitCell(
              pair: hit.bkHit(),
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
