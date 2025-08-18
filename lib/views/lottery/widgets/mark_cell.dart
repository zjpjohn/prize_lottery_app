import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/views/lottery/utils/trend_constants.dart';

class MarkCell extends StatefulWidget {
  const MarkCell({
    super.key,
    required this.ball,
    required this.size,
    required this.border,
  });

  final String ball;
  final double size;
  final Border border;

  @override
  State<MarkCell> createState() => _MarkCellState();
}

class _MarkCellState extends State<MarkCell> {
  ///
  /// 是否选中
  bool picked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      alignment: Alignment.center,
      decoration: BoxDecoration(border: widget.border),
      child: GestureDetector(
        onTap: () {
          picked = !picked;
          setState(() {});
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: widget.size - 8.w,
          height: widget.size - 8.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: picked ? blueFont : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(widget.size / 2)),
          ),
          child: Text(
            picked ? widget.ball : '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
            ),
          ),
        ),
      ),
    );
  }
}
