import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/fc3d_real_time_controller.dart';

class Fc3dRealTimeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Fc3dRealTimeController());
  }
}
