import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_census.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

class LotteryStateController extends AbsRequestController {
  ///
  /// 彩种类型
  late String type;

  LotteryStateController(this.type);

  ///请求数据量
  int _size = 50;

  ///开奖数据统计
  List<LotteryCensus> lottos = [];

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

    ///彩票走势统计分析
    LotteryInfoRepository.historyLotteries({
      'type': type,
      'limit': _size,
    }).then((value) {
      List<LotteryCensus> censuses =
          value.records.map((e) => LotteryCensus(e, 9)).toList();
      lottos
        ..clear()
        ..addAll(censuses)
        ..sort((e1, e2) => e1.period.compareTo(e2.period));
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(lottos);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
