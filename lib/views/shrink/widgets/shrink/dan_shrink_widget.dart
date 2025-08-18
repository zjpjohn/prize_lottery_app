import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/views/shrink/model/shrink_filter.dart';
import 'package:prize_lottery_app/views/shrink/widgets/clip_button.dart';
import 'package:prize_lottery_app/widgets/modal_sheet_view.dart';

typedef OnTapHandle = Function(int index);

class DanShrinkView extends StatelessWidget {
  ///
  const DanShrinkView({
    super.key,
    required this.height,
    required this.model,
    required this.shrink,
    required this.tapBall,
    required this.tapNumber,
  });

  final double height;
  final DanModel model;
  final DanShrink shrink;
  final OnTapHandle tapBall;
  final OnTapHandle tapNumber;

  @override
  Widget build(BuildContext context) {
    return ModalSheetView(
      title: '胆码选择',
      height: height,
      child: _buildDanShrink(),
    );
  }

  Widget _buildDanShrink() {
    return Column(
      children: [
        _buildBalls(),
        _buildNumbers(),
      ],
    );
  }

  Widget _buildBalls() {
    List<Widget> balls = [];
    for (int i = model.min; i <= model.max; i++) {
      balls.add(_ball(i));
    }
    return Container(
      margin: EdgeInsets.only(left: 16.w, top: 32.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 18.w,
            padding: EdgeInsets.only(right: 6.w),
            alignment: Alignment.center,
            child: Text(
              '胆码选择',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12.sp,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  runSpacing: 6.w,
                  children: balls,
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.w),
                  child: Text(
                    '可能性最大的号码，最多选择${model.limit}个胆码',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFFFF0045),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ball(int index) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      child: GestureDetector(
        onTap: () {
          tapBall(index);
        },
        child: Container(
          width: 22.w,
          height: 22.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(14.w),
            color: shrink.dans.contains(index)
                ? const Color(0xFFFF0045)
                : const Color(0xFFF2F2F2),
          ),
          child: Text(
            '$index',
            style: TextStyle(
              fontSize: 12.sp,
              color:
                  shrink.dans.contains(index) ? Colors.white : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNumbers() {
    return Container(
      margin: EdgeInsets.only(left: 16.w, top: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 18.w,
            padding: EdgeInsets.only(right: 6.w),
            alignment: Alignment.center,
            child: Text(
              '出号个数',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12.sp,
              ),
            ),
          ),
          Expanded(
            child: Wrap(
              runSpacing: 6.w,
              children: List.generate(
                model.danMax,
                (index) => ClipButton(
                  text: '${index + 1}',
                  value: index + 1,
                  width: 40.w,
                  height: 20.w,
                  margin: 12.w,
                  selected: shrink.numbers.contains(index + 1),
                  disable: shrink.dans.length <= index,
                  onTap: (index) {
                    tapNumber(index);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
