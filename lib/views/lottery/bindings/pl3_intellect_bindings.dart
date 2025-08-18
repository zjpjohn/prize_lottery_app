import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/pl3_intellect_controller.dart';

class Pl3IntellectBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Pl3IntellectController());
  }
}
