import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_palace_controller.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_palace_new_controller.dart';

class HoneyTableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LotteryPalaceController());
  }
}

class HoneyNewTableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LotteryPalaceNewController());
  }
}
