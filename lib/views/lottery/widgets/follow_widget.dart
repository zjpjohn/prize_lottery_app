import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/widgets/empty_widget.dart';

class FollowWidget extends StatelessWidget {
  ///
  ///
  const FollowWidget({super.key, required this.follows});

  final List<Num3LottoFollow> follows;

  @override
  Widget build(BuildContext context) {
    List<TableRow> rows = [_buildTableHeader()];
    if (follows.isNotEmpty) {
      for (int i = 0; i < follows.length; i++) {
        rows.add(_buildFollowRow(follows[i]));
      }
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 12.w),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(),
              4: FlexColumnWidth(),
              5: FlexColumnWidth(),
            },
            children: rows,
          ),
        ),
        _buildBottomHint(),
      ],
    );
  }

  Widget _buildBottomHint() {
    if (follows.isEmpty) {
      return const EmptyView(
        message: '暂无历史跟随',
      );
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 24.w),
      child: Text(
        '历史相同号码前后期开奖跟随关系',
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.black38,
        ),
      ),
    );
  }

  TableRow _buildTableHeader() {
    return TableRow(
      decoration: BoxDecoration(
        color: Colors.black12.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(2.w),
      ),
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 8.w),
          child: Text(
            '期号',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 13.sp,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 8.w),
          child: Text(
            '前二期',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 13.sp,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 8.w),
          child: Text(
            '前一期',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 13.sp,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 8.w),
          child: Text(
            '当前期',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 13.sp,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 8.w),
          child: Text(
            '后一期',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 13.sp,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 8.w),
          child: Text(
            '后二期',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 13.sp,
            ),
          ),
        ),
      ],
    );
  }

  TableRow _buildFollowRow(Num3LottoFollow follow) {
    return TableRow(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12, width: 0.25.w),
        ),
      ),
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10.w),
          child: Text(
            follow.period,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 13.sp,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10.w),
          child: Text(
            follow.last2.replaceAll(RegExp(r'(\s+)'), ''),
            style: TextStyle(
              color: Colors.black87,
              fontSize: 13.sp,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10.w),
          child: Text(
            follow.last1.replaceAll(RegExp(r'(\s+)'), ''),
            style: TextStyle(
              color: Colors.black87,
              fontSize: 13.sp,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10.w),
          child: Text(
            follow.red.replaceAll(RegExp(r'(\s+)'), ''),
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFFFF0033),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10.w),
          child: Text(
            follow.next1.replaceAll(RegExp(r'(\s+)'), ''),
            style: TextStyle(
              color: Colors.black87,
              fontSize: 13.sp,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10.w),
          child: Text(
            follow.next2.replaceAll(RegExp(r'(\s+)'), ''),
            style: TextStyle(
              color: Colors.black87,
              fontSize: 13.sp,
            ),
          ),
        ),
      ],
    );
  }
}
