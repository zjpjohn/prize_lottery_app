import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/views/pay/model/pay_channel.dart';

///
///
class PayChannelRepository {
  ///
  /// 支付渠道
  ///
  static Future<List<PayChannel>> payChannels() {
    return HttpRequest().get('/pay/channel/pay').then((value) {
      return (value.data as List).map((e) => PayChannel.fromJson(e)).toList();
    });
  }

  ///
  /// 提现支付渠道
  ///
  static Future<List<PayChannel>> withdrawChannels() {
    return HttpRequest().get('/pay/channel/withdraw').then((value) {
      return (value.data as List).map((e) => PayChannel.fromJson(e)).toList();
    });
  }
}
