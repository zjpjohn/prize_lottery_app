import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_pian_controller.dart';

class LotteryPianBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LotteryPianController());
  }

}
