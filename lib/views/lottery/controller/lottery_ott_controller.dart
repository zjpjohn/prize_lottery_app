import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_ott.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

class LotteryOttController extends AbsRequestController {
  ///
  /// 彩票类型
  final String lotto;

  /// 查询数据量
  int _size = 50;

  ///012路遗漏
  List<LotteryOtt> ottList = [];

  LotteryOttController(this.lotto);

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
    LotteryInfoRepository.ottList(lotto, _size).then((value) {
      ottList
        ..clear()
        ..addAll(value);
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(ottList);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
