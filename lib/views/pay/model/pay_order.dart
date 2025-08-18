import 'package:prize_lottery_app/base/model/enum_value.dart';

///
///
class UnionOrder {
  late String orderNo;
  late EnumValue channel;
  AliPayOrder? aliOrder;
  WxPayOrder? wxOrder;

  UnionOrder.fromJson(Map<String, dynamic> json) {
    orderNo = json['orderNo'];
    channel = EnumValue.fromJson(json['channel']);
    if (json['aliOrder'] != null) {
      aliOrder = AliPayOrder.fromJson(json['aliOrder']);
    }
    if (json['wxOrder'] != null) {
      wxOrder = WxPayOrder.fromJson(json['wxOrder']);
    }
  }
}

/// 支付宝预支付信息
class AliPayOrder {
  late String order;
  late String platform;
  late int environment;

  AliPayOrder.fromJson(Map<String, dynamic> json) {
    order = json['order'];
    platform = json['platform'];
    environment = json['environment'];
  }
}

/// 微信支付预支付信息
class WxPayOrder {
  late String appId;
  late String partnerId;
  late String prepayId;
  late String packValue;
  late String nonceStr;
  late String sign;
  late String timestamp;

  WxPayOrder.fromJson(Map<String, dynamic> json) {
    appId = json['appId'];
    partnerId = json['partnerId'];
    prepayId = json['prepayId'];
    packValue = json['packValue'];
    nonceStr = json['nonceStr'];
    sign = json['sign'];
    timestamp = json['timestamp'];
  }
}

///
///
class OrderInfo {
  late String bizNo;
  late int userId;
  late EnumValue type;
  late int stdPrice;
  late int realPrice;
  late int quantity;
  late int amount;
  late EnumValue channel;
  late String remark;
  late String attach;
  late Map<String, dynamic> content;
  late EnumValue state;
  late int settled;
  late String gmtCreate;
  late String expireTime;
  late String payTime;
  late String closeTime;

  OrderInfo.fromJson(Map<String, dynamic> json) {
    bizNo = json['bizNo'];
    userId = int.parse(json['userId']);
    type = EnumValue.fromJson(json['type']);
    stdPrice = int.parse(json['stdPrice']);
    realPrice = int.parse(json['realPrice']);
    quantity = json['quantity'];
    amount = int.parse(json['amount']);
    channel = EnumValue.fromJson(json['channel']);
    remark = json['remark'];
    attach = json['attach'];
    content = json['content'];
    state = EnumValue.fromJson(json['state']);
    settled = json['settled'];
    gmtCreate = json['gmtCreate'];
    expireTime = json['expireTime'];
    payTime = json['payTime'] ?? '';
    closeTime = json['closeTime'] ?? '';
  }
}
