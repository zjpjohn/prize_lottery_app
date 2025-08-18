import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

class Num3ComCountController extends AbsRequestController {
  ///
  /// 彩种类型
  late String type;

  ///查询期数
  int _limit = 365;

  ///统计数据
  late Map<int, List<String>> counts;

  int get limit => _limit;

  set limit(value) {
    if (_limit == value) {
      return;
    }
    _limit = value;
    update();
    loadComCount(true);
  }

  void loadComCount(bool showLoading) {
    if (showLoading) {
      EasyLoading.show();
    }
    LotteryInfoRepository.num3ComCounts(type: type, limit: _limit).then((data) {
      counts = Map.fromEntries(
          data.entries.toList()..sort((a, b) => b.key.compareTo(a.key)));
      showSuccess(counts);
    }).catchError((error) {
      showError(error);
    }).whenComplete(() {
      if (showLoading) {
        EasyLoading.dismiss();
      }
    });
  }

  @override
  Future<void> request() async {
    showLoading();
    loadComCount(false);
  }

  @override
  void initialBefore() {
    type = Get.parameters['type']!;
  }
}
