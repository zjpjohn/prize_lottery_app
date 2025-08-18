import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/env/env_profile.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/store/balance.dart';
import 'package:prize_lottery_app/store/config.dart';
import 'package:prize_lottery_app/utils/storage.dart';
import 'package:prize_lottery_app/views/user/model/user_auth.dart';
import 'package:prize_lottery_app/views/user/model/user_balance.dart';
import 'package:prize_lottery_app/views/user/repository/user_repository.dart';

class UserStore extends GetxController {
  static UserStore? _instance;

  factory UserStore() {
    UserStore._instance ??= Get.put<UserStore>(UserStore._initialize());
    return UserStore._instance!;
  }

  UserStore._initialize();

  ///
  /// 账户信息
  AuthUser? _authUser;

  ///
  /// 授权token
  String _token = '';

  String get authToken {
    if (_token.isNotEmpty) {
      return _token;
    }
    _token = Storage().getString('authentication');
    return _token;
  }

  set authToken(String authToken) {
    if (authToken.isNotEmpty) {
      Storage().putString('authentication', authToken);
    } else {
      Storage().remove('authentication');
    }
    _token = authToken;
  }

  ///
  /// 获取用户邀请连接
  String get shareUri {
    AuthUser? user = authUser;
    if (user == null || user.inviteUri.isEmpty) {
      return Profile.props.shareUri;
    }
    return '${user.inviteUri}/${Profile.props.appNo}';
  }

  ///
  /// 授权用户信息
  AuthUser? get authUser {
    if (_authUser != null) {
      return _authUser;
    }
    Map? user = Storage().getObject('auth_user');
    if (user != null) {
      _authUser = AuthUser.fromJson(user);
      return _authUser;
    }
    return null;
  }

  ///
  /// 保存授权用户信息
  set authUser(AuthUser? authUser) {
    _authUser = authUser;
    update();
    if (authUser == null) {
      Storage().remove('auth_user');
      return;
    }
    Storage().putObject('auth_user', authUser);
  }

  ///
  /// 清除本地登录信息
  ///
  void removeLocalAuth() {
    if (ConfigStore().unAuthedRoute == null) {
      ///暂存当前未授权的页面
      Routing currentRoute = Get.routing;
      ConfigStore().unAuthedRoute = currentRoute;

      authToken = '';
      authUser = null;
      BalanceInstance().balance = UserBalance.fromJson({});

      /// 首页接口出现未授权情况
      if (currentRoute.current == AppRoutes.main) {
        Get.toNamed(AppRoutes.login);
        return;
      }

      /// 非首页接口出现未授权登陆情况
      Get.offNamed(AppRoutes.login);
    }
  }

  ///
  /// 退出登录，退出成功后清除本地登录信息
  ///
  void loginOut() {
    EasyLoading.show(status: '正在退出');
    UserInfoRepository.loginOut().then((_) => Get.back()).whenComplete(() {
      EasyLoading.dismiss();
      authToken = '';
      authUser = null;
      BalanceInstance().balance = UserBalance.fromJson({});
    });
  }
}
