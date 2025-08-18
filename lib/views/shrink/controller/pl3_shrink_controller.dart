import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/shrink/model/shrink_filter.dart';
import 'package:prize_lottery_app/views/shrink/model/shrink_state.dart';

class Pl3ShrinkController extends AbsRequestController {
  ///
  /// 海报key
  final GlobalKey posterKey = GlobalKey();

  ///
  ///计算状态
  ShrinkState _status = ShrinkState.start;

  set status(ShrinkState state) {
    _status = state;
    update();
  }

  ShrinkState get status => _status;

  ///
  ///和值过滤
  final SumShrink _sumShrink = SumShrink(min: 0, max: 27);

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
  final KuaShrink _kuaShrink = KuaShrink(min: 0, max: 9);

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
      PrimeModel({0: '0:3', 1: '1:2', 2: '2:1', 3: '3:0'});
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

  ///胆码过滤
  final DanModel danModel = DanModel(min: 0, max: 9, danMax: 3, limit: 5);
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
  final BigModel bigModel = BigModel({0: '0:3', 1: '1:2', 2: '2:1', 3: '3:0'});
  final BigShrink _bigShrink = BigShrink(5);

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
      EvenModel({0: '0:3', 1: '1:2', 2: '2:1', 3: '3:0'});
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
  final Road012Model road012model = Road012Model([0, 1, 2, 3]);
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

  ///形态过滤
  final N3PatternModel n3patternModel =
      N3PatternModel({3: '组六型', 2: '组三型', 1: '豹子型'});
  final N3PatternShrink _patternShrink = N3PatternShrink();

  N3PatternShrink get patternShrink => _patternShrink;

  void addPattern(int value) {
    if (!_patternShrink.pattern.containsKey(value)) {
      _patternShrink.pattern
          .putIfAbsent(value, () => n3patternModel.patterns[value]!);
    } else {
      _patternShrink.pattern.remove(value);
    }
    update();
  }

  ///连号过滤
  final SeriesModel seriesModel = SeriesModel({0: '无连号', 2: '二连号', 3: '三连号'});
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

  void clearShrink() {
    danShrink.clear();
    sumShrink.clear();
    kuaShrink.clear();
    eoShrink.clear();
    primeShrink.clear();
    roadShrink.clear();
    bigShrink.clear();
    patternShrink.clear();
    seriesShrink.clear();
    status = ShrinkState.start;
    if (_type == 0) {
      direct.clear();
      resetDirects();
    } else {
      combine.clear();
      resetCombine();
    }
  }

  void shrinkCalculate() async {
    if (!danShrink.selected()) {
      EasyLoading.showToast('请选择胆码及胆码个数');
      return;
    }
    if (!patternShrink.selected()) {
      EasyLoading.showToast('请选择号码形态及连号形态');
      return;
    }
    status = ShrinkState.start;
    EasyLoading.show(status: '正在计算');
    final Map<int, String> dataParams = shrinkParams();
    final IsolateParams params = IsolateParams(type: type, params: dataParams);
    Calculator.execute(arg: params, task: shrink).then((value) {
      if (type == 0) {
        addDirect(value);
        return;
      }
      addCombine(value);
    }).whenComplete(() {
      Future.delayed(const Duration(milliseconds: 250), () {
        status = ShrinkState.complete;
        EasyLoading.dismiss();
      });
    });
  }

  ///
  /// 构造异步多线程参数
  Map<int, String> shrinkParams() {
    Map<int, String> params = {};
    if (_type == 0) {
      params[0] =
          '${directs[0]!.join(",")};${directs[1]!.join(",")};${directs[2]!.join(',')}';
    } else {
      params[0] = combines.join(",");
    }
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
    if (patternShrink.selected()) {
      params[n3PatternShrinkIdx] = patternShrink.encode();
    }
    if (seriesShrink.selected()) {
      params[seriesShrinkIdx] = seriesShrink.encode();
    }
    if (roadShrink.selected()) {
      params[roadShrinkIdx] = roadShrink.encode();
    }
    return params;
  }

  ///
  late int _type = 0;

  ///直选选择的数据
  Map<int, List<int>> directs = {
    0: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    1: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    2: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
  };

  ///选择的组选数据
  List<int> combines = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  ///过滤后的直选号码
  final List<List<int>> _direct = [];

  List<List<int>> get direct => _direct;

  void addDirect(List<List<int>> direct) {
    _direct
      ..clear()
      ..addAll(direct);
    update();
  }

  ///过滤后的组选号码
  final List<List<int>> _combine = [];

  List<List<int>> get combine => _combine;

  void addCombine(List<List<int>> combine) {
    _combine
      ..clear()
      ..addAll(combine);
    update();
  }

