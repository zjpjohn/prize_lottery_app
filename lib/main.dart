import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/app/app_controller.dart';
import 'package:prize_lottery_app/env/env_profile.dart';
import 'package:prize_lottery_app/resources/assets_cache.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/routes/observers.dart';
import 'package:prize_lottery_app/routes/pages.dart';
import 'package:prize_lottery_app/store/member.dart';
import 'package:prize_lottery_app/store/store.dart';
import 'package:prize_lottery_app/utils/page_route_transition.dart';
import 'package:prize_lottery_app/utils/screen_protect.dart';
import 'package:prize_lottery_app/utils/storage.dart';
import 'package:prize_lottery_app/views/app/not_found_view.dart';
import 'package:worker_manager/worker_manager.dart';

void main() async {
  ///
  /// 运行时初始化
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  ///初始化storage
  await Storage().initialize();

  ///
  ///应用仅竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  ///
  /// 主应用加载
  runApp(const MainApp());

  ///
  ///状态栏一体化
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  ///
  /// loading配置初始化
  loadingConfiguration();
}

///
/// easyLoading初始化
void loadingConfiguration() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 1200)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 32.0
    ..radius = 4.0
    ..lineWidth = 1.5
    ..userInteractions = false
    ..contentPadding = const EdgeInsets.symmetric(horizontal: 18, vertical: 12);
}

class MainApp extends StatefulWidget {
  ///
  ///
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context).copyWith(
      splashFactory: NoSplash.splashFactory,
      progressIndicatorTheme: ProgressIndicatorTheme.of(context)
          .copyWith(color: const Color(0xFFFF0033)),
    );
    return ScreenUtilInit(
      designSize: const Size(375, 760),
      builder: (context, child) => Intro(
        padding: EdgeInsets.all(6.w),
        borderRadius: BorderRadius.circular(10.w),
        maskColor: Colors.black.withAlpha(150),
        child: GetMaterialApp(
          title: '哇彩',
          theme: theme,
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          customTransition: PageRouteTransition(),
          transitionDuration: const Duration(milliseconds: 300),
          builder: EasyLoading.init(
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  boldText: false,
                  textScaler: TextScaler.noScaling,
                ),
                child: child!,
              );
            },
          ),
          getPages: AppPages.routes,
          initialRoute: AppRoutes.splash,
          routingCallback: RouteObservers.observer,
          unknownRoute: GetPage(
            name: AppRoutes.page404,
            page: () => const RouteUnknownView(),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    /// 应用资源管理加载图片资源
    ResourceStore().loadResource();

    /// 用户信息存储器初始化
    UserStore();

    ///APP应用控制器初始化注册
    AppController();

    ///初始化余额账户
    BalanceInstance();

    ///会员存储初始化
    MemberStore();

    /// 打开应用
    ConfigStore().openApp();

    /// 防止应用直接关掉禁止截屏为关掉，应用启动时设置关闭禁止截屏
    ScreenProtect.protectOff();

    ///线程初始化
    workerManager.log = Profile.props.debug;
    workerManager.init(isolatesCount: 2);

    ///第一帧渲染后初始化操作
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ///图片预缓存
      AssetsCache.preCacheImages(context);
    });
  }
}
