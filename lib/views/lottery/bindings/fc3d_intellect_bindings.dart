import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/fc3d_intellect_controller.dart';

class Fc3dIntellectBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Fc3dIntellectController());
  }
}
