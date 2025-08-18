import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/qlc_real_time_controller.dart';

class QlcRealTimeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QlcRealTimeController());
  }
}
