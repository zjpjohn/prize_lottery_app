import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/dlt_intellect_controller.dart';

class DltIntellectBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DltIntellectController());
  }
}
