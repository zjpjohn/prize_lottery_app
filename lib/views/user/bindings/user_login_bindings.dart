import 'package:get/get.dart';
import 'package:prize_lottery_app/views/user/controller/user_login_controller.dart';

class UserLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserLoginController());
  }
}
