import 'package:screen_protector/screen_protector.dart';

class ScreenProtect {
  ///
  /// 开启数据保护
  static void protectOn() async {
    await ScreenProtector.preventScreenshotOn();
  }

  ///
  /// 关闭数据保护
  static void protectOff() async {
    await ScreenProtector.preventScreenshotOff();
  }
}
