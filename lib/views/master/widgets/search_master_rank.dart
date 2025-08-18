import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/rank/model/master_item_rank.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';

class SearchMasterRank extends StatelessWidget {
  ///
  const SearchMasterRank({
    super.key,
    required this.rank,
    required this.colors,
    required this.onTap,
  });

  final MasterItemRank rank;
  final List<Color> colors;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.only(bottom: 14.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10.w),
                  child: CachedAvatar(
                    width: 52.w,
                    height: 56.w,
                    url: rank.master.avatar,
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: ClipPath(
                    clipper: VoucherClipper(),
                    child: Container(
                      width: 16.w,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 2.w, bottom: 6.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: colors,
                        ),
                      ),
                      child: Text(
                        '${rank.rank}',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 56.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 80.w,
                    child: Text(
                      Tools.limitText(rank.master.name, 8),
                      textAlign: TextAlign.start,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontSize: 13.sp,
                        height: 0.98,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '最近',
                          style:
                              TextStyle(color: Colors.black26, fontSize: 9.sp),
                          children: [
                            TextSpan(
                              text: rank.rate.count,
                              style: const TextStyle(color: Color(0xFFFF0033)),
                            ),
                            const TextSpan(text: '期'),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: '连红',
                          style: TextStyle(
                            color: Colors.black26,
                            fontSize: 9.sp,
                          ),
                          children: [
                            TextSpan(
                              text: '${rank.rate.series}',
                              style: const TextStyle(color: Color(0xFFFF0033)),
                            ),
                            const TextSpan(text: '期'),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class VoucherClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width / 2, size.height - 4)
      ..lineTo(0, size.height)
      ..lineTo(0, 0)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
