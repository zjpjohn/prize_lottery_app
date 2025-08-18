import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/ssq_real_time_controller.dart';

class SsqRealTimeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SsqRealTimeController());
  }
}
