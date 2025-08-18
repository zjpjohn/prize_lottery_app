import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_omit.dart';
import 'package:prize_lottery_app/views/lottery/model/n3_omit_census.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

class LotteryMatchOmitController extends AbsRequestController {
  ///彩种类型
  late String type;

  ///查询数量
  int _size = 50;

  ///开奖数据
  List<LotteryInfo> lotteries = [];

  ///遗漏统计数据
  List<MatchOmit> omits = [];
  late MatchCensus census;

  LotteryMatchOmitController(this.type);

  int get size => _size;

  set size(int value) {
    if (_size == value) {
      return;
    }
    _size = value;
    request();
    update();
  }

  List<Future<void>> asyncTasks() {
    return [
      LotteryInfoRepository.historyLotteries({
        'type': type,
        'limit': _size,
      }).then((value) {
        lotteries
          ..clear()
          ..addAll(value.records)
          ..sort((e1, e2) => e1.period.compareTo(e2.period));
      }),
      LotteryInfoRepository.matchOmits(type, _size).then((value) {
        omits
          ..clear()
          ..addAll(value)
          ..sort((e1, e2) => e1.period.compareTo(e2.period));
        if (omits.isNotEmpty) {
          census = MatchCensus(omits);
        }
      }),
    ];
  }

  @override
  Future<void> request() async {
    showLoading();
    await Future.wait(asyncTasks()).then((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(omits);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
