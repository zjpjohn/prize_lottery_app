import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

class Num3ComFollowController extends AbsRequestController {
  ///
  ///
  late String type;
  late String com;

  ///历史跟随数据
  List<Num3LottoFollow> data = [];

  @override
  Future<void> request() async {
    showLoading();
    LotteryInfoRepository.comFollows(type: type, com: com).then((value) {
      data = value;
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(true);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  ///
  /// 前置初始化
  @override
  void initialBefore() {
    type = Get.parameters['type']!;
    com = Get.parameters['com']!;
  }
}
