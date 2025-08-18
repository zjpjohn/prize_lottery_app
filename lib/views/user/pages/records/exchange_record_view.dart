import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/views/user/controller/exchange_record_controller.dart';
import 'package:prize_lottery_app/views/user/model/balance_log.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class ExchangeRecordView extends StatelessWidget {
  ///
  ///
  const ExchangeRecordView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '兑换历史',
      content: RefreshWidget<ExchangeRecordController>(
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

  ///
  ///
  Widget _buildRecordItem(BalanceLog log, bool border) {
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
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${log.direct.description}${log.surplus}',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 13.sp,
                      fontFamily: 'bebas',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2.w),
                    child: Text(
                      '金币',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 11.sp,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '-${log.source}',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 13.sp,
                      fontFamily: 'bebas',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2.w),
                    child: Text(
                      '积分',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 11.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
