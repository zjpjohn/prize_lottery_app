import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/ssq_number_trend_controller.dart';

class SsqNumberTrendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SsqNumberTrendController());
  }
}
