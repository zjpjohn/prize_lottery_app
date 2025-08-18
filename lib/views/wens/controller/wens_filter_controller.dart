import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/lottery/utils/num3_lottery_utils.dart';
import 'package:prize_lottery_app/views/wens/model/wens_filter.dart';
import 'package:prize_lottery_app/views/wens/repository/wens_filter_repository.dart';

class WensFilterController extends AbsRequestController {
  ///
  ///
  late String type;

  /// 海报保存key
  late GlobalKey posterKey;

  /// 当前期号
  String? _period;
  int current = 0;
  List<String> periods = [];

  ///过滤条件信息
  late FilterInfo _filterInfo;
  Map<String, FilterInfo> cache = {};

  FilterDto filter = FilterDto();
  FilterResult result = FilterResult(
    zu3: [],
    zu6: [],
    direct: [],
  );

  Num3Lottery get lottery => _filterInfo.lottery;

  bool disableDan(int value) {
    return filter.killList.contains(value);
  }

  bool hasPickedDan() {
    return filter.danList1.isNotEmpty ||
        filter.danList2.isNotEmpty ||
        filter.danList3.isNotEmpty;
  }

  bool hasPickedDuanZu() {
    return filter.currDuanZu.entries
            .where((e) => e.value.excludes.isNotEmpty)
            .isNotEmpty ||
        filter.lastDuanZu.entries
            .where((e) => e.value.excludes.isNotEmpty)
            .isNotEmpty;
  }

  bool disableKill(int value) {
    return filter.danList1.contains(value) ||
        filter.danList2.contains(value) ||
        filter.danList3.contains(value);
  }

  void enableWeekDan() {
    List<int> dan = _filterInfo.todayDan
        .where((e) => !filter.killList.contains(e))
        .toList();
    if (filter.danList1.isNotEmpty) {
      Set<int> from = Set.from(filter.danList1)..addAll(dan);
      filter.danList1 = from.toList();
      update();
      return;
    }
    filter.danList1 = dan;
    update();
  }

  void enableJinDiff() {
    if (filter.jinDiff.isEmpty) {
      filter.jinDiff.addAll(_filterInfo.jinDiff);
      update();
      return;
    }
    Set<int> from = Set.from(filter.jinDiff);
    from.addAll(_filterInfo.jinDiff);
    filter.jinDiff = from.toList();
    update();
  }

  void jinDiffPick(int value) {
    if (filter.jinDiff.contains(value)) {
      filter.jinDiff.remove(value);
      update();
      return;
    }
    filter.jinDiff.add(value);
    update();
  }

  void enableEvenSum() {
    if (filter.evenSum.isEmpty) {
      filter.evenSum.addAll(_filterInfo.oeSum);
      update();
      return;
    }
    Set<int> from = Set.from(filter.evenSum);
    from.addAll(_filterInfo.oeSum);
    filter.evenSum = from.toList();
    update();
  }

  void evenSumPick(int value) {
    if (filter.evenSum.contains(value)) {
      filter.evenSum.remove(value);
      update();
      return;
    }
    filter.evenSum.add(value);
    update();
  }

  void directPick(int value, List<int> direct) {
    if (direct.contains(value)) {
      direct.remove(value);
      update();
      return;
    }
    if (direct.length > 7) {
      EasyLoading.showToast('定位最多可选择7个');
      return;
    }
    direct.add(value);
    update();
  }

  void directClear(List<int> direct) {
    if (direct.isNotEmpty) {
      direct.clear();
      update();
    }
  }

  void clearDan(List<int> danList) {
    if (danList.isNotEmpty) {
      danList.clear();
      update();
    }
  }

  void danPick(int value, List<int> danList) {
    if (danList.contains(value)) {
      danList.remove(value);
      update();
      return;
    }
    if (danList.length >= 4) {
      EasyLoading.showToast('胆码最多可选择4个');
      return;
    }
    danList.add(value);
    update();
  }

  void enableDuanZu(DuanZuInfo duanZu) {
    if (duanZu.excludes.isNotEmpty) {
      duanZu.excludes = [];
      update();
      return;
    }
    duanZu.excludes = duanZuExcludes(duanZu.table);
    update();
  }

  void killPick(int value) {
    if (filter.killList.contains(value)) {
      filter.killList.remove(value);
      update();
      return;
    }
    if (filter.killList.length >= 4) {
      EasyLoading.showToast('杀码最多选择4个');
      return;
    }
    filter.killList.add(value);
    update();
  }

