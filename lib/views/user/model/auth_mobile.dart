///
///
class AuthMobile {
  late String phone;
  late String nonceStr;
  late String signature;

  AuthMobile.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    nonceStr = json['nonceStr'];
    signature = json['signature'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['phone'] = phone;
    json['nonceStr'] = nonceStr;
    json['signature'] = signature;
    return json;
  }
}
