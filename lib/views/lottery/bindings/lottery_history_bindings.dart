import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_history_controller.dart';

class LotteryHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LotteryHistoryController());
  }
}
