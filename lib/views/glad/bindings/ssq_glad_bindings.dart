import 'package:get/get.dart';
import 'package:prize_lottery_app/views/glad/controller/ssq_glad_list_controller.dart';

class SsqGladBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SsqGladListController());
  }
}
