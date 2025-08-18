import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/kl8_number_trend_controller.dart';
import 'package:prize_lottery_app/views/lottery/controller/kl8_tail_matrix_controller.dart';

class Kl8NumberTrendBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Kl8NumberTrendController());
  }
}

class Kl8MatrixBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Kl8TailMatrixController());
  }
}
