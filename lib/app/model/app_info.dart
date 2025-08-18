///
///
///
class AppInfo {
  ///
  /// 应用标识
  String seqNo = '';

  ///
  /// 应用名称
  String name = '';

  ///
  /// 应用图标
  String logo = '';

  ///
  /// 应用版权
  String copyright = '';

  ///
  /// 应用联系方式
  String telephone = '';

  ///
  /// 应用地址
  String address = '';

  ///
  /// 备案信息
  String record = '';

  AppInfo.fromJson(Map<String, dynamic> json) {
    seqNo = json['seqNo'];
    name = json['name'];
    logo = json['logo'];
    copyright = json['copyright'];
    telephone = json['telephone'];
    address = json['address'];
    record = json['record'];
  }
}

///
/// 应用主推版本信息
class MainVersion {
  ///
  /// 版本信息
  String version = '';

  /// 全量安装包下载地址
  String apkUri = '';

  ///版本是否强制升级
  int force = 0;

  /// 分abi安装包下载地址集合
  Map<String, String> abiApks = {};

  /// 应用升级信息
  List<String> upgrades = [];

  MainVersion.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    apkUri = json['apkUri'];
    force = json['force'] ?? 0;
    abiApks = Map.from(json['abiApks'] ?? {}).cast<String, String>();
    upgrades = (json['upgrades'] ?? []).cast<String>();
  }
}

///
///
///  当前应用版本信息
class AppVersion {
  ///
  /// 版本信息
  String version = '';

  ///
  /// 应用描述信息
  String depiction = '';

  AppVersion.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    depiction = json['depiction'] ?? '';
  }
}

///
///
///
class AppInfoVo {
  ///
  /// 应用信息
  AppInfo appInfo;

  /// 当前版本
  AppVersion current;

  /// 主推版本
  MainVersion main;

  AppInfoVo({
    required this.appInfo,
    required this.current,
    required this.main,
  });
}

///
///
/// 联系人
class AppContact {
  ///应用标识
  late String appNo;

  ///联系人名称
  late String name;

  ///联系人微信二维码
  late String qrImg;

  ///联系人说明
  late String remark;

  AppContact.fromJson(Map<String, dynamic> json) {
    appNo = json['appNo'];
    name = json['name'];
    qrImg = json['qrImg'];
    remark = json['remark'] ?? '';
  }

}
