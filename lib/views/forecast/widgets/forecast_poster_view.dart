import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:prize_lottery_app/base/model/forecast_value.dart';
import 'package:prize_lottery_app/base/model/stat_hit_value.dart';
import 'package:prize_lottery_app/env/env_profile.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/store/store.dart';
import 'package:prize_lottery_app/widgets/common_widgets.dart';

class ForecastItem {
  ///
  /// 预测数据
  final ForecastValue forecast;

  ///近期命中率
  final StatHitValue? hit;

  ForecastItem({
    required this.forecast,
    this.hit,
  });
}

class ForecastPosterView extends StatelessWidget {
  ///
  const ForecastPosterView({
    super.key,
    required this.posterKey,
    required this.title,
    required this.forecasts,
  });

  final GlobalKey posterKey;
  final String title;
  final Map<String, ForecastItem> forecasts;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: posterKey,
      child: Container(
        width: 343.w,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.w),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(R.posterBackground),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Profile.props.appName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontFamily: 'shuhei',
                    ),
                  ),
                  Text(
                    '选号·推荐·免费',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.sp,
                      fontFamily: 'shuhei',
                    ),
                  )
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.w),
                      topRight: Radius.circular(24.w),
                      bottomLeft: Radius.circular(24.w),
                      bottomRight: Radius.circular(8.w),
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildPosterHeader(),
                      ...forecasts.entries
                          .map((e) => _buildPosterItem(e.key, e.value)),
                      _buildDelimiter(),
                      _buildSharePosterQr(),
                    ],
                  ),
                ),
                _buildWaterMark('凡彩推荐'),
              ],
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 16.w),
              child: Text(
                '祝彩民朋友成为幸运小福星',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontFamily: 'shuhei',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPosterHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 2.w),
              child: Image.asset(
                R.leftHeaderIcon,
                height: 6.w,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 4.w, right: 4.w),
              child: Text(
                '推荐详情',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'shuhei',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.w),
              child: Image.asset(
                R.rightHeaderIcon,
                height: 6.w,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 2.w, bottom: 4.w),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 13.sp,
              fontFamily: 'shuhei',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDelimiter() {
    return Container(
      height: 0.30.w,
      color: Colors.black12,
      margin: EdgeInsets.only(left: 8.w, right: 8.w, top: 12.w, bottom: 4.w),
    );
  }

  Widget _buildPosterItem(String title, ForecastItem item) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 8.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 6.w),
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 11.sp, color: Colors.black87),
                  ),
                  CommonWidgets.statHitPoster(item.hit),
                ],
              ),
            ),
          ),
          Flexible(
            child: Wrap(
              children: item.forecast.posterViews(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSharePosterQr() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.w),
      child: Row(
        children: [
          SizedBox(
            width: 44.w,
            height: 44.w,
            child: PrettyQrView.data(
              data: UserStore().shareUri,
              errorCorrectLevel: QrErrorCorrectLevel.H,
              decoration: const PrettyQrDecoration(
                shape: PrettyQrSmoothSymbol(
                  roundFactor: 0.5,
                ),
                image: PrettyQrDecorationImage(
                  scale: 0.30,
                  image: AssetImage(R.logo),
                ),
              ),
            ),
          ),
          Container(
            height: 46.w,
            margin: EdgeInsets.only(left: 12.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '凡彩推荐',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '下载APP获取更多精彩内容',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWaterMark(String mark) {
    return Container(
      color: Colors.transparent,
      height: 390.w,
      width: 288.w,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Transform.rotate(
                    angle: -0.45,
                    child: Text(
                      mark,
                      style: TextStyle(
                        color: Colors.black.withValues(alpha: 0.04),
                        fontSize: 28.sp,
                        fontFamily: 'shuhei',
                      ),
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                2,
                (index) => Transform.rotate(
                  angle: -0.45,
                  child: Text(
                    mark,
                    style: TextStyle(
                      color: Colors.black.withValues(alpha: 0.04),
                      fontSize: 28.sp,
                      fontFamily: 'shuhei',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: Container()),
                Expanded(
                  child: Transform.rotate(
                    angle: -0.45,
                    child: Text(
                      mark,
                      style: TextStyle(
                        color: Colors.black.withValues(alpha: 0.04),
                        fontSize: 28.sp,
                        fontFamily: 'shuhei',
                      ),
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
}
