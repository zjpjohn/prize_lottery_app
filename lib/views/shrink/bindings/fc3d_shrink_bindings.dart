import 'package:get/get.dart';
import 'package:prize_lottery_app/views/shrink/controller/fc3d_shrink_controller.dart';

class Fc3dShrinkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Fc3dShrinkController());
  }
}
