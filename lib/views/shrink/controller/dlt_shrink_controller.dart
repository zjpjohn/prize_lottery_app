import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/utils/combine_utils.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/views/shrink/model/shrink_filter.dart';
import 'package:prize_lottery_app/views/shrink/model/shrink_state.dart';

class DltShrinkController extends AbsRequestController {
  ///
  ///
  ShrinkState _status = ShrinkState.start;

  set status(ShrinkState state) {
    _status = state;
    update();
  }

  ShrinkState get status => _status;

  ///
  ///和值过滤
  final SumShrink _sumShrink = SumShrink(min: 15, max: 165);

  SumShrink get sumShrink => _sumShrink;

  void sumRange(RangeValues value) {
    _sumShrink.ranges = value;
    update();
  }

  void addSumOe(int value) {
    if (!_sumShrink.oddEven.contains(value)) {
      _sumShrink.oddEven.add(value);
    } else {
      _sumShrink.oddEven.remove(value);
    }
    update();
  }

  void addSumRoad(int value) {
    if (!_sumShrink.roads.contains(value)) {
      _sumShrink.roads.add(value);
    } else {
      _sumShrink.roads.remove(value);
    }
    update();
  }

  void addSumTail(int value) {
    if (!_sumShrink.tail.contains(value)) {
      _sumShrink.tail.add(value);
    } else {
      _sumShrink.tail.remove(value);
    }
    update();
  }

  ///跨度过滤
  final KuaShrink _kuaShrink = KuaShrink(min: 4, max: 34);

  KuaShrink get kuaShrink => _kuaShrink;

  void addKua(int value) {
    if (!_kuaShrink.kuas.contains(value)) {
      _kuaShrink.kuas.add(value);
    } else {
      _kuaShrink.kuas.remove(value);
    }
    update();
  }

  void clearKua() {
    _kuaShrink.kuas.clear();
    update();
  }

  ///质合过滤
  final PrimeModel primeModel =
      PrimeModel({0: '0:5', 1: '1:4', 2: '2:3', 3: '3:2', 4: '4:1', 5: '5:0'});
  final PrimeShrink _primeShrink = PrimeShrink();

  PrimeShrink get primeShrink => _primeShrink;

  void addPrime(int value) {
    if (!_primeShrink.prime.contains(primeModel.primes[value]!)) {
      _primeShrink.prime.add(primeModel.primes[value]!);
    } else {
      _primeShrink.prime.remove(primeModel.primes[value]!);
    }
    update();
  }

  void clearPrime() {
    _primeShrink.prime.clear();
    update();
  }

  ///
  final DanModel danModel = DanModel(min: 1, max: 35, danMax: 5, limit: 6);
  final DanShrink _danShrink = DanShrink();

  DanShrink get danShrink => _danShrink;

  void addDanBall(int value) {
    if (!_danShrink.dans.contains(value)) {
      if (_danShrink.dans.length >= danModel.limit) {
        EasyLoading.showToast('最多选择${danModel.limit}个胆码');
        return;
      }
      _danShrink.dans.add(value);
    } else {
      _danShrink.dans.remove(value);

      ///清除多余胆码个数
      Set<int> bigSet =
          _danShrink.numbers.where((e) => e > _danShrink.dans.length).toSet();
      _danShrink.numbers.removeAll(bigSet);
    }
    update();
  }

  void addDanNumber(int value) {
    if (!_danShrink.numbers.contains(value)) {
      _danShrink.numbers.add(value);
    } else {
      _danShrink.numbers.remove(value);
    }
    update();
  }

  ///大小过滤
  final BigModel bigModel =
      BigModel({0: '0:5', 1: '1:4', 2: '2:3', 3: '3:2', 4: '4:1', 5: '5:0'});
  final BigShrink _bigShrink = BigShrink(18);

  BigShrink get bigShrink => _bigShrink;

  void addBig(int value) {
    if (!_bigShrink.ratios.contains(bigModel.ranges[value]!)) {
      _bigShrink.ratios.add(bigModel.ranges[value]!);
    } else {
      _bigShrink.ratios.remove(bigModel.ranges[value]!);
    }
    update();
  }

  void clearBig() {
    _bigShrink.ratios.clear();
    update();
  }

  ///奇偶过滤
  final EvenModel evenModel =
      EvenModel({0: '0:5', 1: '1:4', 2: '2:3', 3: '3:2', 4: '4:1', 5: '5:0'});
  final EvenOddShrink _eoShrink = EvenOddShrink();

  EvenOddShrink get eoShrink => _eoShrink;

  void addOddEven(int value) {
    if (!_eoShrink.ratios.contains(evenModel.ranges[value]!)) {
      _eoShrink.ratios.add(evenModel.ranges[value]!);
    } else {
      _eoShrink.ratios.remove(evenModel.ranges[value]!);
    }
    update();
  }

