import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/assistant_detail_controller.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_assistant_controller.dart';

class LotteryAssistantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LotteryAssistantController());
  }
}

class AssistantDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AssistantDetailController());
  }
}
