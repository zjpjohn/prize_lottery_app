import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/user/controller/user_invite_controller.dart';
import 'package:prize_lottery_app/views/user/model/user_agent_rule.dart';
import 'package:prize_lottery_app/views/user/repository/user_repository.dart';

class AgentProtocolController extends AbsRequestController {
  ///流量主规则集合
  List<UserAgentRule> rules = [];

  ///屏幕宽高尺寸比
  late double ratio;

  double get contentHeight {
    return 2.139 * 1.15 * Get.height / ratio;
  }

  @override
  Future<void> request() async {
    showLoading();
    UserInfoRepository.usingAgentRules().then((value) {
      rules
        ..clear()
        ..addAll(value);
      rules.sort((a, b) => a.agent.value.compareTo(b.agent.value));
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(rules);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  ///
  /// 申请成为流量主
  void agentApply() {
    EasyLoading.show(status: '正在申请');
    UserInfoRepository.agentApply().then((_) {
      ///申请成功后，刷新申请状态
      UserInviteController inviteController = Get.find<UserInviteController>();
      inviteController.applying();
    }).catchError((error) {
      EasyLoading.showToast(error.error.message);
    }).whenComplete(() {
      Future.delayed(const Duration(milliseconds: 300), () {
        EasyLoading.dismiss();

        ///返回邀请账户页面
        Get.back();
      });
    });
  }

  @override
  void initialBefore() {
    ratio = Get.height / Get.width;
  }
}
