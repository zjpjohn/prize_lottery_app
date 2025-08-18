import 'package:prize_lottery_app/base/model/page_result.dart';
import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/views/pay/model/pay_order.dart';

///
/// 订单支付信息
class PayOrderRepository {
  ///
  /// 会员下单接口
  ///
  static Future<UnionOrder> memberPay(
      {required String packNo, required String channel}) {
    return HttpRequest().post('/pay/order/member', params: {
      'packNo': packNo,
      'channel': channel
    }).then((value) => UnionOrder.fromJson(value.data));
  }

  ///
  /// 待支付订单重新发起支付
  ///
  static Future<UnionOrder> repayOrder(String orderNo) {
    return HttpRequest().post('/pay/order/repay', params: {
      'orderNo': orderNo
    }).then((value) => UnionOrder.fromJson(value.data));
  }

  ///
  /// 查询指定订单类型的待支付订单编号
  ///
  static Future<String> waitPayOrder(int type) {
    return HttpRequest().get('/pay/order/waiting',
        params: {'type': type}).then((value) => value.data);
  }

  ///
  /// 查询订单详情
  ///
  static Future<OrderInfo> orderDetail(String orderNo) {
    return HttpRequest().get('/pay/order/', params: {'orderNo': orderNo}).then(
        (value) => OrderInfo.fromJson(value.data));
  }

  ///
  /// 分页查询用户订单列表
  ///
  static Future<PageResult<OrderInfo>> orderList(
      {required int type, int page = 1, int limit = 10}) {
    return HttpRequest().get('/pay/order/list', params: {
      'type': type,
      'page': page,
      'limit': limit
    }).then((value) => PageResult.fromJson(
          json: value.data,
          handle: (data) => OrderInfo.fromJson(data),
        ));
  }

}
