///
/// 支付渠道
class PayChannel {
  late String name;
  late String channel;
  late String cover;
  late String icon;
  late int priority;

  PayChannel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    channel = json['channel'];
    cover = json['cover'];
    icon = json['icon'];
    priority = json['priority'];
  }
}
