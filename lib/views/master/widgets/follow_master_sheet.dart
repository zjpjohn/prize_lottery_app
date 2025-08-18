import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/widgets/modal_sheet_view.dart';

class FollowMasterSheet extends StatefulWidget {
  const FollowMasterSheet({
    super.key,
    required this.masterId,
    required this.trace,
    required this.traceZh,
    required this.special,
    required this.traceTap,
    required this.cancelTap,
    required this.specialTap,
  });

  final String masterId;
  final String trace;
  final String traceZh;
  final int special;
  final GestureTapCallback cancelTap;
  final GestureTapCallback specialTap;
  final GestureTapCallback traceTap;

  @override
  State<FollowMasterSheet> createState() => _FollowMasterSheetState();
}

class _FollowMasterSheetState extends State<FollowMasterSheet> {
  late int special = 0;

  @override
  void initState() {
    super.initState();
    special = widget.special;
  }

  @override
  Widget build(BuildContext context) {
    return ModalSheetView(
      title: '关注专家',
      border: false,
      color: const Color(0xFFF8F8F8),
      height: MediaQuery.of(context).size.height * 0.38,
      child: _buildMasterContent(),
    );
  }

  Widget _buildMasterContent() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.w),
      margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: Column(
        children: [
          _buildSpecialMaster(),
          _buildTraceMaster(),
          _buildCancelFollow(),
        ],
      ),
    );
  }

  Widget _buildSpecialMaster() {
    return Container(
      padding: EdgeInsets.only(bottom: 16.w, left: 16.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12, width: 0.15.w),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '重点关注',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '设置重点关注，快速掌握专家重要性',
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          Transform.scale(
            scale: 0.60,
            child: CupertinoSwitch(
              value: special == 1,
              inactiveTrackColor: const Color(0xFFF6F6F6),
              activeTrackColor: const Color(0xFF00C2C2),
              onChanged: (value) {
                widget.specialTap();
                setState(() {
                  special = value ? 1 : 0;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTraceMaster() {
    return GestureDetector(
      onTap: widget.traceTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black12, width: 0.15.w),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '追踪专家',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '便于快速识别专家预测数据的准确性',
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            Icon(
              const IconData(0xe67e, fontFamily: "iconfont"),
              size: 21.sp,
              color: Colors.black87,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCancelFollow() {
    return GestureDetector(
      onTap: widget.cancelTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '取消关注',
              style: TextStyle(
                color: const Color(0xFFFF0033),
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(
              const IconData(0xe67c, fontFamily: "iconfont"),
              size: 22.sp,
              color: const Color(0xFFFF0033),
            )
          ],
        ),
      ),
    );
  }
}
