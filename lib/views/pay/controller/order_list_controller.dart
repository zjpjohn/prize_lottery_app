import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/views/pay/model/pay_order.dart';
import 'package:prize_lottery_app/views/pay/repository/order_repository.dart';

class OrderListController extends AbsPageQueryController {
  ///订单类型
  final int type;

  ///分页信息
  int page = 1, limit = 10, total = 0;
  List<OrderInfo> records = [];

  OrderListController(this.type);

  @override
  Future<void> onInitial() async {
    showLoading();
    PayOrderRepository.orderList(
      type: type,
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      records
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(records);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {
    if (records.length >= total) {
      EasyLoading.showToast('没有更多记录');
      return;
    }
    page++;
    await PayOrderRepository.orderList(
      type: type,
      page: page,
      limit: limit,
    ).then((value) {
      records.addAll(value.records);
      update();
    }).catchError((error) {
      page--;
    });
  }

  @override
  Future<void> onRefresh() async {
    page = 1;
    await PayOrderRepository.orderList(
      type: type,
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      records
        ..clear()
        ..addAll(value.records);
      showSuccess(records);
    }).catchError((error) {
      showError(error);
    });
  }
}