  void sumPick(int value) {
    if (filter.sumList.contains(value)) {
      filter.sumList.remove(value);
    } else {
      filter.sumList.add(value);
    }
    update();
  }

  void kuaPick(int value) {
    if (filter.kuaList.contains(value)) {
      filter.kuaList.remove(value);
    } else {
      filter.kuaList.add(value);
    }
    update();
  }

  void removeTwoMa(int index) {
    if (filter.twoMa.length > index) {
      filter.twoMa.removeAt(index);
      update();
    }
  }

  bool twoMaPick(List<int> value) {
    if (filter.twoMa.where((e) => isSameTwoMa(e, value)).isNotEmpty) {
      EasyLoading.showToast('已存在两码');
      return false;
    }
    if (filter.twoMa.length > 15) {
      EasyLoading.showToast('最多选择15个两码组合');
      return false;
    }
    filter.twoMa.add(value);
    update();
    return true;
  }

  void enableTwoMa() {
    if (filter.twoMa.isEmpty) {
      filter.twoMa.addAll(_filterInfo.twoMaList);
      update();
      return;
    }
    List<List<int>> twoMaList = [];
    for (var e in _filterInfo.twoMaList) {
      if (filter.twoMa.where((v) => isSameTwoMa(v, e)).isEmpty) {
        twoMaList.add(e);
      }
    }
    filter.twoMa.addAll(twoMaList);
    update();
  }

  void clearTwoMa() {
    if (filter.twoMa.isNotEmpty) {
      filter.twoMa.clear();
      update();
    }
  }

  void filterAction() {
    if (!filter.hasConditions()) {
      EasyLoading.showToast('请至少选择一个条件');
      return;
    }
    result = lotteryFilter(filter);
    update();
  }

  void resetFilter({bool duanZu = true}) {
    filter.resetFilter();
    result.resetResult();
    filter.currDuanZu = _filterInfo.currDuanZu;
    filter.lastDuanZu = _filterInfo.lastDuanZu ?? {};
    if (!duanZu) {
      filter.currDuanZu.forEach((k, v) => v.excludes = []);
      filter.lastDuanZu.forEach((k, v) => v.excludes = []);
    }
    update();
  }

  String? get period => _period;

  bool isFirst() {
    if (periods.isNotEmpty) {
      return current >= periods.length - 1;
    }
    return true;
  }

  bool isEnd() {
    return current <= 0;
  }

  void prevPeriod() {
    if (isFirst()) {
      return;
    }
    current = current + 1;
    update();
    period = periods[current];
  }

  void nextPeriod() {
    if (isEnd()) {
      return;
    }
    current = current - 1;
    update();
    period = periods[current];
  }

  set period(String? period) {
    if (period == null || _period == period) {
      return;
    }
    _period = period;
    if (cache[_period] != null) {
      _filterInfo = cache[_period]!;
      resetFilter();
      return;
    }
    EasyLoading.show(status: '加载中');
    Future.wait([
      WenFilterRepository.num3Lottery(
        type: type,
        period: _period,
      ).then((value) {
        _filterInfo = FilterInfo(lottery: value);
        cache[value.period] = _filterInfo;
        _period = value.period;
        resetFilter();
      }),
    ]).catchError((error) {
      showError(error);
    }).whenComplete(() {
      EasyLoading.dismiss();
    });
  }

  @override
  void initialBefore() {
    type = Get.parameters['type']!;
    posterKey = GlobalKey();
  }

  List<Future<void>> asyncTasks() {
    return [
      WenFilterRepository.lotteryPeriods(type: type, limit: 30).then((value) {
        periods = value;
        if (periods.isNotEmpty) {
          _period = periods[0];
        }
      }),
      WenFilterRepository.num3Lottery(type: type, period: _period)
          .then((value) {
        _filterInfo = FilterInfo(lottery: value);
        cache[value.period] = _filterInfo;
        _period = value.period;
        filter.currDuanZu = _filterInfo.currDuanZu;
        filter.lastDuanZu = _filterInfo.lastDuanZu ?? {};
      }),
    ];
  }

  @override
  Future<void> request() async {
    showLoading();
    Future.wait(asyncTasks()).then((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(_filterInfo);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
