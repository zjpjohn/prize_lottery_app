import 'package:ali_auth/ali_auth.dart';
import 'package:prize_lottery_app/app/app_repository.dart';
import 'package:prize_lottery_app/app/model/app_verify.dart';
import 'package:prize_lottery_app/env/log_profile.dart';

class QuickPhoneAuth {
  ///
  /// 单例
  static QuickPhoneAuth? _instance;

  factory QuickPhoneAuth() {
    _instance ??= QuickPhoneAuth._initialize();
    return _instance!;
  }

  QuickPhoneAuth._initialize();

  ///
  ///
  AuthVerify? verify;

  ///
  ///
  Future<AliAuthModel> _authConfig() async {
    return AliAuthModel(
      verify!.authKey,
      null,
      pageType: PageType.dialogBottom,
      dialogBottom: true,
      dialogHeight: 300,
      dialogAlpha: 0.50,
      navColor: "#ffffff",
      navText: '快捷登录',
      navTextColor: "#333333",
      navTextSize: 16,
      navReturnImgWidth: 24,
      navReturnImgHeight: 14,
      navReturnScaleType: ScaleType.centerInside,
      navReturnHidden: true,
      navReturnImgPath: 'assets/images/icon_close.png',
      sloganTextColor: "#333333",
      sloganTextSize: 16,
      sloganOffsetY: 24,
      sloganText: '欢迎使用哇彩应用',
      numFieldOffsetY: 50,
      numberSize: 24,
      logBtnOffsetY: 160,
      logBtnText: '一键登录',
      logBtnTextColor: '#ffffff',
      logBtnTextSize: 16,
      logBtnHeight: 40,
      logBtnMarginLeftAndRight: 40,
      switchAccHidden: true,
      bottomNavColor: "#ffffff",
      webViewStatusBarColor: "#ffffff",
      webNavColor: "#ffffff",
      webNavTextColor: "#333333",
      webNavTextSize: 16,
      webNavReturnImgPath: 'assets/images/icon_close.png',
      privacyState: false,
      protocolGravity: Gravity.left,
      privacyTextSize: 11,
      privacyMargin: 28,
      privacyOffsetY: 100,
      vendorPrivacyPrefix: '《',
      vendorPrivacySuffix: '》',
      protocolOneName: "《哇彩用户协议》",
      protocolOneURL: "https://image.icaiwa.com/protocols/usage.html",
      protocolTwoName: "《用户隐私》",
      protocolTwoURL: "https://image.icaiwa.com/protocols/privacy.html",
      protocolColor: "#3c3c3c",
      protocolCustomColor: "#448AFF",
      privacyBefore: '阅读并同意',
      privacyEnd: '哇彩应用相关使用及隐私政策',
      checkboxHidden: false,
      checkedImgPath: 'assets/images/checked.png',
      uncheckedImgPath: 'assets/images/unchecked.png',
    );
  }

  void _authListen(Function(String) handle) {
    AliAuth.loginListen(
      onEvent: (event) async {
        logger.i(event);
        if (event == null || event['code'] == null) {
          return;
        }

        ///取消授权
        if (verify!.cancel.contains(event['code'])) {
          AliAuth.quitPage();
          return;
        }

        ///授权成功获取到token
        if (verify!.success.contains(event['code'])) {
          handle(event['data']);
          return;
        }
      },
      onError: (error) {
        logger.e('aliyun quick auth error.', error: error);
        return;
      },
    );
  }

  ///
  /// 触发快捷登录
  Future<dynamic> authLogin(Function(String) handler) async {
    ///
    ///获取一键登录配置
    try {
      verify ??= await AppInfoRepository.getAppVerify();
    } catch (_) {}

    ///不存在一键登录，降级到短信验证码登录
    if (verify == null) {
      return;
    }

    ///授权回调处理
    _authListen((token) => handler(token));

    ///初始化一键登录SDK
    await AliAuth.initSdk(await _authConfig());
  }
}
