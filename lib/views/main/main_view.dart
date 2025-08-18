import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/app/app_open_install.dart';
import 'package:prize_lottery_app/env/log_profile.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/resources/styles.dart';
import 'package:prize_lottery_app/views/home/pages/home_center_view.dart';
import 'package:prize_lottery_app/views/lottery/pages/lottery_center_view.dart';
import 'package:prize_lottery_app/views/main/main_controller.dart';
import 'package:prize_lottery_app/views/master/pages/master_center_view.dart';
import 'package:prize_lottery_app/views/user/pages/user_center_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with WidgetsBindingObserver {
  ///
  /// 首页页面集合
  ///
  final pages = [
    const HomeCenterView(),
    const LotteryCenterView(),
    const MasterCenterView(),
    const UserCenterView(),
  ];

  ///
  /// [BottomNavigationBarItem]集合
  ///
  List<BottomNavigationBarItem> _buildBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Image.asset(R.home, width: 25, height: 25),
        activeIcon: Image.asset(R.homeOn, width: 25, height: 25),
        label: '首页',
      ),
      BottomNavigationBarItem(
        icon: Image.asset(R.lottery, width: 25, height: 25),
        activeIcon: Image.asset(R.lotteryOn, width: 25, height: 25),
        label: '开奖',
      ),
      BottomNavigationBarItem(
        icon: Image.asset(R.master, width: 25, height: 25),
        activeIcon: Image.asset(R.masterOn, width: 25, height: 25),
        label: '专家',
      ),
      BottomNavigationBarItem(
        icon: Image.asset(R.ucenter, width: 25, height: 25),
        activeIcon: Image.asset(R.ucenterOn, width: 25, height: 25),
        label: '我的',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    MainController controller = Get.find<MainController>();
    return AnnotatedRegion(
      value: UiStyle.light,
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) {
            return;
          }
          if (controller.onPopScope()) {
            SystemNavigator.pop();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.pageController,
            itemCount: pages.length,
            itemBuilder: (context, index) => pages[index],
            onPageChanged: (index) {
              controller.currentIndex = index;
            },
          ),
          bottomNavigationBar: GetBuilder<MainController>(builder: (_) {
            return BottomNavigationBar(
              items: _buildBarItems(),
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              currentIndex: controller.currentIndex,
              selectedItemColor: const Color(0xFFFD4A68),
              unselectedItemColor: const Color(0xFF9F9F9F),
              iconSize: 22.0,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              onTap: (index) {
                controller.currentIndex = index;
              },
            );
          }),
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    logger.i('app life state [$state],current route ${Get.currentRoute}');
  }

  @override
  void initState() {
    super.initState();

    ///应用监听
    WidgetsBinding.instance.addObserver(this);

    ///应用安装渠道参数
    AppOpenInstall();

    ///主页面加载后获取安装参数
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ///应用安装渠道参数
      AppOpenInstall().install();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
