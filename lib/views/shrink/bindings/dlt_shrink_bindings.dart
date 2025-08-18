import 'package:get/get.dart';
import 'package:prize_lottery_app/views/shrink/controller/dlt_shrink_controller.dart';

class DltShrinkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DltShrinkController());
  }
}
