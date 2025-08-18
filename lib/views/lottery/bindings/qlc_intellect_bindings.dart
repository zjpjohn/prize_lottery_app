import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/qlc_intellect_controller.dart';

class QlcIntellectBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QlcIntellectController());
  }
}
