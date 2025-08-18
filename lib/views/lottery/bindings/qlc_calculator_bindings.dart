import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/qlc_calculator_controller.dart';

class QlcCalculatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QlcCalculatorController());
  }
}
