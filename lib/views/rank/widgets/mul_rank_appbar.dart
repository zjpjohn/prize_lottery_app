import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

final double barHeight = 44.h;

class MulRankAppbar extends StatelessWidget {
  const MulRankAppbar({
    super.key,
    required this.title,
    required this.throttle,
    required this.shrinkOffset,
  });

  final String title;
  final double throttle;
  final double shrinkOffset;

  @override
  Widget build(BuildContext context) {
    final double paddingTop = MediaQuery.of(context).padding.top;
    final int alpha = (shrinkOffset / throttle * 255).clamp(0, 255).toInt();
    Color color = Color.fromARGB(alpha, 255, 255, 255);
    Color textColor = Color.fromARGB(alpha, 0, 0, 0);
    return Container(
      color: color,
      height: 44.h + paddingTop,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: paddingTop),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 50.h,
                  height: 26.h,
                  padding: EdgeInsets.only(left: 16.w),
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    const IconData(0xe669, fontFamily: 'iconfont'),
                    size: 18.sp,
                    color: textColor,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.sp,
                  color: textColor,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return hintDialog(context);
                      });
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 16.w),
                  child: Icon(
                    const IconData(0xe607, fontFamily: 'iconfont'),
                    size: 20.sp,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget hintDialog(BuildContext context) {
    return Center(
      child: Container(
        width: 280.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '综合排行榜说明',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: Text(
                '1.综合排行榜是综合专家多个指标基于不同权重计算出综合得分进行排名。'
                '\n2.每期开奖完成后系统自动计算专家的当期预测综合排名，APP端会自动更新最新一期综合排名。'
                '\n3.综合排名是平衡专家选号和杀码命中率给出的综合排名，综合排名越靠前专家预测命中率越高，'
                '但不代表下一期一定准确，请您结合自身选号经验谨慎使用。',
                style: TextStyle(
                  color: const Color(0xFF666666),
                  fontSize: 14.sp,
                  height: 1.5,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 200.h,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2254F4).withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(20.h),
                  ),
                  child: Text(
                    '我知道啦',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
