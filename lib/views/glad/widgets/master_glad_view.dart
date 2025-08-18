import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/model/stat_hit_value.dart';
import 'package:prize_lottery_app/views/glad/model/master_glad.dart';
import 'package:prize_lottery_app/views/home/widgets/achieve_tag_view.dart';

typedef MasterTapCallback<T extends MasterGlad> = void Function(T master);
typedef AchievedCallback<T extends MasterGlad> = Map<String, String> Function(
    T master);

class MasterGladView<T extends MasterGlad> extends StatelessWidget {
  ///
  const MasterGladView({
    super.key,
    required this.glad,
    required this.hitValue,
    required this.masterTap,
    required this.achievedCallback,
    this.border = true,
    this.showAds = false,
  });

  final T glad;
  final HitValue hitValue;
  final bool border;
  final bool showAds;
  final MasterTapCallback<T> masterTap;
  final AchievedCallback<T> achievedCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            masterTap(glad);
          },
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 12.w),
            child: Container(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: border
                      ? BorderSide(color: Colors.black12, width: 0.2.w)
                      : BorderSide.none,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 16.w),
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 4.w),
                    child: CachedNetworkImage(
                      width: 62.w,
                      height: 66.w,
                      fit: BoxFit.cover,
                      imageUrl: glad.master.avatar,
                      placeholder: (context, uri) => Center(
                        child: SizedBox(
                          width: 18.w,
                          height: 18.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 1.2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.grey.withValues(alpha: 0.1),
                            ),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        color: Colors.black12,
                        size: 18.w,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 66.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          glad.master.name,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15.sp,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 6.w),
                              child: Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.black38),
                                      children: [
                                        TextSpan(text: '${hitValue.name}近'),
                                        TextSpan(
                                          text: hitValue.hit.count,
                                          style: const TextStyle(
                                              color: Colors.redAccent),
                                        ),
                                        const TextSpan(text: '期'),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.black38),
                                        children: [
                                          const TextSpan(text: '连红'),
                                          TextSpan(
                                            text: '${hitValue.hit.series}',
                                            style: const TextStyle(
                                                color: Colors.redAccent),
                                          ),
                                          const TextSpan(text: '期'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.black38),
                                        children: [
                                          const TextSpan(text: '命中率'),
                                          TextSpan(
                                            text:
                                                '${(hitValue.hit.rate * 100).toInt()}%',
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                              fontFamily: 'bebas',
                                              fontSize: 11.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: achievedCallback(glad)
                                  .entries
                                  .map((e) => AchieveTag(
                                        name: e.key,
                                        achieve: e.value,
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HitValue {
  late String name;
  late StatHitValue hit;

  HitValue({
    required this.name,
    required this.hit,
  });
}
