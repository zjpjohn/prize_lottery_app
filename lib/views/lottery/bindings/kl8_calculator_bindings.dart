import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/kl8_calculator_controller.dart';

class Kl8CalculatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Kl8CalculatorController>(() => Kl8CalculatorController());
  }
}
