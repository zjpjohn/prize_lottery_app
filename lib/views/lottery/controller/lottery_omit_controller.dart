import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_omit.dart';
import 'package:prize_lottery_app/views/lottery/model/n3_omit_census.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

class LotteryN3OmitController extends AbsRequestController {
  LotteryN3OmitController(this.type);

  ///彩票类型
  late String type;

  /// 查询数量
  int _size = 50;

  ///
  List<LotteryOmit> omits = [];

  ///
  late N3OmitCensus census;

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
    LotteryInfoRepository.lotteryOmits(type, _size).then((value) {
      omits
        ..clear()
        ..addAll(value)
        ..sort((e1, e2) => e1.period.compareTo(e2.period));
      if (omits.isNotEmpty) {
        census = N3OmitCensus(omits);
      }
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(omits);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
