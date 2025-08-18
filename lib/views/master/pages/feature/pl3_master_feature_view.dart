import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/master/controllers/feature/pl3_master_feature_controller.dart';
import 'package:prize_lottery_app/views/master/model/master_feature.dart';
import 'package:prize_lottery_app/views/master/widgets/rate_feature_chart.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class Pl3MasterFeatureView extends StatelessWidget {
  ///
  ///
  const Pl3MasterFeatureView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '专家画像',
      content: RequestWidget<Pl3MasterFeatureController>(
        builder: (controller) => _buildMasterFeature(controller),
      ),
    );
  }

  Widget _buildMasterFeature(Pl3MasterFeatureController controller) {
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

  Widget _buildRateFeature(Pl3MasterRate rate) {
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
            title: '三胆',
            level: rate.d3Level(),
            delta: rate.d3Delta(),
            rate: rate.dan3,
            average: rate.d3Avg,
            bottom: 4.w,
          ),
          RateFeatureChart(
            title: '五码',
            level: rate.c5Level(),
            delta: rate.c5Delta(),
            rate: rate.com5,
            average: rate.c5Avg,
            bottom: 4.w,
          ),
          RateFeatureChart(
            title: '六码',
            level: rate.c6Level(),
            delta: rate.c6Delta(),
            rate: rate.com6,
            average: rate.c6Avg,
            bottom: 4.w,
          ),
          RateFeatureChart(
            title: '七码',
            level: rate.c7Level(),
            delta: rate.c7Delta(),
            rate: rate.com7,
            average: rate.c7Avg,
            bottom: 4.w,
          ),
          RateFeatureChart(
            title: '杀一',
            level: rate.k1Level(),
            delta: rate.k1Delta(),
            rate: rate.kill1,
            average: rate.k1Avg,
            bottom: 4.w,
          ),
          RateFeatureChart(
            title: '杀二',
            level: rate.k2Level(),
            delta: rate.k2Delta(),
            rate: rate.kill2,
            average: rate.k2Avg,
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

  Widget _buildHitFeature(Pl3MasterFeatureController controller) {
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
        _cell(title: '五码', color: Colors.black, fontSize: 12),
        _cell(title: '六码', color: Colors.black, fontSize: 12),
        _cell(title: '七码', color: Colors.black, fontSize: 12),
        _cell(title: '杀一', color: Colors.black, fontSize: 12),
        _cell(title: '杀二', color: Colors.black, right: false, fontSize: 12),
      ],
    );
  }

  Widget _buildHitsView(List<Pl3ICaiHit> hits) {
    List<Widget> items = [];
    for (int i = 0; i < hits.length; i++) {
      Pl3ICaiHit hit = hits[i];
      items.add(
        Row(
          children: [
            _cell(title: hit.hitPeriod(), color: Colors.black, fontSize: 12),
            _hitCell(pair: hit.d3Hit(), bottom: i < hits.length - 1),
            _hitCell(pair: hit.c5Hit(), bottom: i < hits.length - 1),
            _hitCell(pair: hit.c6Hit(), bottom: i < hits.length - 1),
            _hitCell(pair: hit.c7Hit(), bottom: i < hits.length - 1),
            _hitCell(pair: hit.k1Hit(), bottom: i < hits.length - 1),
            _hitCell(
              pair: hit.k2Hit(),
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
