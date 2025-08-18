import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/model/forecast_value.dart';
import 'package:prize_lottery_app/base/model/master_value.dart';
import 'package:prize_lottery_app/base/model/stat_hit_value.dart';
import 'package:prize_lottery_app/utils/tools.dart';

///
/// 今日重点信息
class TodayPivot {
  late String period;
  ForecastValue? best;
  ForecastValue? second;
  ForecastValue? quality;
  int? edits;
  int? browse;
  String? calcTime;
  String? gmtModify;
  List<PivotMaster> masters = [];

  TodayPivot({required this.period});

  TodayPivot.fromJson(Map<String, dynamic> json) {
    period = json['period'] ?? '';
    edits = json['edits'] ?? 0;
    calcTime = json['calcTime'];
    gmtModify = json['gmtModify'];
    browse = Tools.randLimit(json['browse'] ?? 0, 1000);
    if (json['best'] != null) {
      best = ForecastValue.fromJson(json['best']);
      _calcPivotHit(best!);
    }
    if (json['second'] != null) {
      second = ForecastValue.fromJson(json['second']);
      _calcPivotHit(second!);
    }
    if (json['quality'] != null) {
      quality = ForecastValue.fromJson(json['quality']);
      _calcPivotHit(quality!);
    }
    if (json['masters'] != null) {
      masters = (json['masters'] as List)
          .map((e) => PivotMaster.fromJson(e))
          .toList();
    }
  }

  ForecastValue mockBest() {
    var best = ForecastValue.mock('3');
    _calcPivotHit(best);
    return best;
  }

  ForecastValue mockSecond() {
    var second = ForecastValue.mock('6');
    _calcPivotHit(second);
    return second;
  }

  ForecastValue mockQuality() {
    var quality = ForecastValue.mock('2 4 7 8');
    _calcPivotHit(quality);
    return quality;
  }

  List<PivotMaster> mockMasters() {
    return [
      PivotMaster.mock(
        '1271933097490776156',
        '旧时微风拂旧城',
        'https://image.icaiwa.com/avatar/face2698.png',
        3,
      ),
      PivotMaster.mock(
        '1271933097490800732',
        '╱★勾画你残缺的愛',
        'https://image.icaiwa.com/avatar/face2806.png',
        12,
      ),
      PivotMaster.mock(
        '1271933097515950172',
        '落笔画忧愁﹌',
        'https://image.icaiwa.com/avatar/face1770.png',
        20,
      ),
      PivotMaster.mock(
        '1271933097524355164',
        '塔里以南,木河以北',
        'https://image.icaiwa.com/avatar/face1206.png',
        32,
      ),
    ];
  }

  void _calcPivotHit(ForecastValue value) {
    if (value.hitData.isNotEmpty) {
      value.hitValues = Tools.segParse(value.hitData);
      value.opened = 1;
      return;
    }
    value.values = Tools.split(value.data);
  }

  List<Widget> pivotWidget(ForecastValue value) {
    if (value.opened == 1) {
      return value.hitValues
          .map((e) => Container(
                margin: EdgeInsets.only(right: 16.w),
                child: Text(
                  e.k,
                  style: TextStyle(
                    color: e.v == 0 ? Colors.black : const Color(0xFFFF0033),
                    fontSize: 18.sp,
                    fontFamily: 'bebas',
                  ),
                ),
              ))
          .toList();
    }
    return value.values
        .map((e) => Container(
              margin: EdgeInsets.only(right: 16.w),
              child: Text(
                e,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontFamily: 'bebas',
                ),
              ),
            ))
        .toList();
  }
}

///
/// 重点专家信息
class PivotMaster {
  late MasterValue master;
  late StatHitValue hit;
  late int rank;

  PivotMaster.fromJson(Map<String, dynamic> json) {
    master = MasterValue.fromJson(json['master']);
    hit = StatHitValue.fromJson(json['hit']);
    rank = json['rank'] ?? 1;
  }

  PivotMaster.mock(String masterId, String name, String avatar, int mRank) {
    master = MasterValue(masterId, name, avatar);
    hit = StatHitValue(13, 0.95, 0.70, '15中14');
    rank = mRank;
  }
}