  int get type => _type;

  set type(int type) {
    _type = type;
    update();
  }

  void tapDirect(int index, int value) {
    if (directs[index]!.contains(value)) {
      directs[index]!.remove(value);
    } else {
      directs[index]!.add(value);
    }
    update();
  }

  void resetDirects() {
    directs = {
      0: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
      1: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
      2: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    };
    update();
  }

  void tapCombine(int value) {
    if (combines.contains(value)) {
      combines.remove(value);
    } else {
      combines.add(value);
    }
    update();
  }

  void resetCombine() {
    combines = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
    update();
  }

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

List<List<int>> shrink(IsolateParams params) {
  if (params.type == 0) {
    return directShrink(params.params);
  }
  return combineShrink(params.params);
}

List<List<int>> directShrink(Map<int, String> params) {
  ///
  List<List<int>> collect = [];
  List<String> directs = params[0]!.split(';');

  ///
  List<int> bai = directs[0].split(',').map((e) => int.parse(e)).toList(),
      shi = directs[1].split(',').map((e) => int.parse(e)).toList(),
      ge = directs[2].split(',').map((e) => int.parse(e)).toList();

  ///
  DanShrink? danShrink;
  SumShrink? sumShrink;
  KuaShrink? kuaShrink;
  EvenOddShrink? eoShrink;
  PrimeShrink? primeShrink;
  Road012Shrink? roadShrink;
  BigShrink? bigShrink;
  N3PatternShrink? patternShrink;
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
  if (params[n3PatternShrinkIdx] != null) {
    patternShrink = N3PatternShrink.fromStr(params[n3PatternShrinkIdx]!);
  }
  if (params[seriesShrinkIdx] != null) {
    seriesShrink = SeriesShrink.fromStr(params[seriesShrinkIdx]!);
  }

  ///
  /// 内部过滤函数
  bool shrink(List<int> ball) {
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
    if (patternShrink != null && !patternShrink.shrink(ball)) {
      return false;
    }
    if (seriesShrink != null && !seriesShrink.shrink(ball)) {
      return false;
    }
    return true;
  }

  ///
  for (int i = 0; i < bai.length; i++) {
    for (int j = 0; j < shi.length; j++) {
      for (int k = 0; k < ge.length; k++) {
        ///
        List<int> ball = [bai[i], shi[j], ge[k]];
        if (shrink(ball)) {
          collect.add(ball);
        }
      }
    }
  }
  return collect;
}

List<List<int>> combineShrink(Map<int, String> params) {
  ///
  ///
  List<List<int>> collect = [];

  ///
  List<int> combines = params[0]!.split(',').map((e) => int.parse(e)).toList();

  ///
  DanShrink? danShrink;
  SumShrink? sumShrink;
  KuaShrink? kuaShrink;
  EvenOddShrink? eoShrink;
  PrimeShrink? primeShrink;
  Road012Shrink? roadShrink;
  BigShrink? bigShrink;
  N3PatternShrink? patternShrink;
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
  if (params[n3PatternShrinkIdx] != null) {
    patternShrink = N3PatternShrink.fromStr(params[n3PatternShrinkIdx]!);
  }
  if (params[seriesShrinkIdx] != null) {
    seriesShrink = SeriesShrink.fromStr(params[seriesShrinkIdx]!);
  }

  ///内部过滤函数
  bool shrink(List<int> ball) {
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
    if (patternShrink != null && !patternShrink.shrink(ball)) {
      return false;
    }
    if (seriesShrink != null && !seriesShrink.shrink(ball)) {
      return false;
    }
    return true;
  }

  ///豹子筛选
  for (int i = 0; i < combines.length; i++) {
    List<int> ball = List.of([combines[i], combines[i], combines[i]]);
    if (shrink(ball)) {
      collect.add(ball);
    }
  }

  ///组三筛选
  for (int i = 0; i < combines.length - 1; i++) {
    for (int j = i + 1; j < combines.length; j++) {
      List<int> ball1 = List.of([combines[i], combines[i], combines[j]]);
      if (shrink(ball1)) {
        collect.add(ball1);
      }
      List<int> ball2 = List.of([combines[i], combines[j], combines[j]]);
      if (shrink(ball2)) {
        collect.add(ball2);
      }
    }
  }

  ///组六筛选
  for (int i = 0; i < combines.length - 2; i++) {
    for (int j = i + 1; j < combines.length - 1; j++) {
      for (int k = j + 1; k < combines.length; k++) {
        List<int> ball = List.of([combines[i], combines[j], combines[k]]);
        if (shrink(ball)) {
          collect.add(ball);
        }
      }
    }
  }
  return collect;
}
