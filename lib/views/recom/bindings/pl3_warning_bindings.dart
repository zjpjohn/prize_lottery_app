import 'package:get/get.dart';
import 'package:prize_lottery_app/views/recom/controller/pl3_warning_controller.dart';

class Pl3WarningBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Pl3WarningController());
  }
}
