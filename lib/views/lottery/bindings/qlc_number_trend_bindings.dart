import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/qlc_number_trend_controller.dart';

class QlcNumberTrendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QlcNumberTrendController());
  }
}
