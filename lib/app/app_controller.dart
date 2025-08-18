import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prize_lottery_app/app/app_repository.dart';
import 'package:prize_lottery_app/env/env_profile.dart';
import 'package:prize_lottery_app/env/log_profile.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:r_upgrade/r_upgrade.dart';

import 'model/app_info.dart';

///
///
class AppController extends GetxController {
  ///
  ///
  AppInfoVo? appInfo;

  ///
  /// 是否是最新版本
  bool latestVersion = true;

  ///
  /// 应用联系人
  List<AppContact> contacts = [];

  ///
  static AppController? _instance;

  factory AppController() {
    AppController._instance ??=
        Get.put<AppController>(AppController._initialize(), permanent: true);
    return AppController._instance!;
  }

  AppController._initialize();

  String get appVersion {
    return appInfo?.current.version ?? '';
  }

  void getContacts() async {
    if (contacts.isNotEmpty) {
      return;
    }
    try {
      contacts = await AppInfoRepository.appContacts(Profile.props.appNo);
    } catch (e) {
      logger.e(e);
    }
  }

  ///
  /// 应用信息
  ///
  void getAppInfo({bool showLoading = false}) async {
    if (showLoading) {
      EasyLoading.show(status: '加载中');
    }
    try {
      ///
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      appInfo = await AppInfoRepository.getAppInfo(
        seqNo: Profile.props.appNo,
        version: packageInfo.version,
      );

      ///最新版本判断
      isLatestVersion();
    } finally {
      if (showLoading && EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
    }
  }

  ///
  /// 应用包信息
  Future<PackageInfo> packageInfo() async {
    return PackageInfo.fromPlatform();
  }

  ///
  /// 应用是否为最新版本
  ///
  void isLatestVersion() {
    if (appInfo != null) {
      latestVersion =
          Tools.version(appInfo!.current.version, appInfo!.main.version) >= 0;
    }
  }

  ///
  /// 应用升级存储权限获取
  ///
  Future<bool> _storagePermission() async {
    if (await Permission.storage.isGranted) {
      return true;
    }
    PermissionStatus status = await Permission.storage.request();
    return status.isGranted;
  }

  ///
  /// 应用升级
  ///
  Future<void> upgrade() async {
    if (latestVersion) {
      return;
    }
    if (!await _storagePermission()) {
      EasyLoading.showToast('您已拒绝授权，无法下载更新版本');
      return;
    }

    ///全量包
    String apkUri = appInfo!.main.apkUri;

    ///v8a 64位包
    String? abiApkUri = appInfo!.main.abiApks['arm64-v8a'];
    if (abiApkUri != null) {
      apkUri = abiApkUri;
    }
    if (apkUri.isNotEmpty) {
      String fileName = apkUri.substring(
        apkUri.lastIndexOf("/") + 1,
        apkUri.length,
      );
      RUpgrade.upgrade(
        apkUri,
        fileName: fileName,
        useDownloadManager: true,
        notificationStyle: NotificationStyle.speechAndPlanTime,
      );
      EasyLoading.showToast('最新版本正在下载，请耐心等待');
    }
  }

  @override
  void onInit() {
    super.onInit();

    ///应用信息
    getAppInfo();

    ///应用联系人
    getContacts();
  }
}
