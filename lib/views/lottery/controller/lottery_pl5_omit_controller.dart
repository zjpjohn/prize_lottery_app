
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_omit.dart';
import 'package:prize_lottery_app/views/lottery/model/n3_omit_census.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

class LotteryPl5OmitController extends AbsRequestController {
  /// 查询数量
  int _size = 50;

  ///
  List<LotteryOmit> omits = [];

  ///遗漏统计信息
  late Pl5OmitCensus census;

  int get size => _size;

  set size(int value) {
    if (_size == value) {
      return;
    }
    _size = value;
    request();
    update();
  }

  @override
  Future<void> request() async {
    showLoading();
    LotteryInfoRepository.lotteryOmits('pl5', _size).then((value) {
      omits
        ..clear()
        ..addAll(value)
        ..sort((e1, e2) => e1.period.compareTo(e2.period));
      if (omits.isNotEmpty) {
        census = Pl5OmitCensus(omits);
      }
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(omits);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}

class LotteryPl5ItemController extends AbsRequestController {
  ///
  ///
  LotteryPl5ItemController(this.type);

  ///
  late int type;

  ///查询数量
  int _size = 50;

  ///遗漏数据
  List<CbItemOmit> omits = [];

  ///
  late ItemOmitCensus census;

  int get size => _size;

  set size(int value) {
    if (_size == value) {
      return;
    }
    _size = value;
    update();
    request();
  }

  @override
  Future<void> request() async {
    showLoading();
    LotteryInfoRepository.pl5ItemOmits(type: type, size: size).then((data) {
      omits = data;
      omits.sort((e1, e2) => e1.period.compareTo(e2.period));
      census = ItemOmitCensus(omits);
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(omits);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
