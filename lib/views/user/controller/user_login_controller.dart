import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/store/device.dart';
import 'package:prize_lottery_app/store/member.dart';
import 'package:prize_lottery_app/store/store.dart';
import 'package:prize_lottery_app/utils/quick_phone_auth.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/user/model/auth_mobile.dart';
import 'package:prize_lottery_app/views/user/model/user_auth.dart';
import 'package:prize_lottery_app/views/user/repository/user_repository.dart';
import 'package:prize_lottery_app/widgets/countdown_widget.dart';

class UserLoginController extends GetxController {
  ///
  ///
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ///
  ///
  final GlobalKey<FormFieldState> phoneKey = GlobalKey<FormFieldState>();

  ///
  ///手机号输入控制器
  TextEditingController phoneController = TextEditingController();

  ///
  /// 验证码输入控制器
  TextEditingController codeController = TextEditingController();

  ///
  /// 登录方式:1-验证码登录,3-密码登录
  int _loginType = 1;

  ///
  ///手机号
  late String phone;

  ///
  ///验证码
  late String code;

  ///
  /// 登录密码
  late String password;

  ///
  /// 是否显示密码
  bool _showPassword = false;

  ///
  /// 是否同意使用协议
  bool _agree = true;

  set agree(bool value) {
    _agree = value;
    update();
  }

  bool get agree => _agree;

  set loginType(int value) {
    _loginType = value;
    update();
  }

  int get loginType => _loginType;

  set showPassword(bool value) {
    _showPassword = value;
    update();
  }

  bool get showPassword => _showPassword;

  @override
  void onInit() {
    super.onInit();
    triggerQuickAuth();
  }

  ///
  ///触发快捷登录
  void triggerQuickAuth() {
    QuickPhoneAuth().authLogin((token) => quickAuth(token));
  }

  ///
  /// 手机号快捷登录
  Future<void> quickAuth(String token) async {
    ///
    EasyLoading.show(status: '正在登陆');
    bool authed = false;
    try {
      ///获取设备id
      String deviceId = (await AppDevice().deviceId())!;

      ///获取授权登录手机号
      AuthMobile authMobile = await UserInfoRepository.authMobile(token);

      ///授权手机号换取登录信息
      AuthInfo authInfo = await UserInfoRepository.quickAuth(
        deviceId: deviceId,
        phone: authMobile.phone,
        nonceStr: authMobile.nonceStr,
        signature: authMobile.signature,
        channel: ConfigStore().channel,
        invCode: ConfigStore().inviteCode,
      );

      ///保存登录信息
      UserStore().authToken = authInfo.token;
      UserStore().authUser = authInfo.user;
      authed = true;
    } catch (e) {
      ///登陆失败错误处理
      EasyLoading.showToast('登陆失败');
    }

    ///登录页面回退
    Get.back();

    ///延迟关闭loading
    Future.delayed(const Duration(milliseconds: 200), () {
      authAfterHandle(authed);
    });
  }

  ///
  /// 前置校验
  bool beforeHandle() {
    FormState? state = formKey.currentState;
    if (state == null || !state.validate()) {
      return false;
    }
    if (!agree) {
      EasyLoading.showToast('请同意使用协议');
      return false;
    }
    state.save();
    return true;
  }

  ///
  /// 用户登录
  Future<void> loginAction() async {
    EasyLoading.show(status: '正在登陆');
    bool authed = false;
    try {
      late AuthInfo authResult;

      ///获取设备id
      String deviceId = (await AppDevice().deviceId())!;
      if (loginType == 1) {
        authResult = await UserInfoRepository.authLogin(
          deviceId: deviceId,
          phone: phone,
          code: code,
          channel: ConfigStore().channel,
          invCode: ConfigStore().inviteCode,
        );
      } else {
        authResult = await UserInfoRepository.pwdAuth(
          deviceId: deviceId,
          phone: phone,
          password: password,
          channel: ConfigStore().channel,
        );
      }

      ///保存登录信息
      UserStore().authToken = authResult.token;
      UserStore().authUser = authResult.user;

      authed = true;
    } catch (error) {
      EasyLoading.showToast('登陆失败');
    }

    ///登录页面回退
    Get.back();

    ///延迟关闭loading
    Future.delayed(const Duration(milliseconds: 100), () {
      authAfterHandle(authed);
    });
  }

  void authAfterHandle(bool success) {
    ///关闭loading
    EasyLoading.dismiss();

    ///授权成功后跳转上一次授权失败的页面
    Routing? jumpRout = ConfigStore().unAuthedRoute;

    ///登录成功刷新相关配置
    if (success) {
      ///授权成功后跳转到上一次授权失败的页面
      if (jumpRout != null && jumpRout.current != AppRoutes.main) {
        Get.toNamed(jumpRout.current, arguments: jumpRout.args);
      }

      ///刷新余额账户
      BalanceInstance().refreshBalance();

      ///刷新账户会员信息
      MemberStore().refreshMember();
    }

    ///清空上一次未登录页面
    ConfigStore().unAuthedRoute = null;
  }

  ///
  /// 发送短信验证码
  Future<SmsState> sendSms() async {
    FormFieldState? phoneState = phoneKey.currentState;
    if (phoneState != null && phoneState.validate()) {
      return await UserInfoRepository.sendSms(
              phone: phoneState.value, channel: 'login')
          .then((value) => SmsState.success)
          .catchError((error) => SmsState.error);
    }
    return SmsState.empty;
  }

  String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return '手机号不允许为空';
    }
    if (!Tools.phone(phone)) {
      return '手机号格式错误';
    }
    return null;
  }

  String? validateCode(String? code) {
    if (code == null || code.isEmpty) {
      return '验证码为空';
    }
    return null;
  }

  String? validatePwd(String? password) {
    if (password == null || password.isEmpty) {
      return '登录密码为空';
    }
    if (!Tools.password(password)) {
      return '密码格式错误';
    }
    return null;
  }
}
