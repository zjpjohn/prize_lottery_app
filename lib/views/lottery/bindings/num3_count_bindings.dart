import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/Num3_com_follow_controller.dart';
import 'package:prize_lottery_app/views/lottery/controller/num3_com_count_controller.dart';
import 'package:prize_lottery_app/views/lottery/controller/num3_follow_controller.dart';

class Num3CountBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Num3ComCountController());
  }
}

class Num3FollowBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Num3FollowController());
  }
}

class ComFollowBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Num3ComFollowController());
  }
}
