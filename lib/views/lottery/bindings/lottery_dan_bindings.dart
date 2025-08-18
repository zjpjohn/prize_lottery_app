import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_around_controller.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_dan_controller.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_honey_controller.dart';

class LotteryDanBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LotteryDanController());
  }
}

class LotteryAroundBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LotteryAroundController());
  }
}

class LotteryHoneyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LotteryHoneyController());
  }
}
