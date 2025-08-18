import 'package:prize_lottery_app/app/model/app_info.dart';
import 'package:prize_lottery_app/app/model/app_resource.dart';
import 'package:prize_lottery_app/app/model/app_verify.dart';
import 'package:prize_lottery_app/env/env_profile.dart';
import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/views/user/controller/feedback_controller.dart';

///
///
class AppInfoRepository {
  ///
  /// 获取应用详情
  static Future<AppInfoVo> getAppInfo({
    required String seqNo,
    required String version,
  }) {
    return HttpRequest().get('/lope/native/app/$seqNo/$version').then((value) {
      return AppInfoVo(
        appInfo: AppInfo.fromJson(value.data['appInfo']),
        current: AppVersion.fromJson(value.data['current']),
        main: MainVersion.fromJson(value.data['main']),
      );
    });
  }

  ///
  /// 查询应用
  static Future<Map<String, AppResource>> getAppResources(String appNo) {
    return HttpRequest().get('/lope/app/resource/$appNo').then((value) {
      Map<String, dynamic> json = value.data;
      return json.map(
        (key, value) => MapEntry(key, AppResource.fromJson(value)),
      );
    }).catchError((error) => Future<Map<String, AppResource>>.value({}));
  }

  ///
  /// 应用启动回调
  static Future<bool> appLauncher(Map<String, dynamic> params) {
    return HttpRequest()
        .post('/ucenter/app/launch', params: params)
        .then((value) => true);
  }

  ///
  /// 获取应用一键登录配置信息
  static Future<AuthVerify> getAppVerify() {
    return HttpRequest().get('/lope/uverify/', params: {
      'appNo': Profile.props.appNo
    }).then((value) => AuthVerify.fromJson(value.data));
  }

  ///
  /// 提交反馈信息
  static Future<void> submitFeedback(FeedbackInfo feedback) async {
    return HttpRequest()
        .postJson('/lope/app/feedback/', data: feedback.toJson())
        .then((value) => null);
  }

  ///
  /// 查询应用联系人列表
  static Future<List<AppContact>> appContacts(String appNo) {
    return HttpRequest().get('/lope/native/app/contact/list',
        params: {'appNo': appNo}).then((value) {
      return (value.data as List).map((e) => AppContact.fromJson(e)).toList();
    });
  }
}
