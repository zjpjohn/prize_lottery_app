import 'package:get/get.dart';
import 'package:prize_lottery_app/views/user/controller/member_record_controller.dart';
import 'package:prize_lottery_app/views/user/controller/user_member_controller.dart';

class UserMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserMemberController());
  }
}

class MemberRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MemberRecordController());
  }
}