  void clearOddEven() {
    _eoShrink.ratios.clear();
    update();
  }

  ///012路过滤
  final Road012Model road012model = Road012Model([0, 1, 2, 3, 4, 5]);
  final Road012Shrink _roadShrink = Road012Shrink();

  Road012Shrink get roadShrink => _roadShrink;

  void addRoad(int road, int value) {
    if (!_roadShrink.roads[road]!.contains(value)) {
      _roadShrink.roads[road]!.add(value);
    } else {
      _roadShrink.roads[road]!.remove(value);
    }
    update();
  }

  void clearRoad() {
    for (var e in _roadShrink.roads.entries) {
      e.value.clear();
    }
    update();
  }

  ///连号过滤
  final SeriesModel seriesModel =
      SeriesModel({0: '无连号', 2: '二连号', 3: '三连号', 4: '四连号', 5: '五连号'});
  final SeriesShrink _seriesShrink = SeriesShrink();

  SeriesShrink get seriesShrink => _seriesShrink;

  void addSeries(int value) {
    if (!_seriesShrink.series.containsKey(value)) {
      _seriesShrink.series.putIfAbsent(value, () => seriesModel.ranges[value]!);
    } else {
      _seriesShrink.series.remove(value);
    }
    update();
  }

  void clearSeries() {
    _seriesShrink.series.clear();
    update();
  }

