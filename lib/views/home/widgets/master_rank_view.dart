import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/model/stat_hit_value.dart';
import 'package:prize_lottery_app/resources/colors.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/home/widgets/achieve_tag_view.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';

class MasterRankView extends StatelessWidget {
  ///
  ///
  const MasterRankView({
    super.key,
    required this.tagColor,
    required this.name,
    required this.avatar,
    required this.rank,
    required this.margin,
    required this.onTap,
    required this.hitValue,
  });

  final TagColor tagColor;
  final String name;
  final String avatar;
  final int rank;
  final EdgeInsets margin;
  final Function onTap;
  final MapEntry<String, StatHitValue> hitValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 72.w,
        margin: margin,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 6.w),
              child: Stack(
                children: [
                  SizedBox(
                    width: 50.w,
                    height: 56.w,
                    child: CachedAvatar(
                      width: 50.w,
                      height: 56.w,
                      url: avatar,
                      color: const Color(0xFFF1F1F1),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: ClipPath(
                      clipper: VoucherClipper(),
                      child: Container(
                        width: 16.w,
                        height: 20.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              rankColors[rank <= 4 ? rank : 4]!,
                              rankColors[rank <= 4 ? rank : 4]!
                                  .withValues(alpha: 0.75),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 2.w),
                          child: Text(
                            '$rank',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 56.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 4.w),
                    width: 92.w,
                    child: Text(
                      Tools.limitText(name, 8),
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        height: 1.1,
                        fontSize: 14.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RankTag(
                        tagColor: tagColor,
                        name: hitValue.key,
                        achieve: hitValue.value.count,
                      ),
                      RichText(
                        text: TextSpan(
                          text: '连中',
                          style: TextStyle(
                            color: Colors.brown.shade300,
                            fontSize: 10.sp,
                          ),
                          children: [
                            TextSpan(
                              text: '${hitValue.value.series}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const TextSpan(text: '期'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RankTag extends StatelessWidget {
  const RankTag({
    super.key,
    required this.tagColor,
    required this.name,
    required this.achieve,
  });

  final TagColor tagColor;
  final String name;
  final String achieve;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: name,
            style: TextStyle(
              fontSize: 10.sp,
              color: tagColor == TagColor.red
                  ? Colors.deepOrange.withValues(alpha: 0.5)
                  : Colors.blueAccent.withValues(alpha: 0.5),
            ),
          ),
          TextSpan(
            text: '·$achieve',
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.brown.shade300,
            ),
          ),
          TextSpan(
            text: '期',
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.brown.shade300,
            ),
          ),
        ],
      ),
    );
  }
}

class VoucherClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(size.width, 0.0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width / 2, size.height - 4)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
