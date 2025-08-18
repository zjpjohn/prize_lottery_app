import 'package:flutter/material.dart';
import 'package:prize_lottery_app/views/user/model/user_agent_rule.dart';
import 'package:prize_lottery_app/views/user/model/user_invite.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/user/repository/user_repository.dart';

class UserInviteController extends AbsRequestController {
  /// 邀请账户信息
  late UserInvite invite;

  /// 流量主邀请规则
  late UserAgentRule rule;

  ///海报全局key
  final GlobalKey posterKey = GlobalKey();

  void applying() {
    invite.applying = 1;
    update();
  }

  @override
  Future<void> request() async {
    showLoading();

    /// 查询邀请账户及规则
    Future<void> inviteFuture = UserInfoRepository.userInvite().then((value) {
      invite = value;
    });
    Future<void> ruleFuture =
        UserInfoRepository.agentRule().then((value) => rule = value);

    ///
    Future.wait([inviteFuture, ruleFuture]).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(invite);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
