import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/store/store.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';

class IntellectPosterView extends StatelessWidget {
  const IntellectPosterView({
    super.key,
    required this.posterKey,
    required this.statusBarHeight,
    required this.header,
    required this.content,
    required this.footer,
  });

  final GlobalKey posterKey;
  final double statusBarHeight;
  final Widget header;
  final Widget content;
  final Widget footer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height - 190.w,
      child: Column(
        children: [
          Container(
            width: Get.width,
            color: Colors.white,
            height: statusBarHeight,
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: SingleChildScrollView(
                child: RepaintBoundary(
                  key: posterKey,
                  child: Container(
                    color: const Color(0xFFFAFAFA),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 44.w,
                          width: Get.width,
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: Text(
                            '智能选号',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.sp,
                            ),
                          ),
                        ),
                        header,
                        Stack(
                          children: [
                            content,
                            _buildWaterMark('凡彩推荐'),
                          ],
                        ),
                        footer,
                        _buildSharePosterQr(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWaterMark(String mark) {
    return Container(
      height: 430.w,
      width: Get.width,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.rotate(
                  angle: -0.45,
                  child: Text(
                    mark,
                    style: TextStyle(
                      color: Colors.black.withValues(alpha: 0.06),
                      fontSize: 28.sp,
                      fontFamily: 'shuhei',
                    ),
                  ),
                ),
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
                      color: Colors.black.withValues(alpha: 0.06),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.rotate(
                  angle: -0.45,
                  child: Text(
                    mark,
                    style: TextStyle(
                      color: Colors.black.withValues(alpha: 0.06),
                      fontSize: 28.sp,
                      fontFamily: 'shuhei',
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSharePosterQr() {
    return Container(
      padding: EdgeInsets.only(left: 20.w, top: 12.w, bottom: 24.w),
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
                  '下载APP获取更多精彩推荐内容',
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
}
