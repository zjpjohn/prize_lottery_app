import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/utils/date_util.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/widgets/common_widgets.dart';

class LotteryInfoPanel extends StatelessWidget {
  ///
  const LotteryInfoPanel({
    super.key,
    required this.lottery,
  });

  final LotteryInfo lottery;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          '第${lottery.period}期',
                          style:
                              TextStyle(color: Colors.black87, fontSize: 16.sp),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(
                                '/lotto/detail/${lottery.type}/${lottery.period}');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 4.w),
                                child: Text(
                                  lottery.lotDate,
                                  style: TextStyle(
                                      fontSize: 13.sp, color: Colors.black38),
                                ),
                              ),
                              Text(
                                Constants.dayWeek(DateUtil.parse(
                                    lottery.lotDate,
                                    pattern: "yyyy/MM/dd")),
                                style: TextStyle(
                                  fontSize: 12.5.sp,
                                  color: Colors.black38,
                                ),
                              ),
                              Icon(
                                const IconData(0xe613, fontFamily: 'iconfont'),
                                size: 12.w,
                                color: Colors.black38,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          runSpacing: 4.w,
                          children: CommonWidgets.ballView(
                            lottery.redBalls(),
                            lottery.blueBalls(),
                            false,
                          ),
                        ),
                      ),
                      if (lottery.isN3Type())
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: CommonWidgets.ballView(
                              lottery.shiBalls(),
                              [],
                              true,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 6.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: CommonWidgets.lotteryPattern(
                      lottery.redBalls(),
                      lottery.isN3Type(),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    lotteryTimes[lottery.type]![1],
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 12.sp,
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Constants.todayOpen(
                    type: lottery.type, dateTime: DateTime.now())
                ? Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.w),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.w),
                        bottomRight: Radius.circular(8.w),
                      ),
                    ),
                    child: Text(
                      '今日开奖',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: const Color(0xFFFF0033),
                      ),
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
