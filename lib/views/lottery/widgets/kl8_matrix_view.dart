import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/model/kl8_omit_census.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_omit.dart';

class Kl8MatrixView extends StatelessWidget {
  const Kl8MatrixView({
    super.key,
    required this.omit,
  });

  final Kl8BaseOmit omit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/lotto/detail/kl8/${omit.period}');
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.w),
        child: Row(
          children: [
            _buildPeriodView(),
            _buildContentView(),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodView() {
    List<Widget> views = [];
    List<String> periods = omit.periods.sublist(2);
    views.add(Text(
      '第',
      style: TextStyle(
        fontSize: 14.sp,
        height: 1.0,
        color: Colors.black38,
      ),
    ));
    for (var e in periods) {
      views.add(Text(
        e,
        style: TextStyle(
          fontSize: 18.sp,
          height: 1.0,
          color: const Color(0xFFFF0033),
        ),
      ));
    }
    views.add(Text(
      '期',
      style: TextStyle(
        fontSize: 14.sp,
        height: 1.0,
        color: Colors.black38,
      ),
    ));
    return Container(
      width: 32.2.w,
      height: 32.2.w * 8,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: const Color(0x29000000), width: 0.2.w),
          left: BorderSide(color: const Color(0x29000000), width: 0.2.w),
          bottom: BorderSide(color: const Color(0x29000000), width: 0.2.w),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: views,
      ),
    );
  }

  Widget _buildContentView() {
    List<TableRow> rows = List.generate(8, (i) => _buildRowView(i));
    return Table(
      defaultColumnWidth: FixedColumnWidth(32.2.w),
      children: rows,
    );
  }

  TableRow _buildRowView(int row) {
    List<OmitValue> values = omit.row(row);
    List<Widget> views = [];
    for (int i = 0; i < values.length; i++) {
      OmitValue e = values[i];
      views.add(Container(
        width: 32.2.w,
        height: 32.2.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ((row < 4 && i < 5) || (row >= 4 && i >= 5))
              ? const Color(0xFFF8F8F8)
              : Colors.white,
          border: Border(
            top: BorderSide(color: const Color(0x29000000), width: 0.2.w),
            left: BorderSide(color: const Color(0x29000000), width: 0.2.w),
            right: i == values.length - 1
                ? BorderSide(color: const Color(0x29000000), width: 0.2.w)
                : BorderSide.none,
            bottom: row == 7
                ? BorderSide(color: const Color(0x29000000), width: 0.2.w)
                : BorderSide.none,
          ),
        ),
        child: _buildCell(e),
      ));
    }
    return TableRow(children: views);
  }

  Widget _buildCell(OmitValue value) {
    if (value.value == 0) {
      return Container(
        width: 22.w,
        height: 22.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFFF0033),
          borderRadius: BorderRadius.circular(1.w),
        ),
        child: Text(
          value.key,
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.white,
          ),
        ),
      );
    }
    return SizedBox(
      width: 32.w,
      height: 32.w,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 2.w,
            child: Container(
              width: 32.w,
              alignment: Alignment.center,
              child: Text(
                value.key,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          Positioned(
            right: 4.w,
            top: 0.w,
            child: Text(
              '${value.value}',
              style: TextStyle(
                fontSize: 11.sp,
                color: Colors.black38,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
