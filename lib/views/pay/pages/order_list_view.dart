import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/views/pay/controller/order_list_controller.dart';
import 'package:prize_lottery_app/views/pay/model/pay_order.dart';

class OrderListView extends StatefulWidget {
  const OrderListView({
    super.key,
    required this.type,
  });

  final int type;

  @override
  State<OrderListView> createState() => _OrderListViewState();
}

class _OrderListViewState extends State<OrderListView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: const Color(0xFFF6F7FB),
      child: RefreshWidget<OrderListController>(
        global: false,
        empty: widget.type == 1 ? '暂无会员订单' : '暂无充值订单',
        init: OrderListController(widget.type),
        builder: (controller) {
          return ListView.builder(
            padding: EdgeInsets.only(top: 12.w),
            itemCount: controller.records.length,
            itemBuilder: (context, index) =>
                _buildOrderItem(controller.records[index]),
          );
        },
      ),
    );
  }

  Widget _buildOrderItem(OrderInfo order) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      margin: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Column(
        children: [
          widget.type == 1
              ? _buildMemberContent(order)
              : _buildChargeContent(order),
          _orderRecordItem(title: '订单编号', value: order.bizNo),
          _orderRecordItem(title: '支付方式', value: order.channel.description),
          _orderRecordItem(title: '支付时间', value: order.payTime),
          _orderRecordItem(title: '下单时间', value: order.gmtCreate),
          _orderRecordItem(title: '支付状态', value: order.state.description),
        ],
      ),
    );
  }

  Widget _orderRecordItem({required String title, required String value}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.w),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black12, width: 0.2.w),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 15.sp, color: Colors.black87),
          ),
          Text(
            value,
            style: TextStyle(color: Colors.black45, fontSize: 15.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildChargeContent(OrderInfo order) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '账户充值${order.content['amount']}金币${_chargeGift(order) > 0 ? '赠送${_chargeGift(order)}' : ''}',
            style: TextStyle(color: Colors.black, fontSize: 17.sp),
          ),
          Text(
            '¥${(order.realPrice / 100).toStringAsFixed(0)}',
            style: TextStyle(fontSize: 17.sp, color: Colors.black),
          ),
        ],
      ),
    );
  }

  int _chargeGift(OrderInfo order) {
    return order.content['gift'] ?? 0;
  }

  Widget _buildMemberContent(OrderInfo order) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${order.content['name']}',
            style: TextStyle(color: Colors.black, fontSize: 17.sp),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '¥${(order.realPrice / 100).toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 17.sp,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6.w),
                child: Text(
                  '¥${(order.stdPrice ~/ 100).toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black45,
                    decorationThickness: 2.w,
                    decoration: TextDecoration.lineThrough,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: Colors.black45,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
