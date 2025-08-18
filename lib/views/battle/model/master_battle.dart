import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/model/forecast_value.dart';
import 'package:prize_lottery_app/base/model/master_value.dart';

final List<String> titles = ['百位', '十位', '各位'];

typedef Converter<T> = T Function(Map<String, dynamic> json);

typedef Extractor<T> = ForecastValue Function(T forecast);

class MasterBattle<T> {
  ///对战标识
  late int id;

  ///用户标识
  late int userId;

  ///专家信息
  late MasterValue master;

  ///预测期号
  late String period;

  ///预测信息
  late T forecast;

  MasterBattle.fromJson(Map<String, dynamic> json,
      {required Converter<T> convert}) {
    id = int.parse(json['id']);
    userId = int.parse(json['userId']);
    master = MasterValue.fromJson(json['master']);
    period = json['period'];
    forecast = convert.call(json['forecast']);
  }
}

class MasterBattleRank<T> {
  ///是否已在对战列表中
  int? battled;

  ///是否已浏览
  late int browsed;

  ///专家排名信息
  late T masterRank;

  MasterBattleRank.fromJson(Map<String, dynamic> json,
      {required Converter<T> convert}) {
    battled = json['battled'];
    browsed = json['browsed'];
    masterRank = convert(json['masterRank']);
  }
}

class BattleCensus {
  List<String> max = [];
  List<String> min = [];

  BattleCensus({
    this.max = const [],
    this.min = const [],
  });

  List<Widget> view(List<String> census) {
    return census
        .map((e) => Container(
              margin: EdgeInsets.only(right: 6.w),
              child: Text(
                e,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                ),
              ),
            ))
        .toList();
  }
}

class BattleSegCensus {
  List<List<String>> max = [];
  List<List<String>> min = [];

  BattleSegCensus({
    this.max = const [],
    this.min = const [],
  });

  List<Widget> view(List<List<String>> census) {
    List<Widget> views = [];
    for (var i = 0; i < titles.length; i++) {
      views.add(_itemView(titles[i], census[i]));
    }
    return views;
  }

  Widget _itemView(String title, List<String> items) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 6.w),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black45,
              fontSize: 12.sp,
              height: 1.25,
            ),
          ),
        ),
        ...items.map((e) => Container(
              margin: EdgeInsets.only(right: 6.w),
              child: Text(
                e,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                ),
              ),
            )),
      ],
    );
  }
}
