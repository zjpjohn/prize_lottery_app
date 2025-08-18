import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/views/user/controller/reward_withdraw_controller.dart';
import 'package:prize_lottery_app/views/user/model/user_withdraw.dart';

class RewardWithdrawView extends StatefulWidget {
  ///
  ///
  const RewardWithdrawView({super.key});

  @override
  RewardWithdrawViewState createState() => RewardWithdrawViewState();
}

class RewardWithdrawViewState extends State<RewardWithdrawView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      alignment: Alignment.center,
      child: RefreshWidget<RewardWithdrawController>(
        init: RewardWithdrawController(),
        bottomBouncing: false,
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.records.length,
            itemBuilder: (context, index) =>
                _buildWithdrawItem(controller.records[index]),
          );
        },
      ),
    );
  }

  Widget _buildWithdrawItem(WithdrawRecord record) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12, width: 0.25.w),
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
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.redAccent,
                          fontFamily: 'bebas',
                        ),
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
                      fontSize: 12.sp,
                      fontFamily: 'bebas',
                      color: Colors.redAccent,
                    ),
                    children: [
                      TextSpan(
                        text: '奖励金',
                        style: TextStyle(
                          fontSize: 14.sp,
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

  @override
  bool get wantKeepAlive => true;
}
