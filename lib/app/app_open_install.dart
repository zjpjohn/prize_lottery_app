import 'dart:convert';

import 'package:get/get.dart';
import 'package:openinstall_flutter_plugin/openinstall_flutter_plugin.dart';
import 'package:prize_lottery_app/store/config.dart';

class AppOpenInstall extends GetxController {
  ///
  late OpeninstallFlutterPlugin _openInstallPlugin;

  ///
  static AppOpenInstall? _instance;

  factory AppOpenInstall() {
    AppOpenInstall._instance ??=
        Get.put<AppOpenInstall>(AppOpenInstall._internal());
    return AppOpenInstall._instance!;
  }

  AppOpenInstall._internal() {
    _openInstallPlugin = OpeninstallFlutterPlugin();
    _openInstallPlugin.init(_wakeupHandle);
  }

  ///
  /// 唤醒拉起回调
  Future _wakeupHandle(Map<String, Object> data) async {}

  ///
  /// 应用安装参数处理
  void install() {
    ///第一次安装应用
    if (!ConfigStore().firstOpen) {
      return;
    }

    /// 获取应用安装渠道参数
    _openInstallPlugin.install((Map<String, Object> data) async {
      ///安装参数判断
      if (data['bindData'] == null) {
        return;
      }

      ///安装参数
      Map<String, dynamic> params = jsonDecode(data['bindData'].toString());

      ///注册渠道
      ConfigStore().channel = int.parse(params['channel'] ?? '3');

      ///注册邀请码
      ConfigStore().inviteCode = params['code'] ?? '';
    });
  }

  ///
  /// 注册统计
  void reportRegister() {
    _openInstallPlugin.reportRegister();
  }

  ///
  /// 效果点统计
  void reportEffect({required String point}) {
    _openInstallPlugin.reportEffectPoint(point, 1);
  }
}
