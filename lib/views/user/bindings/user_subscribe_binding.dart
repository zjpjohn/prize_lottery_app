import 'package:get/get.dart';
import 'package:prize_lottery_app/views/user/controller/user_subscribe_controller.dart';

class UserSubscribeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserSubscribeController());
  }
}
