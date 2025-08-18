import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/resources/styles.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/store/config.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: UiStyle.light,
      child: Scaffold(
        body: Image.asset(
          R.splash,
          fit: BoxFit.fill,
          width: Get.width,
          height: Get.height,
        ),
      ),
    );
  }

  Widget _dialogTransitionBuilder(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.linear,
        reverseCurve: Curves.linear,
      ),
      child: child,
    );
  }

  void showAgreeProtocol() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: false,
      transitionBuilder: _dialogTransitionBuilder,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) async {},
          child: Center(
            child: Container(
              width: 300.w,
              height: 460.w,
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.w,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.w),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 12.w),
                        child: Text(
                          '用户协议与隐私政策',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 180.w,
                        child: ScrollConfiguration(
                          behavior: CustomScrollBehavior(),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 12.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 4.w),
                                        child: Text(
                                          '欢迎使用哇彩应用',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 2.w),
                                        child: Text(
                                          '1、为了您能安全便捷地使用哇彩应用，我们将会申请手机设备信息权限'
                                          '以收集移动网络信息，用于识别设备进行安全管理。',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 2.w),
                                        child: Text(
                                          '2、在您同意App隐私政策后，我们将进行集成SDK的初始化工作，'
                                          '会收集您的IP、IMSI、IMEI设备序列号以及手机号，以保障App正常运行和安全管理。',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '3、未经您的同意，我们不会从第三方获取、共享或对外提供您的信息。',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(vertical: 8.w),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 13.sp,
                            ),
                            children: [
                              const TextSpan(
                                text: '您可以阅读完整版',
                              ),
                              TextSpan(
                                text: '《使用协议》',
                                style: const TextStyle(
                                  color: Color(0xFFFF6005),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed(AppRoutes.usage);
                                  },
                              ),
                              const TextSpan(
                                text: '和',
                              ),
                              TextSpan(
                                text: '《隐私政策》',
                                style: const TextStyle(
                                  color: Color(0xFFFF6005),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed(AppRoutes.privacy);
                                  },
                              ),
                              const TextSpan(
                                text: '来了解详细信息。',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 12.w),
                        child: Text(
                          '点击同意即表示您已充分阅读、理解并接受上述协议的全部内容',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          agreeAppProtocol();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 10.w),
                          margin: EdgeInsets.only(
                            bottom: 16.w,
                            left: 16.w,
                            right: 16.w,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF6005),
                            borderRadius: BorderRadius.circular(20.w),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFF6005)
                                    .withValues(alpha: 0.4),
                                offset: const Offset(4, 4),
                                blurRadius: 8,
                                spreadRadius: 0.0,
                              )
                            ],
                          ),
                          child: Text(
                            '同意',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          disAgreeAppProtocol();
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 10.w),
                          margin: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(20.w),
                          ),
                          child: Text(
                            '拒绝并退出',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.black45,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void agreeAppProtocol() {
    ConfigStore().agree = 1;
    Get.offAllNamed(AppRoutes.main);
  }

  void disAgreeAppProtocol() {
    ConfigStore().agree = 0;
    SystemNavigator.pop();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 30), () {
        FlutterNativeSplash.remove();
        if (ConfigStore().agree == 0) {
          showAgreeProtocol();
          return;
        }
        Get.offAllNamed(AppRoutes.main);
      });
    });
  }
}
