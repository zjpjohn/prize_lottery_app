import 'package:get/get.dart';
import 'package:prize_lottery_app/views/shrink/controller/pl3_shrink_controller.dart';

class Pl3ShrinkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Pl3ShrinkController());
  }
}
