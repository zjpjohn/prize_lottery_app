import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/dlt_real_time_controller.dart';

class DltRealTimeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DltRealTimeController());
  }
}
