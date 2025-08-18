import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_dan.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

class LotteryDanController extends AbsRequestController {
  ///
  /// 胆码集合
  List<LotteryDan> danList = [];
  late DanOmitCensus current;
  late DanOmitCensus maxOmit;
  late DanOmitCensus avgOmit;
  late DanOmitCensus frequent;

  @override
  Future<void> request() async {
    showLoading();
    LotteryInfoRepository.danList(Get.parameters['type']!).then((value) {
      danList.addAll(value);
      if (danList.isNotEmpty) {
        current = DanOmitCensus.current(danList);
        maxOmit = DanOmitCensus.maxOmit(danList);
        avgOmit = DanOmitCensus.avgOmit(danList);
        frequent = DanOmitCensus.total(danList);
      }
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(danList);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  Map<String, LotteryDan> toMap() {
    return {for (var v in danList) v.period: v};
  }
}
