import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/share_request_widget.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/utils/poster_util.dart';
import 'package:prize_lottery_app/views/lottery/controller/num3_lotto_index_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_index.dart';
import 'package:prize_lottery_app/views/lottery/widgets/intellect_poster_view.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';

class Num3LottoIndexView extends StatelessWidget {
  const Num3LottoIndexView({super.key});

  @override
  Widget build(BuildContext context) {
    return ShareRequestWidget<Num3LottoIndexController>(
      title: '选号指数',
      share: (controller) {
        if (!controller.feeRequired) {
          _sharePoster(controller);
        }
      },
      builder: (controller) {
        return Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildPeriodHeader(controller, true),
                Expanded(child: _buildIndexContent(controller)),
              ],
            ),
            if (controller.feeRequired)
              Positioned(
                left: 0,
                bottom: 0,
                child: _buildMemberHint(),
              ),
          ],
        );
      },
    );
  }

  Widget _buildPeriodHeader(
      Num3LottoIndexController controller, bool tapEnable) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (tapEnable) {
                controller.prePeriod();
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Icon(
                    const IconData(0xe676, fontFamily: 'iconfont'),
                    size: 14.sp,
                    color:
                        controller.isFirst() ? Colors.black26 : Colors.black87,
                  ),
                ),
                Text(
                  '上一期',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color:
                        controller.isFirst() ? Colors.black26 : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${controller.period}期',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (tapEnable) {
                controller.nextPeriod();
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '下一期',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: controller.isEnd() ? Colors.black26 : Colors.black87,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Icon(
                    const IconData(0xe613, fontFamily: 'iconfont'),
                    size: 14.sp,
                    color: controller.isEnd() ? Colors.black26 : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndexContent(Num3LottoIndexController controller) {
    return ScrollConfiguration(
      behavior: CustomScrollBehavior(),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 78.h),
          child: controller.feeRequired
              ? buildUnAuthedIndex()
              : buildAuthedIndex(controller),
        ),
      ),
    );
  }

  Widget buildAuthedIndex(Num3LottoIndexController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIndex(
          '选号指数',
          controller.index?.comIndex ?? LottoIndex.empty(10),
          controller.index?.lottery?.redBall ?? [],
        ),
        _buildIndex(
          '胆码指数',
          controller.index?.danIndex ?? LottoIndex.empty(10),
          controller.index?.lottery?.redBall ?? [],
        ),
        _buildIndex(
          '杀码指数',
          controller.index?.killIndex.reverse() ?? LottoIndex.empty(10),
          controller.index?.lottery?.redBall ?? [],
        ),
        _buildIndexHint(),
      ],
    );
  }

  Widget buildUnAuthedIndex() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIndex('选号指数', LottoIndex.empty(10), []),
        _buildIndex('胆码指数', LottoIndex.empty(10), []),
        _buildIndex('杀码指数', LottoIndex.empty(10), []),
        _buildIndexHint(),
      ],
    );
  }

  Widget _buildIndex(String title, LottoIndex index, List<String> balls) {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 12.w),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16.sp,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: index.values
                .map((e) => Column(
                      children: [
                        Container(
                          width: 26.w,
                          height: 120.h,
                          color: Colors.white,
                          margin: EdgeInsets.only(bottom: 4.w),
                          alignment: Alignment.bottomCenter,
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: Container(
                                  width: 26.w,
                                  height: 120.h * e.index,
                                  padding: EdgeInsets.only(top: 16.sp),
                                  alignment: Alignment.topCenter,
                                  color: balls.contains(e.ball)
                                      ? const Color(0xFF32CD32)
                                      : const Color(0xFF32CD32)
                                          .withValues(alpha: 0.30),
                                ),
                              ),
                              Positioned(
                                top: 8.h,
                                left: 0,
                                child: Container(
                                  width: 26.w,
                                  alignment: Alignment.center,
                                  child: Text(
                                    e.index <= 0
                                        ? '00%'
                                        : '${(e.index * 100).toStringAsFixed(0)}%',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          e.ball,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildIndexHint() {
    return Container(
      padding: EdgeInsets.only(top: 12.h, left: 16.h, right: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '指数说明:',
            style: TextStyle(color: Colors.black54, fontSize: 13.sp),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Text(
              '1、今日选号指数由选号指数、杀码指数、胆码指数三部分组成',
              style: TextStyle(color: Colors.black38, fontSize: 12.sp),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Text(
              '2、选号和胆码指数越高表示本期出号的可能性越大，杀码指数越低表示本期出现的可能性越高；',
              style: TextStyle(color: Colors.black38, fontSize: 12.sp),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Text(
              '3、选号指数仅代表号码可能性，具体请结合自身的选号经验谨慎使用',
              style: TextStyle(color: Colors.black38, fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberHint() {
    return Container(
      height: 55.h,
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF8F8F8),
            offset: const Offset(0, -4),
            spreadRadius: 4.h,
            blurRadius: 4.h,
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '智能选号仅限会员用户',
                style: TextStyle(
                  color: Colors.brown.withValues(alpha: 0.7),
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.member);
            },
            child: Container(
              height: 36.w,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 16.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFF0045),
                borderRadius: BorderRadius.circular(30.h),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF0045).withValues(alpha: 0.3),
                    offset: const Offset(4, 4),
                    blurRadius: 6,
                    spreadRadius: 0.0,
                  )
                ],
              ),
              child: Text(
                '开通会员',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sharePoster(Num3LottoIndexController controller) {
    Constants.shareBottomSheet(
      save: () {
        PosterUtils.saveImage(controller.posterKey);
      },
      content: IntellectPosterView(
        posterKey: controller.posterKey,
        statusBarHeight: MediaQuery.of(Get.context!).padding.top,
        header: _buildPeriodHeader(controller, false),
        footer: _buildIndexHint(),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIndex(
              '选号指数',
              controller.index?.comIndex ?? LottoIndex.empty(10),
              controller.index?.lottery?.redBall ?? [],
            ),
            _buildIndex(
              '胆码指数',
              controller.index?.danIndex ?? LottoIndex.empty(10),
              controller.index?.lottery?.redBall ?? [],
            ),
            _buildIndex(
              '杀码指数',
              controller.index?.killIndex.reverse() ?? LottoIndex.empty(10),
              controller.index?.lottery?.redBall ?? [],
            ),
          ],
        ),
      ),
    );
  }
}
