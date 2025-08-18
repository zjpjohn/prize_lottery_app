import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/app/app_controller.dart';
import 'package:prize_lottery_app/app/app_launcher.dart';
import 'package:prize_lottery_app/store/member.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/views/app/widget/upgrade_app_sheet.dart';

class MainController extends GetxController {
  ///
  /// 初始化下标
  int initialIndex = 0;

  ///
  /// [BottomNavigationBar] 当前下标
  ///
  late int _currentIndex;

  ///
  /// [BottomNavigationBar]页面控制器
  ///
  late PageController pageController;

  ///
  /// 上一次点击退出时间
  ///
  DateTime? lastTime;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    if (_currentIndex == index) {
      return;
    }
    _currentIndex = index;
    update();
    pageController.jumpToPage(index);
  }

  ///
  /// 手机回退键监听处理
  ///
  bool onPopScope() {
    DateTime current = DateTime.now();
    if (lastTime == null ||
        current.difference(lastTime!) > const Duration(seconds: 2)) {
      lastTime = current;
      EasyLoading.showToast('再按一次退出应用');
      return false;
    }
    return true;
  }

  @override
  void onInit() {
    super.onInit();
    _currentIndex = initialIndex;
    pageController = PageController(initialPage: _currentIndex);

    ///应用启动上报
    AppLauncher().launch();

    ///刷新账户会员
    MemberStore().refreshAuthed();

    ///延迟弹层显示
    Future.delayed(const Duration(seconds: 2), () {
      ///应用版本更新提醒弹层
      if (!AppController().latestVersion) {
        Constants.bottomSheet(
          const UpgradeAppSheet(),
          enableDrag: false,
          isDismissible: false,
        );
        return;
      }
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
