import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/dlt_calculator_controller.dart';

class DltCalculatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DltCalculatorController());
  }
}
