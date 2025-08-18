import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/model/stat_hit_value.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/utils/lottery_utils.dart';
import 'package:prize_lottery_app/views/master/model/history_record.dart';
import 'package:prize_lottery_app/widgets/ball_widget.dart';

class CommonWidgets {
  ///
  /// 计算文字宽高
  ///
  static Size measureText({
    required String text,
    required TextStyle style,
    int maxLines = 2 ^ 31,
    double maxWidth = double.infinity,
  }) {
    final TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        locale: Localizations.localeOf(Get.context!),
        text: TextSpan(text: text, style: style),
        maxLines: maxLines)
      ..layout(maxWidth: maxWidth);
    return textPainter.size;
  }

  static InputDecoration filledDecoration(
      {required String hintText, String? helperText}) {
    return InputDecoration(
      hintText: hintText,
      helperText: helperText ?? '',
      filled: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.w),
      fillColor: const Color(0xFFF6F7FB),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.w),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.w),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.w),
        borderSide: BorderSide.none,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.w),
        borderSide: BorderSide.none,
      ),
      helperStyle: TextStyle(fontSize: 11.sp),
      errorStyle: TextStyle(fontSize: 11.sp),
      hintStyle: TextStyle(
        color: Colors.black54,
        fontSize: 15.sp,
      ),
    );
  }

  ///
  ///
  static InputDecoration inputDecoration(
      {required String hintText, String? helperText}) {
    return InputDecoration(
      hintText: hintText,
      helperText: helperText ?? '',
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blueAccent,
          width: 0.25.w,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black45,
          width: 0.25.w,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 0.25.w,
        ),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 0.25.w,
        ),
      ),
      helperStyle: TextStyle(fontSize: 11.sp),
      errorStyle: TextStyle(fontSize: 11.sp),
      hintStyle: TextStyle(
        color: Colors.black54,
        fontSize: 16.sp,
      ),
    );
  }

  ///
  ///
  static Widget dotted({required double size, required Color color}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(size / 2),
      ),
    );
  }

  static List<Widget> lottoBalls(
      List<String> reds, Color color, String? title) {
    List<Widget> views = <Widget>[];
    List<String> items = reds.isNotEmpty ? reds : ['待', '开', '奖'];
    if (title != null && title.isNotEmpty) {
      views.add(
        Container(
          margin: EdgeInsets.only(right: 5.w),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black87,
            ),
          ),
        ),
      );
    }
    for (var ball in items) {
      views.add(
        Container(
          width: 26.w,
          height: 26.w,
          margin: EdgeInsets.only(right: 8.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Text(
            ball,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 13.w,
            ),
          ),
        ),
      );
    }
    return views;
  }

  ///
  ///
  static List<Widget> lottery(
    List<String> reds,
    List<String> blues,
    bool shi,
  ) {
    List<Widget> views = <Widget>[];
    if (shi) {
      views.add(
        Container(
          margin: EdgeInsets.only(right: 5.w),
          child: Text(
            '试机号',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black54,
            ),
          ),
        ),
      );
    }
    if (reds.isEmpty) {
      List<String> items = ['待', '开', '奖'];
      for (var ball in items) {
        views.add(
          Container(
            width: 22.w,
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 4.w),
            child: Text(
              ball,
              style: TextStyle(
                color: const Color(0xFFFF0033),
                fontSize: 16.sp,
              ),
            ),
          ),
        );
      }
    } else {
      for (var ball in reds) {
        views.add(
          Container(
            width: 22.w,
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 4.w),
            child: Text(
              ball,
              style: TextStyle(
                color: const Color(0xFFFF0033),
                fontSize: 17.sp,
                fontFamily: 'bebas',
              ),
            ),
          ),
        );
      }
    }
    if (blues.isNotEmpty) {
      views.add(SizedBox(width: 12.w));
      for (var ball in blues) {
        views.add(
          Container(
            width: 22.w,
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 4.w),
            child: Text(
              ball,
              style: TextStyle(
                color: const Color(0xFF1E80FF),
                fontSize: 17.sp,
                fontFamily: 'bebas',
              ),
            ),
          ),
        );
      }
    }
    return views;
  }

  static Widget _patternItem({required String name, required String pattern}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 2.w),
          child: Text(
            name,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 12.sp,
            ),
          ),
        ),
        Text(
          pattern,
          style: TextStyle(
            color: pattern == '无' ? Colors.black38 : const Color(0xFFFF1139),
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  ///
  /// 开奖号码形态
  static List<Widget> lotteryPattern(List<String> reds, bool s3) {
    List<int> balls =
        reds.isNotEmpty ? reds.map((e) => int.parse(e)).toList() : [];
    return [
      Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: _patternItem(
          name: '和值',
          pattern: balls.isEmpty ? '无' : LotteryUtils.sum(balls).toString(),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: _patternItem(
          name: '奇偶',
          pattern: balls.isEmpty ? '无' : LotteryUtils.oddEven(balls),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: _patternItem(
          name: '质合',
          pattern: balls.isEmpty ? '无' : LotteryUtils.primeComposite(balls),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: _patternItem(
          name: '跨度',
          pattern: balls.isEmpty ? '无' : LotteryUtils.kua(balls).toString(),
        ),
      ),
      if (!s3)
        _patternItem(
          name: '连号',
          pattern: balls.isEmpty
              ? '无'
              : seriesPatterns[LotteryUtils.series(balls)] ?? '',
        ),
      if (s3)
        _patternItem(
          name: '形态',
          pattern: balls.isEmpty
              ? '无'
              : n3Patterns[LotteryUtils.n3Pattern(balls)] ?? '',
        ),
    ];
  }

  ///
  ///彩票开奖
  static List<Widget> ballView(
    List<String> reds,
    List<String> blues,
    bool shi,
  ) {
    List<Widget> views = <Widget>[];
    List<String> items = reds.isNotEmpty ? reds : ['待', '开', '奖'];
    if (shi) {
      views.add(
        Container(
          margin: EdgeInsets.only(right: 5.w),
          child: Text(
            '试机号',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black54,
            ),
          ),
        ),
      );
    }
    for (var ball in items) {
      views.add(Ball(
        ball: ball,
        type: BallType.red,
      ));
    }
    if (blues.isNotEmpty) {
      List<String> bBalls = List<String>.from(blues);
      views.add(
        SizedBox(
          width: 12.w,
        ),
      );
      for (var ball in bBalls) {
        views.add(Ball(
          ball: ball,
          type: BallType.blue,
        ));
      }
    }
    return views;
  }

  static Widget rankView({required int rank, required int lastRank}) {
    ///未排名
    int delta = rank - lastRank;
    if (lastRank == 0 || delta == 0) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.w),
        decoration: BoxDecoration(
          color: Colors.blue.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(3.w),
        ),
        child: Text(
          '排名较上期保持不变',
          style: TextStyle(color: Colors.blueAccent, fontSize: 11.sp),
        ),
      );
    }
    if (delta > 0) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.w),
        decoration: BoxDecoration(
          color: const Color(0xFFEE3226).withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(3.w),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 2.w),
              child: Text(
                '↓',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFEE3226),
                ),
              ),
            ),
            Text(
              '排名较上期下降',
              style: TextStyle(color: const Color(0xFFEE3226), fontSize: 11.sp),
            ),
            Text(
              '$delta',
              style: TextStyle(
                color: const Color(0xFFEE3226),
                fontSize: 10.sp,
                fontFamily: 'bebas',
              ),
            ),
            Text(
              '位',
              style: TextStyle(color: const Color(0xFFEE3226), fontSize: 11.sp),
            ),
          ],
        ),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.w),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: Text(
              '↑',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
          ),
          Text(
            '排名较上期上升',
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.blueAccent,
            ),
          ),
          Text(
            '${(-1) * delta}',
            style: TextStyle(
              fontSize: 10.sp,
              fontFamily: 'bebas',
              color: Colors.blueAccent,
            ),
          ),
          Text(
            '位',
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }

  static Widget statHitPoster(StatHitValue? hit) {
    if (hit == null) {
      return Container();
    }
    return Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: RichText(
        text: TextSpan(
          text: '近期',
          style: TextStyle(color: Colors.black54, fontSize: 11.sp),
          children: [
            TextSpan(
              text: hit.count,
              style: const TextStyle(color: Color(0xFF2254F4)),
            ),
            const TextSpan(text: '期'),
          ],
        ),
      ),
    );
  }

  static List<Widget> statHitViews(StatHitValue? hit) {
    if (hit == null) {
      return [];
    }
    List<Widget> views = [
      Padding(
        padding: EdgeInsets.only(left: 4.w),
        child: RichText(
          text: TextSpan(
            text: '近',
            style: TextStyle(color: Colors.black45, fontSize: 12.sp),
            children: [
              TextSpan(
                text: hit.count,
                style: const TextStyle(color: Color(0xFFFF0033)),
              ),
              const TextSpan(text: '期'),
            ],
          ),
        ),
      ),
    ];
    if (hit.series > 0) {
      views.add(
        Padding(
          padding: EdgeInsets.only(left: 2.w),
          child: RichText(
            text: TextSpan(
                text: '连红',
                style: TextStyle(color: Colors.black45, fontSize: 12.sp),
                children: [
                  TextSpan(
                    text: hit.series.toString(),
                    style: const TextStyle(color: Color(0xFFFF0033)),
                  ),
                  const TextSpan(text: '期'),
                ]),
          ),
        ),
      );
    }
    if (hit.series == 0) {
      views.add(
        Padding(
          padding: EdgeInsets.only(left: 2.w),
          child: Text(
            '上期未中',
            style: TextStyle(color: Colors.black45, fontSize: 12.sp),
          ),
        ),
      );
    }
    return views;
  }

  static Widget hitItemView(HitItem item) {
    return Container(
      margin: EdgeInsets.only(top: 6.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12, width: 0.3.w),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(12.w, 0.w, 12.w, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '第${item.period}期',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                item.hit > 0
                    ? Text(
                        item.showHit ? '命中' : '中${item.hit}',
                        style: TextStyle(
                          color: const Color(0xFFF43F3B),
                          fontSize: 14.sp,
                        ),
                      )
                    : Text(
                        '未命中',
                        style: TextStyle(
                          color: const Color(0xFFA1A1A1),
                          fontSize: 14.sp,
                        ),
                      ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 22.w,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 8.w),
                  child: Text(
                    '开奖号码',
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 13.sp,
                      height: 1.1,
                    ),
                  ),
                ),
                ...item.reds.map(
                  (e) => Container(
                    width: 22.w,
                    height: 22.w,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 2.w),
                    child: Text(
                      e,
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                ...item.blues.map(
                  (e) => Container(
                    width: 22.w,
                    height: 22.w,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 2.w),
                    child: Text(
                      e,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 6.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 8.w, top: 1.w),
                  child: Text(
                    '推荐号码',
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                Expanded(
                  child: Wrap(
                    children: item.values.map((e) {
                      return Container(
                        width: 22.w,
                        height: 22.w,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 2.w, bottom: 2.w),
                        decoration: e.v > 0
                            ? BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFF43F3B),
                                  width: 0.8.w,
                                ),
                                borderRadius: BorderRadius.circular(20.w),
                              )
                            : const BoxDecoration(),
                        child: Text(
                          e.k,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: e.v == 0
                                ? Colors.black87
                                : const Color(0xFFF43F3B),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  static Widget cellHeader(String header, {Color color = Colors.redAccent}) {
    return Container(
      width: 42.w,
      height: 30.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border(
          top: BorderSide(color: color.withValues(alpha: 0.5), width: 0.1),
          bottom: BorderSide(color: color.withValues(alpha: 0.5), width: 0.1),
          left: BorderSide(color: color.withValues(alpha: 0.5), width: 0.1),
        ),
      ),
      child: Text(
        header,
        style: TextStyle(
          fontSize: 11.sp,
          color: color,
        ),
      ),
    );
  }

  static Widget introStep({
    required String text,
    required String btnTxt,
    VoidCallback? onStep,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14.sp,
            ),
          ),
          GestureDetector(
            onTap: onStep,
            child: Padding(
              padding: EdgeInsets.only(top: 4.w),
              child: Text(
                btnTxt,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
