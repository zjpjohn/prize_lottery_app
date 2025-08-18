import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/views/user/controller/withdraw_record_controller.dart';
import 'package:prize_lottery_app/views/user/model/user_withdraw.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class WithdrawRecordView extends StatelessWidget {
  ///
  ///
  const WithdrawRecordView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '提现历史',
      content: RefreshWidget<WithdrawRecordController>(
        bottomBouncing: false,
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.records.length,
            itemBuilder: (context, index) {
              return _buildRecordItem(
                controller.records[index],
                index < controller.records.length - 1,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildRecordItem(WithdrawRecord record, bool border) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: border
              ? BorderSide(color: Colors.black12, width: 0.25.w)
              : BorderSide.none,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 4.w),
                child: RichText(
                  text: TextSpan(
                    text: record.channel.description,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14.sp,
                    ),
                    children: [
                      const TextSpan(text: '提现'),
                      TextSpan(
                        text: '${record.money}',
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                      const TextSpan(text: '元'),
                    ],
                  ),
                ),
              ),
              Text(
                record.gmtCreate,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 4.w),
                child: RichText(
                  text: TextSpan(
                    text: '-${record.withdraw}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.redAccent,
                    ),
                    children: const [
                      TextSpan(
                        text: '奖励金',
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                record.state.description,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
