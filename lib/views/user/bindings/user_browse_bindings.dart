import 'package:get/get.dart';
import 'package:prize_lottery_app/views/user/controller/user_browse_controller.dart';

class UserBrowseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserBrowseController());
  }
}