  final AcModel acModel = AcModel([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
  final AcShrink _acShrink = AcShrink();

  AcShrink get acShrink => _acShrink;

  void addAc(int value) {
    if (!_acShrink.acs.contains(value)) {
      _acShrink.acs.add(value);
    } else {
      _acShrink.acs.remove(value);
    }
    update();
  }

  void clearAc() {
    _acShrink.clear();
    update();
  }

  final SegmentShrink _segShrink = SegmentShrink(
    lower: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
    middle: [13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24],
    higher: [25, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35],
    segMax: 5,
  );

  SegmentShrink get segShrink => _segShrink;

  void addSeg(int seg, int value) {
    Set<int> collect = _segShrink.segs[seg]!;
    if (!collect.contains(value)) {
      collect.add(value);
    } else {
      collect.remove(value);
    }
    update();
  }

  void clearSegs() {
    _segShrink.clear();
    update();
  }

  void clearShrink() {
    resetBall();
    danShrink.clear();
    sumShrink.clear();
    kuaShrink.clear();
    eoShrink.clear();
    primeShrink.clear();
    roadShrink.clear();
    bigShrink.clear();
    seriesShrink.clear();
    acShrink.clear();
    segShrink.clear();
    lotteries.clear();
    status = ShrinkState.start;
    update();
  }

  ///选择的号码
  List<int> balls = List.of(dlt);

  void tapBall(int value) {
    if (balls.contains(value)) {
      balls.remove(value);
    } else {
      balls.add(value);
    }
    update();
  }

  void resetBall() {
    balls = List.of(dlt);
    update();
  }

  Map<int, String> shrinkParams() {
    Map<int, String> params = {};
    params[0] = balls.join(',');
    if (danShrink.selected()) {
      params[danShrinkIdx] = danShrink.encode();
    }
    if (sumShrink.selected()) {
      params[sumShrinkIdx] = sumShrink.encode();
    }
    if (kuaShrink.selected()) {
      params[kuaShrinkIdx] = kuaShrink.encode();
    }
    if (eoShrink.selected()) {
      params[evenShrinkIdx] = eoShrink.encode();
    }
    if (primeShrink.selected()) {
      params[primeShrinkIdx] = primeShrink.encode();
    }
    if (bigShrink.selected()) {
      params[bigShrinkIdx] = bigShrink.encode();
    }
    if (seriesShrink.selected()) {
      params[seriesShrinkIdx] = seriesShrink.encode();
    }
    if (roadShrink.selected()) {
      params[roadShrinkIdx] = roadShrink.encode();
    }
    if (acShrink.selected()) {
      params[acShrinkIdx] = acShrink.encode();
    }
    if (segShrink.selected()) {
      params[segmentShrinkIdx] = segShrink.encode();
    }
    return params;
  }

  void calculate() {
    if (balls.length > 25) {
      EasyLoading.showToast('最多选择25个号码');
      return;
    }
    if (!danShrink.selected()) {
      EasyLoading.showToast('请选择胆码及胆码个数');
      return;
    }
    if (!sumShrink.selected()) {
      EasyLoading.showToast('请选择和值范围');
      return;
    }
    if (!seriesShrink.selected() ||
        !bigShrink.selected() ||
        !eoShrink.selected()) {
      EasyLoading.showToast('请选择连号、大小及奇偶形态');
      return;
    }
    if (!acShrink.selected()) {
      EasyLoading.showToast('请选择AC值');
      return;
    }
    status = ShrinkState.start;
    lotteries.clear();
    EasyLoading.show(status: '正在计算');
    final Map<int, String> params = shrinkParams();
    Calculator.execute(arg: params, task: shrink)
        .then((value) => lotteries.addAll(value))
        .whenComplete(() {
      Future.delayed(const Duration(milliseconds: 250), () {
        EasyLoading.dismiss();
        status = ShrinkState.complete;
      });
    });
  }

  ///缩水后号码集合
  List<List<int>> lotteries = [];

  @override
  void initialBefore() {}

  @override
  Future<void> request() async {
    showLoading();
    Future.delayed(const Duration(milliseconds: 250), () {
      showSuccess(true);
    });
  }
}

List<List<int>> shrink(Map<int, String> params) {
  ///
  List<List<int>> collect = [];

  ///
  List<int> balls = params[0]!.split(',').map((e) => int.parse(e)).toList();

  ///
  DanShrink? danShrink;
  SumShrink? sumShrink;
  KuaShrink? kuaShrink;
  EvenOddShrink? eoShrink;
  PrimeShrink? primeShrink;
  Road012Shrink? roadShrink;
  BigShrink? bigShrink;
  SegmentShrink? segShrink;
  AcShrink? acShrink;
  SeriesShrink? seriesShrink;

  if (params[danShrinkIdx] != null) {
    danShrink = DanShrink.fromStr(params[danShrinkIdx]!);
  }
  if (params[sumShrinkIdx] != null) {
    sumShrink = SumShrink.fromStr(params[sumShrinkIdx]!);
  }
  if (params[kuaShrinkIdx] != null) {
    kuaShrink = KuaShrink.fromStr(params[kuaShrinkIdx]!);
  }
  if (params[evenShrinkIdx] != null) {
    eoShrink = EvenOddShrink.fromStr(params[evenShrinkIdx]!);
  }
  if (params[primeShrinkIdx] != null) {
    primeShrink = PrimeShrink.fromStr(params[primeShrinkIdx]!);
  }
  if (params[roadShrinkIdx] != null) {
    roadShrink = Road012Shrink.fromStr(params[roadShrinkIdx]!);
  }
  if (params[bigShrinkIdx] != null) {
    bigShrink = BigShrink.fromStr(params[bigShrinkIdx]!);
  }
  if (params[segmentShrinkIdx] != null) {
    segShrink = SegmentShrink.fromStr(params[segmentShrinkIdx]!);
  }
  if (params[acShrinkIdx] != null) {
    acShrink = AcShrink.fromStr(params[acShrinkIdx]!);
  }
  if (params[seriesShrinkIdx] != null) {
    seriesShrink = SeriesShrink.fromStr(params[seriesShrinkIdx]!);
  }

  ///内部过滤函数
  bool filter(List<int> ball) {
    if (danShrink != null && !danShrink.shrink(ball)) {
      return false;
    }
    if (sumShrink != null && !sumShrink.shrink(ball)) {
      return false;
    }
    if (kuaShrink != null && !kuaShrink.shrink(ball)) {
      return false;
    }
    if (eoShrink != null && !eoShrink.shrink(ball)) {
      return false;
    }
    if (primeShrink != null && !primeShrink.shrink(ball)) {
      return false;
    }
    if (roadShrink != null && !roadShrink.shrink(ball)) {
      return false;
    }
    if (bigShrink != null && !bigShrink.shrink(ball)) {
      return false;
    }
    if (segShrink != null && !segShrink.shrink(ball)) {
      return false;
    }
    if (acShrink != null && !acShrink.shrink(ball)) {
      return false;
    }
    if (seriesShrink != null && !seriesShrink.shrink(ball)) {
      return false;
    }
    return true;
  }

  ///非胆码号吗
  List<int> others = Set.of(balls).difference(Set.of(danShrink!.dans)).toList();

  ///通过胆码进行组码
  for (var mem in danShrink.numbers) {
    int danCom = Combination.combine(danShrink.dans.length, mem);
    for (int i = 0; i < danCom; i++) {
      List<int> numbers =
          Combination.combineValue(danShrink.dans.toList(), mem, i);
      int otherNum = 5 - mem;
      if (otherNum == 0) {
        if (filter(numbers)) {
          collect.add(numbers..sort());
        }
      } else {
        int otherCom = Combination.combine(others.length, otherNum);
        for (int j = 0; j < otherCom; j++) {
          List<int> ballNumbers = List.of(numbers)
            ..addAll(Combination.combineValue(others, otherNum, j));
          if (filter(ballNumbers)) {
            collect.add(ballNumbers..sort());
          }
        }
      }
    }
  }
  return collect;
}
