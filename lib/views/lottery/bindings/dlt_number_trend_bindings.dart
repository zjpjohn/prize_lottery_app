import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/dlt_number_trend_controller.dart';

class DltNumberTrendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DltNumberTrendController());
  }
}
