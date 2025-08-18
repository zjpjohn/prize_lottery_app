import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/ssq_intellect_controller.dart';

class SsqIntellectBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SsqIntellectController());
  }
}
