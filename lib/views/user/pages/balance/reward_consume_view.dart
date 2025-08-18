import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/views/user/controller/reward_consume_controller.dart';
import 'package:prize_lottery_app/views/user/model/balance_log.dart';

class RewardConsumeView extends StatefulWidget {
  ///
  ///
  const RewardConsumeView({super.key});

  @override
  RewardConsumeViewState createState() => RewardConsumeViewState();
}

class RewardConsumeViewState extends State<RewardConsumeView>
    with AutomaticKeepAliveClientMixin {
  ///
  ///
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      alignment: Alignment.center,
      child: RefreshWidget<RewardConsumeController>(
        init: RewardConsumeController(),
        bottomBouncing: false,
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.logs.length,
            itemBuilder: (context, index) {
              return _buildLogItem(controller.logs[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildLogItem(BalanceLog log) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 4.w),
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
                child: Text(
                  log.remark,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              Text(
                log.gmtCreate,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
          Text(
            '${log.direct.description}${log.balance}',
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 15.sp,
              fontFamily: 'bebas',
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
