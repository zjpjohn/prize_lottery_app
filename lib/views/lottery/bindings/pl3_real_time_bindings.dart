import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/pl3_real_time_controller.dart';

class Pl3RealTimeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Pl3RealTimeController());
  }
}
