import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_detail_controller.dart';

class LotteryDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LotteryDetailController());
  }
}
