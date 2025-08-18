import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/app/app_calendar_hint.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';
import 'package:prize_lottery_app/widgets/modal_sheet_view.dart';

class LotteryCalendar extends StatelessWidget {
  ///
  ///
  const LotteryCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return ModalSheetView(
      title: '今日开奖',
      height: MediaQuery.of(context).size.height * 0.5,
      leftTxt: '一键提醒',
      leftTap: () {
        AppCalendarHint().createEventIfAbsent();
      },
      child: _buildLottoCalendar(),
    );
  }

  Widget _buildLottoCalendar() {
    List<String> lotteries = Constants.dayLotteries(DateTime.now());
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.w),
      child: Column(
        children: lotteries
            .where((e) => lotteryIcons[e] != null)
            .map((e) => Container(
                  padding: EdgeInsets.only(bottom: 20.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: CachedAvatar(
                          width: 38.w,
                          height: 38.w,
                          color: Colors.transparent,
                          url: lotteryIcons[e]!,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: Text(
                                  lotteryZhCns[e]!,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              Text(
                                '${lotteryTimes[e]![0]}开奖',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2.w),
                            child: Text(
                              lotteryTimes[e]![1],
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
