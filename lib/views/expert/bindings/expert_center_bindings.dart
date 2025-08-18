import 'package:get/get.dart';
import 'package:prize_lottery_app/views/expert/controller/expert_center_controller.dart';

class ExpertCenterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExpertCenterController());
  }
}
