import 'package:device_info_plus/device_info_plus.dart';

///
///
class DeviceInfo {
  late String brand;
  late String manufacturer;
  late String deviceId;
  late int sdkInt;
  late String release;
  late String fingerprint;
  late String hardware;
  late List<String?> abis;

  DeviceInfo({required AndroidDeviceInfo build}) {
    brand = build.brand;
    manufacturer = build.manufacturer;
    deviceId = build.id;
    sdkInt = build.version.sdkInt;
    release = build.version.release;
    fingerprint = build.fingerprint;
    hardware = build.hardware;
    abis = build.supportedAbis;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['brand'] = brand;
    json['manufacturer'] = manufacturer;
    json['deviceId'] = deviceId;
    json['sdkInt'] = sdkInt;
    json['release'] = release;
    json['fingerprint'] = fingerprint;
    json['hardware'] = hardware;
    json['abis'] = abis;
    return json;
  }

  String get device {
    return '$brand;$release;$manufacturer;$hardware;$sdkInt;$abis';
  }

}
