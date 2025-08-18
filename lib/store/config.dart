import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:prize_lottery_app/env/env_profile.dart';
import 'package:prize_lottery_app/env/log_profile.dart';
import 'package:prize_lottery_app/store/model/history_model.dart';
import 'package:prize_lottery_app/store/model/oss_policy.dart';
import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/utils/storage.dart';

///浏览历史Key
const browseHistoryKey = 'browse_history';

///应用打开Key
const deviceOpenKey = 'device_open_key';

///oss policy key
const ossPolicyKey = 'cloud_oss_policy';

/// 搜索历史key
const historyKey = 'lotto_search_history';

///日历提醒key
const hintCalendarKey = 'lotto_hint_calendar';

///应用协议同意标识key
const appAgreeKey = 'wacai_agree_key';

///用户授权key
const authUserKey = "auth_user_key";

///用户引导key
const introKey = "user_intro_key";

///
///
class ConfigStore extends GetxController {
  ///
  static ConfigStore? _instance;

  factory ConfigStore() {
    ConfigStore._instance ??= Get.put<ConfigStore>(ConfigStore._initialize());
    return ConfigStore._instance!;
  }

  ConfigStore._initialize();

  ///
  ///历史跳转信息
  HistoryInfo? history;

  ///
  /// oss文件上传信息
  OssPolicy? policy;

  ///
  /// 当前未授权登录的页面
  Routing? _unAuthedRoute;

  ///应用使用协议
  int? _agree;

  ///设置用户授权key
  set authKey(String authKey) {
    Storage().putString(authUserKey, authKey);
  }

  ///获取用户授权key
  String get authKey => Storage().getString(authUserKey);

  int get intro => Storage().getInt(introKey);

  void incrIntro() {
    int value = Storage().getInt(introKey) + 1;
    Storage().putInt(introKey, value);
  }

  set agree(int value) {
    _agree = value;
    Storage().putInt(appAgreeKey, value);
    update();
  }

  int get agree {
    _agree ??= Storage().getInt(appAgreeKey);
    return _agree!;
  }

  Routing? get unAuthedRoute => _unAuthedRoute;

  set unAuthedRoute(Routing? route) {
    if (route == null) {
      _unAuthedRoute = null;
      return;
    }
    _unAuthedRoute = Routing(
      current: route.current,
      args: route.args,
      route: route.route,
    );
  }

  ///
  /// 当前应用状态
  AppLifecycleState _appState = AppLifecycleState.resumed;

  ///应用包信息
  PackageInfo? _platform;

  ///
  /// 查询日历提醒事件标识
  String get calendarHintEvent {
    return Storage().getString(hintCalendarKey);
  }

  ///
  /// 保存日历提醒事件标识
  set calendarHintEvent(String eventId) {
    Storage().putString(hintCalendarKey, eventId);
  }

  ///设置应用状态
  set appState(AppLifecycleState appState) {
    _appState = appState;
    update();
  }

  AppLifecycleState get appState => _appState;

  set ossPolicy(OssPolicy? ossPolicy) {
    policy = ossPolicy;
    if (ossPolicy != null) {
      Storage().putObject(ossPolicyKey, ossPolicy);
    }
  }

  OssPolicy? get ossPolicy {
    if (policy == null) {
      Map? data = Storage().getObject(ossPolicyKey);
      if (data != null) {
        policy = OssPolicy.fromJson(data);
      }
    }
    return policy;
  }

  Future<OssPolicy?> getOssPolicy() async {
    OssPolicy? getPolicy = ossPolicy;
    if (getPolicy == null ||
        getPolicy.expire <= DateTime.now().millisecondsSinceEpoch) {
      try {
        getPolicy = await HttpRequest().get(
          '/lope/oss/policy',
          params: {'dir': 'app_lotto_${Profile.props.env}'},
        ).then((value) => OssPolicy.fromJson(value.data));
        ossPolicy = getPolicy;
      } catch (error) {
        logger.e('load oss policy error.', error: error);
        EasyLoading.showToast('获取签名错误');
      }
    }
    return getPolicy;
  }

  String get version => _platform?.version ?? '';

  String get inviteCode {
    return Storage().getString('user_invite');
  }

  set inviteCode(String inviteCode) {
    Storage().putString('user_invite', inviteCode);
  }

  int get channel {
    return Storage().getInt('user_channel', defValue: 3);
  }

  set channel(int channel) {
    Storage().putInt('user_channel', channel);
  }

  void clearSearchHistories() {
    Storage().remove(historyKey);
  }

  ///
  /// 获取本地搜索历史列表
  List<String> getSearchHistories() {
    String histories = Storage().getString(historyKey);
    if (histories.isEmpty) {
      return [];
    }
    return histories.split(";").reversed.toList();
  }

  ///
  /// 本地保存搜索历史
  void saveSearchHistories(List<String> histories) {
    String history = histories.reversed.toList().join(";");
    Storage().putString(historyKey, history);
  }

  ///设置最新浏览记录
  void saveHistory({String? remark}) {
    Routing routing = Get.routing;
    history = HistoryInfo(routing.current, routing.args, remark);
    Storage().putObject(browseHistoryKey, history!);
  }

  Future<void> getPlatform() async {
    _platform = await PackageInfo.fromPlatform();
  }

  ///
  /// 判断第一次打开应用
  bool get firstOpen {
    return Storage().getInt(deviceOpenKey) <= 1;
  }

  ///
  /// 获取应用打开次数
  int get openTimes => Storage().getInt(deviceOpenKey);

  ///
  /// 打开应用
  void openApp() {
    int value = Storage().getInt(deviceOpenKey, defValue: 0) + 1;
    Storage().putInt(deviceOpenKey, value);
  }

  @override
  void onInit() {
    super.onInit();

    ///获取应用包信息
    getPlatform();

    ///浏览历史
    history = Storage().getObj(
      browseHistoryKey,
      (v) => HistoryInfo.fromJson(v),
    );
  }
}
