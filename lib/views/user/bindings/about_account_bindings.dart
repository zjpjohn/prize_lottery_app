import 'package:get/get.dart';
import 'package:prize_lottery_app/views/user/controller/about_account_controller.dart';

class AboutAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AboutAccountController());
  }
}
