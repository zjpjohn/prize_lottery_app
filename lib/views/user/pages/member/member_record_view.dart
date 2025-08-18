import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/views/user/controller/member_record_controller.dart';
import 'package:prize_lottery_app/views/user/model/user_member.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class MemberRecordView extends StatelessWidget {
  const MemberRecordView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '会员订单',
      content: Container(
        color: const Color(0xFFF6F7F9),
        child: RefreshWidget<MemberRecordController>(
          builder: (controller) {
            return ListView.builder(
              padding: EdgeInsets.only(bottom: 12.w),
              itemCount: controller.list.length,
              itemBuilder: (context, index) =>
                  _buildRecordItem(controller.list[index]),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRecordItem(UserMemberLog record) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      margin: EdgeInsets.only(left: 12.w, right: 12.w, top: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  record.packName,
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '¥${(record.payed / 100).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          _memberRecordItem(title: '订单编号', value: record.orderNo),
          _memberRecordItem(
              title: '有效期',
              value: '${record.expireStart}-${record.expireEnd}'),
          _memberRecordItem(title: '支付方式', value: record.channel),
          _memberRecordItem(title: '开通时间', value: record.gmtCreate),
        ],
      ),
    );
  }

  Widget _memberRecordItem({required String title, required String value}) {
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
}
