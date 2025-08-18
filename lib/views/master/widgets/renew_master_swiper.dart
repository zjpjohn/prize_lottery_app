import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/master/model/renew_master.dart';
import 'package:prize_lottery_app/widgets/card_banner_swiper.dart';

class RenewMasterSwiper extends StatelessWidget {
  const RenewMasterSwiper({
    super.key,
    this.marginTop,
    required this.masters,
  });

  final double? marginTop;

  ///专家集合
  final List<RenewMaster> masters;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 12.w,
        top: marginTop ?? 8.w,
        bottom: 12.w,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.black12, width: 0.15),
        ),
      ),
      child: _buildRenewBanner(masters),
    );
  }

  Widget _buildRenewBanner(List<RenewMaster> masters) {
    return CardBannerSwiper<RenewMaster>(
      datas: masters,
      width: 40.w,
      height: 28.w,
      duration: 4000,
      extractor: (data) => data.master.avatar,
      builder: (context, data) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 6.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  height: 42.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Tools.limitName(data.master.name, 10),
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.black,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: const Color(0xAA000000),
                          ),
                          children: [
                            const TextSpan(text: '第'),
                            TextSpan(
                              text: data.period,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xFFFF0033),
                              ),
                            ),
                            const TextSpan(text: '期预测方案已更新'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/${data.type.value}/forecast/${data.masterId}');
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  alignment: Alignment.centerRight,
                  padding:
                      EdgeInsets.symmetric(vertical: 4.w, horizontal: 12.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.w),
                    border: Border.all(
                      color: Colors.deepOrangeAccent,
                      width: 0.15.w,
                    ),
                  ),
                  child: Text(
                    '去查看',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
