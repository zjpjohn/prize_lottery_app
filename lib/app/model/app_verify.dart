///
/// 应用
///
class AuthVerify {
  late String appNo;
  late String authKey;
  late String success;
  late String cancel;
  late String downgrades;

  AuthVerify.fromJson(Map<String, dynamic> json) {
    appNo = json['appNo'];
    authKey = json['authKey'];
    success = json['success'];
    cancel = json['cancel'];
    downgrades = json['downgrades'];
  }

  Map<String, dynamic> toJson() {
    return {
      'appNo': appNo,
      'authKey': authKey,
      'success': success,
      'cancel': cancel,
      'downgrades': downgrades,
    };
  }
}
