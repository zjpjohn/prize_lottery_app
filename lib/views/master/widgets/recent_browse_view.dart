import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/views/user/model/browse_record.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';

class RecentBrowseView extends StatelessWidget {
  ///
  ///
  const RecentBrowseView({
    super.key,
    required this.name,
    required this.type,
    required this.record,
    this.bottom,
  });

  ///
  /// 彩种类型
  final String type;

  ///
  /// 彩种中文名称
  final String name;

  ///
  ///
  final double? bottom;

  ///
  /// 近期浏览记录
  final RecentBrowseRecord record;

  @override
  Widget build(BuildContext context) {
    if (record.count <= 3) {
      return const SizedBox.shrink();
    }
    return Container(
      color: Colors.white,
      alignment: Alignment.centerLeft,
      child: _buildBrowseView(record),
    );
  }

  Widget _buildBrowseView(RecentBrowseRecord record) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.browse, parameters: {'type': type});
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 14.w),
        padding: EdgeInsets.only(top: 12.w, bottom: bottom ?? 4.w),
        child: Row(
          children: [
            Text(
              '已浏览$name',
              style: TextStyle(
                fontSize: 13.sp,
                color: const Color(0xBB000000),
              ),
            ),
            _buildBrowseMaster(record.records),
            RichText(
              text: TextSpan(
                text: '等',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xBB000000),
                ),
                children: [
                  TextSpan(
                    text: '${record.count}',
                    style: const TextStyle(
                      color: Color(0xFFFF0033),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const TextSpan(text: '位专家'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrowseMaster(List<BrowseRecord> records) {
    List<Widget> items = [];
    for (int i = 0; i < records.length; i++) {
      items.add(Positioned(
        top: 0.w,
        left: 10.w * i,
        child: Container(
          height: 16.w,
          width: 16.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFECECEC),
            borderRadius: BorderRadius.circular(18.w),
          ),
          child: CachedAvatar(
            width: 14.5.w,
            height: 14.5.w,
            radius: 14.5.w,
            url: records[i].master!.avatar,
          ),
        ),
      ));
    }
    return SizedBox(
      height: 16.w,
      width: 10.w * (records.length) + 6.w,
      child: Stack(children: items),
    );
  }
}
