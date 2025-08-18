import 'package:get/get.dart';
import 'package:prize_lottery_app/views/shrink/controller/qlc_shrink_controller.dart';

class QlcShrinkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QlcShrinkController());
  }
}
