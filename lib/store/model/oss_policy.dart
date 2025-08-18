import 'package:dio/dio.dart';

class OssPolicy {
  String dir = '';
  String policy = '';
  String appId = '';
  String signature = '';
  String domain = '';
  String host = '';
  String callback = '';
  int expire = 0;

  OssPolicy.fromJson(Map json) {
    dir = json['dir'];
    policy = json['policy'];
    signature = json['signature'];
    appId = json['appId'];
    domain = json['domain'];
    host = json['host'];
    callback = json['callback'];
    expire = int.parse(json['expire']);
  }

  Map toJson() {
    Map json = {};
    json['dir'] = dir;
    json['policy'] = policy;
    json['signature'] = signature;
    json['appId'] = appId;
    json['domain'] = domain;
    json['host'] = host;
    json['callback'] = callback;
    json['expire'] = expire.toString();
    return json;
  }

  FormData toFormData({
    required MultipartFile file,
    required String name,
    String prefixDir = '',
  }) {
    return FormData.fromMap({
      'OSSAccessKeyId': appId,
      'key': dir + prefixDir + name,
      'policy': policy,
      'signature': signature,
      'success_action_status': 200,
      'callback': callback,
      'file': file,
    });
  }
}
