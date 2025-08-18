import 'package:get/get.dart';
import 'package:prize_lottery_app/views/wens/controller/wens_filter_controller.dart';

class WensFilterBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WensFilterController());
  }
}
