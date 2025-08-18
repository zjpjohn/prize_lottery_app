import 'package:package_info_plus/package_info_plus.dart';
import 'package:prize_lottery_app/app/app_repository.dart';
import 'package:prize_lottery_app/store/config.dart';
import 'package:prize_lottery_app/store/device.dart';
import 'package:prize_lottery_app/store/model/device_info.dart';

class AppLauncher {
  ///
  /// 启动应用实例
  static AppLauncher? _instance;

  ///
  ///标记应用本次是否上报
  bool launched = false;

  AppLauncher._initialise();

  factory AppLauncher() {
    AppLauncher._instance ??= AppLauncher._initialise();
    return AppLauncher._instance!;
  }

  ///
  /// 上报应用启动信息
  Future<void> launch() async {
    ///应用已启动,不在调用上报接口
    if (!launched) {
      try {
        String deviceId = (await AppDevice().deviceId())!;
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        DeviceInfo deviceInfo = await AppDevice().deviceInfo();
        var cmd = AppLauncherCmd(
          deviceId: deviceId,
          version: packageInfo.version,
          brand: deviceInfo.brand,
          manufacturer: deviceInfo.manufacturer,
          hardware: deviceInfo.hardware,
          sdkInt: deviceInfo.sdkInt,
          release: deviceInfo.release,
          fromCode: ConfigStore().inviteCode,
        );
        launched = await AppInfoRepository.appLauncher(cmd.toJson());
      } catch (_) {}
    }
  }
}

///
///
///
class AppLauncherCmd {
  late String deviceId;
  late String version;
  late String brand;
  late String manufacturer;
  late String hardware;
  late int sdkInt;
  late String release;
  late String fromCode;

  AppLauncherCmd({
    required this.deviceId,
    required this.version,
    required this.brand,
    required this.manufacturer,
    required this.hardware,
    required this.sdkInt,
    required this.release,
    this.fromCode = '',
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['deviceId'] = deviceId;
    json['version'] = version;
    json['brand'] = brand;
    json['manufacturer'] = manufacturer;
    json['hardware'] = hardware;
    json['sdkInt'] = sdkInt;
    json['release'] = release;
    json['fromCode'] = fromCode;
    return json;
  }
}
