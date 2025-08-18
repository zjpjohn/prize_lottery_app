import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/agent_protocol_controller.dart';
import 'package:prize_lottery_app/views/user/controller/agent_account_controller.dart';
import 'package:prize_lottery_app/views/user/controller/agent_income_controller.dart';
import 'package:prize_lottery_app/views/user/controller/invite_history_controller.dart';
import 'package:prize_lottery_app/views/user/controller/user_invite_controller.dart';

class UserInviteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserInviteController());
  }
}

class AgentApplyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AgentProtocolController());
  }
}

class InviteHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InviteHistoryController());
  }
}

class AgentAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AgentAccountController());
  }
}

class AgentIncomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AgentIncomeController());
  }
}
