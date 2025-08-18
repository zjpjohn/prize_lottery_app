import 'package:get/get.dart';
import 'package:prize_lottery_app/views/recom/controller/fc3d_warning_controller.dart';

class Fc3dWarningBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Fc3dWarningController());
  }
}
