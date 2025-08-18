import 'package:get/get.dart';
import 'package:prize_lottery_app/views/main/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    ///主页面控制器
    Get.put<MainController>(MainController());
  }
}
