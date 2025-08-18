import 'package:get/get.dart';
import 'package:prize_lottery_app/views/shrink/controller/ssq_shrink_controller.dart';

class SsqShrinkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SsqShrinkController());
  }
}
