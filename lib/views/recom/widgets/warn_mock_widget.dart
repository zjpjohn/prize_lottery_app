import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WarnMockWidget extends StatelessWidget {
  const WarnMockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          warnItem('胆码预警', ['6']),
          warnItem('杀码预警', ['1', '3', '5', '8']),
          SizedBox(height: 8.w),
          warnItem('跨度预警', ['2', '4', '5', '7', '9']),
          warnItem('和尾预警', ['2', '3', '4', '5', '6', '7', '8']),
          warnItem('和值预警',
              ['9', '12', '13', '14', '15', '16', '17', '18', '19', '22']),
          SizedBox(height: 8.w),
          warnItem('组三推荐', ['2 5', '3 6', '1 8', '4 9']),
          warnItem('组六推荐', [
            '2 5 7',
            '2 5 8',
            '1 5 8',
            '2 6 7',
            '3 6 8',
            '3 4 9',
            '4 5 7',
            '4 5 9'
          ]),
        ],
      ),
    );
  }

  Widget warnItem(String title, List<String> values) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 22.w,
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: 4.w),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
            ),
          ),
        ),
        Expanded(
          child: Wrap(
            children: values.map((e) {
              return Container(
                height: 22.w,
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Text(
                  e,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontFamily: 'shuhei',
                    color: const Color(0xCC000000),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
