import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/utils/tools.dart';

class ForecastValue {
  ///
  late String data;

  ///
  List<String> values = [];

  ///
  int opened = 0;

  ///
  late String hitData;

  ///
  List<Model> hitValues = [];

  ///
  late int dataHit;

  ///是否为定位
  bool isDing = false;

  ForecastValue.fromJson(Map<String, dynamic> json) {
    data = json['data'] ?? '';
    hitData = json['hitData'] ?? '';
    dataHit = json['dataHit'] ?? 0;
  }

  ForecastValue.mock(String value) {
    data = value;
    hitData = '';
    dataHit = 0;
  }

  ///
  /// 非定位选码使用
  List<Model> battle() {
    if (opened == 0) {
      return values.map((e) => Model(k: e, v: 1)).toList();
    }
    return hitValues.map((e) => Model(k: e.k, v: 1)).toList();
  }

  ///
  ///
  /// 仅对选三定位使用
  List<List<Model>> segBattle() {
    if (opened == 1) {
      return split(hitValues, (e) => e.k == '*');
    }
    List<List<String>> splits = split(values, (e) => e == '*');
    return splits.map((e) => e.map((e) => Model(k: e, v: 1)).toList()).toList();
  }

  void calcValue() {
    if (hitData.isNotEmpty) {
      opened = 1;
      hitValues = Tools.parse(hitData);
      isDing = hitValues.any((e) => e.k == '*');
    } else {
      values = Tools.segSplit(data);
      isDing = values.contains('*');
    }
  }

  List<Widget> posterViews() {
    if (opened == 1) {
      return hitValues
          .map((e) => Container(
                margin: EdgeInsets.only(right: 4.w, top: 2.w),
                child: Text(
                  e.k,
                  style: TextStyle(
                    color: e.v == 0
                        ? const Color(0xCC000000)
                        : const Color(0xFF2254F4),
                    fontSize: 12.sp,
                    fontFamily: 'bebas',
                    height: e.k == '*' ? 1.25 : 1,
                  ),
                ),
              ))
          .toList();
    }
    return values
        .map((e) => Container(
              margin: EdgeInsets.only(right: 4.w, top: 2.w),
              child: Text(
                e,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 12.sp,
                  fontFamily: 'bebas',
                  height: e == '*' ? 1.25 : 1,
                ),
              ),
            ))
        .toList();
  }

  List<Widget> dataViews() {
    if (opened == 1) {
      return hitValues
          .map((e) => Container(
                margin: EdgeInsets.only(right: 8.w, top: 4.w),
                child: Text(
                  e.k,
                  style: TextStyle(
                    color: e.v == 0 ? Colors.black : const Color(0xFFFF0033),
                    fontSize: 15.sp,
                    fontFamily: 'bebas',
                    height: e.k == '*' ? 1.25 : 1,
                  ),
                ),
              ))
          .toList();
    }
    return values
        .map((e) => Container(
              margin: EdgeInsets.only(right: 8.w, top: 4.w),
              child: Text(
                e,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontFamily: 'bebas',
                  height: e == '*' ? 1.25 : 1,
                ),
              ),
            ))
        .toList();
  }

  List<Widget> pkViews() {
    if (opened == 1) {
      if (hitValues.any((e) => e.k == '*')) {
        List<List<Model>> splits = split(hitValues, (e) => e.k == '*');
        return [
          _openedDingView('百位', splits[0]),
          _openedDingView('十位', splits[1]),
          _openedDingView('个位', splits[2]),
        ];
      }
      List<Widget> views = [];
      for (int i = 0; i < hitValues.length; i++) {
        views.add(_ballView(
          ball: hitValues[i].k,
          color: hitValues[i].v == 0 ? Colors.black : const Color(0xFFF43F3B),
          right: i < hitValues.length - 1 ? 4.w : 0,
        ));
      }
      return views;
    }
    if (values.contains('*')) {
      List<List<String>> splits = split(values, (e) => e == '*');
      return [
        _unopenedDingView('百位', splits[0]),
        _unopenedDingView('十位', splits[1]),
        _unopenedDingView('个位', splits[2]),
      ];
    }
    List<Widget> views = [];
    for (int i = 0; i < values.length; i++) {
      views.add(_ballView(
        ball: values[i],
        color: Colors.black,
        right: i < values.length - 1 ? 4.w : 0,
      ));
    }
    return views;
  }

  Widget _ballView({
    required String ball,
    required Color color,
    required double right,
  }) {
    return Container(
      margin: EdgeInsets.only(right: right),
      child: Text(
        ball,
        style: TextStyle(
          color: color,
          fontSize: 15.5.sp,
        ),
      ),
    );
  }

  Widget _openedDingView(String title, List<Model> items) {
    List<Widget> itemViews = [];
    for (int i = 0; i < items.length; i++) {
      itemViews.add(_ballView(
        ball: items[i].k,
        color: items[i].v == 0 ? Colors.black : const Color(0xFFF43F3B),
        right: i < items.length - 1 ? 5.w : 0,
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
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
        ...itemViews,
      ],
    );
  }

  Widget _unopenedDingView(String title, List<String> items) {
    List<Widget> itemViews = [];
    for (int i = 0; i < items.length; i++) {
      itemViews.add(_ballView(
        ball: items[i],
        color: Colors.black,
        right: i < items.length - 1 ? 6.w : 0,
      ));
    }

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
        ...itemViews,
      ],
    );
  }

  List<List<T>> split<T>(List<T> values, bool Function(T e) test) {
    List<List<T>> result = [];
    List<T> item = [];
    for (int i = 0; i < values.length; i++) {
      T value = values[i];
      if (test(value)) {
        result.add([...item]);
        item = [];
      } else {
        item.add(value);
      }
    }
    result.add(item);
    return result;
  }
}
