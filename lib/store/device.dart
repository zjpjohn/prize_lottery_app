import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/store/model/device_info.dart';

class AppDevice extends GetxController {
  ///
  static AppDevice? _instance;

  late AndroidId _androidId;

  ///单例工厂
  factory AppDevice() {
    AppDevice._instance ??= Get.put<AppDevice>(AppDevice._initialize());
    return AppDevice._instance!;
  }

  //私有构造函数
  AppDevice._initialize() {
    _androidId = const AndroidId();
  }

  Future<DeviceInfo> deviceInfo() async {
    AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;
    return DeviceInfo(build: build);
  }

  Future<String?> deviceId() async {
    return await _androidId.getId();
  }
}
