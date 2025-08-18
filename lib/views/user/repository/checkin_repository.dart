import 'package:prize_lottery_app/base/model/page_result.dart';
import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/views/user/model/sign_info.dart';

///
///
class CheckInRepository {
  ///
  /// 用户签到
  static Future<SignResult> userSign() {
    return HttpRequest()
        .post('/ucenter/app/sign/')
        .then((value) => SignResult.fromJson(value.data));
  }

  ///
  /// 查询签到信息
  static Future<SignInfo> querySignInfo() {
    return HttpRequest()
        .get('/ucenter/app/sign/')
        .then((value) => SignInfo.fromJson(value.data));
  }

  ///
  /// 查询签到日志
  static Future<PageResult<SignLog>> querySignLogs(
      Map<String, dynamic> params) {
    return HttpRequest()
        .get('/ucenter/app/sign/logs', params: params)
        .then((value) => PageResult.fromJson(
              json: value.data,
              handle: (value) => SignLog.fromJson(value),
            ));
  }
}
