import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/ssq_calculator_controller.dart';

class SsqCalculatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SsqCalculatorController());
  }
}
