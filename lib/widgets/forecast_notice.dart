import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForecastNotice extends StatelessWidget {
  ///
  const ForecastNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Text(
        '声明：预测方案为专家个人观点仅供参考，请您务必谨慎使用；'
        '本应用不提供彩票销售，购彩投注请您前往就近线下彩票站。',
        style: TextStyle(
          color: Colors.black38,
          fontSize: 11.sp,
        ),
      ),
    );
  }
}
