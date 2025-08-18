import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/kl8_real_time_controller.dart';

class Kl8RealTimeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Kl8RealTimeController());
  }
}
