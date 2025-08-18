import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/share_request_widget.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/utils/poster_util.dart';
import 'package:prize_lottery_app/views/lottery/controller/pl3_intellect_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_index.dart';
import 'package:prize_lottery_app/views/lottery/widgets/intellect_poster_view.dart';
import 'package:prize_lottery_app/widgets/common_widgets.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';

class Pl3IntellectView extends StatelessWidget {
  ///
  ///
  const Pl3IntellectView({super.key});

  @override
  Widget build(BuildContext context) {
    return ShareRequestWidget<Pl3IntellectController>(
        title: '智能选号',
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
                  Expanded(
                    child: _buildIndexContent(controller),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                bottom: 0,
                child: _buildPickBottom(controller),
              ),
            ],
          );
        });
  }

  void _sharePoster(Pl3IntellectController controller) {
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
          children: [
            SizedBox(height: 4.h),
            _buildAuthedDing(
              title: '百位',
              controller: controller,
              indices: controller.lotteryIndex!.redBall.values,
              lotto: controller.lotteryIndex!.lottery?.redBall[0],
              position: 0,
              picked: controller.pickDto.bai,
            ),
            _buildAuthedDing(
              title: '十位',
              controller: controller,
              indices: controller.lotteryIndex!.redBall.values,
              lotto: controller.lotteryIndex!.lottery?.redBall[1],
              position: 1,
              picked: controller.pickDto.shi,
            ),
            _buildAuthedDing(
              title: '个位',
              controller: controller,
              indices: controller.lotteryIndex!.redBall.values,
              lotto: controller.lotteryIndex!.lottery?.redBall[2],
              position: 2,
              picked: controller.pickDto.ge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodHeader(Pl3IntellectController controller, bool tapEnable) {
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

  Widget _buildIndexContent(Pl3IntellectController controller) {
    return ScrollConfiguration(
      behavior: CustomScrollBehavior(),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 78.h),
          child: controller.feeRequired
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.h),
                    _buildUnAuthedDing(
                      title: '百位',
                      balls: ballStr09,
                      lotto: controller.lotteryIndex?.lottery?.redBall[0],
                    ),
                    _buildUnAuthedDing(
                      title: '十位',
                      balls: ballStr09,
                      lotto: controller.lotteryIndex?.lottery?.redBall[1],
                    ),
                    _buildUnAuthedDing(
                      title: '个位',
                      balls: ballStr09,
                      lotto: controller.lotteryIndex?.lottery?.redBall[2],
                    ),
                    _buildIndexHint(),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.h),
                    _buildAuthedDing(
                      title: '百位',
                      controller: controller,
                      indices: controller.lotteryIndex!.redBall.values,
                      lotto: controller.lotteryIndex!.lottery?.redBall[0],
                      position: 0,
                      picked: controller.pickDto.bai,
                    ),
                    _buildAuthedDing(
                      title: '十位',
                      controller: controller,
                      indices: controller.lotteryIndex!.redBall.values,
                      lotto: controller.lotteryIndex!.lottery?.redBall[1],
                      position: 1,
                      picked: controller.pickDto.shi,
                    ),
                    _buildAuthedDing(
                      title: '个位',
                      controller: controller,
                      indices: controller.lotteryIndex!.redBall.values,
                      lotto: controller.lotteryIndex!.lottery?.redBall[2],
                      position: 2,
                      picked: controller.pickDto.ge,
                    ),
                    _buildIndexHint(),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildAuthedDing({
    required Pl3IntellectController controller,
    required String title,
    required List<Index> indices,
    String? lotto,
    required int position,
    required List<String> picked,
  }) {
    return Container(
      padding: EdgeInsets.only(top: 12.h, left: 8.h, right: 8.h),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 4.h, right: 4.h, top: 2.h),
                  child: CommonWidgets.dotted(
                    size: 10.h,
                    color: const Color(0xFFFF0033),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 4.h),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: '至少选择',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 13.sp,
                    ),
                    children: [
                      TextSpan(
                        text: '1',
                        style: TextStyle(
                          color: const Color(0xFFFF0033),
                          fontSize: 14.sp,
                        ),
                      ),
                      TextSpan(
                        text: '个数字',
                        style: TextStyle(
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Wrap(
            runSpacing: 8.h,
            spacing: 12.h,
            children: indices
                .map((e) => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.pickBall(position, e.ball);
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: 36.h,
                                height: 36.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.h),
                                  color: lotto == e.ball
                                      ? const Color(0xFFFF0033)
                                      : const Color(0xFFF1F1F1),
                                ),
                                child: Text(
                                  e.ball,
                                  style: TextStyle(
                                    color: e.ball != lotto
                                        ? (picked.contains(e.ball)
                                            ? const Color(0xFFFF0033)
                                            : const Color(0xFFCACACA))
                                        : Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              if (picked.contains(e.ball) && lotto == e.ball)
                                Positioned(
                                  bottom: 1.h,
                                  left: 13.h,
                                  child: Icon(
                                    const IconData(0xeaf1,
                                        fontFamily: 'iconfont'),
                                    color: Colors.white,
                                    size: 12.h,
                                  ),
                                )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4.h),
                          child: Text(
                            '${(e.index * 100).toStringAsFixed(0)}%',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: e.hot
                                  ? const Color(0xFFFF0033)
                                  : Colors.black26,
                            ),
                          ),
                        ),
                      ],
                    ))
                .toList(),
          )
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
            style: TextStyle(color: Colors.black45, fontSize: 13.sp),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Text(
              '1、指数由高到低排序，指数越高表示本期出号的可能性越大',
              style: TextStyle(color: Colors.black38, fontSize: 12.sp),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Text(
              '2、指数代表号码可能性，具体请结合自身的选号经验谨慎使用',
              style: TextStyle(color: Colors.black38, fontSize: 12.sp),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Text(
              '3、点击选中号码，已选中号码点击可取消，保存以便后续查看',
              style: TextStyle(color: Colors.black38, fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnAuthedDing({
    required String title,
    required List<String> balls,
    String? lotto,
  }) {
    return Container(
      padding: EdgeInsets.only(top: 12.h, left: 8.h, right: 8.h),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 4.h, right: 4.h, top: 2.h),
                  child: CommonWidgets.dotted(
                    size: 10.h,
                    color: const Color(0xFFFF0033),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 4.h),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: '至少选择',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 13.sp,
                    ),
                    children: [
                      TextSpan(
                        text: '1',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14.sp,
                        ),
                      ),
                      TextSpan(
                        text: '个数字',
                        style: TextStyle(
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Wrap(
            runSpacing: 8.h,
            spacing: 12.h,
            children: balls
                .map((e) => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 36.h,
                          height: 36.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.h),
                            color: lotto == e
                                ? const Color(0xFFFF0033)
                                : const Color(0xFFF1F1F1),
                          ),
                          child: Text(
                            e,
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                              color: lotto == e
                                  ? Colors.white
                                  : const Color(0xFFCACACA),
                            ),
                          ),
                        ),
                        Text(
                          '00%',
                          style: TextStyle(
                            color: Colors.black26,
                            fontSize: 12.sp,
                          ),
                        )
                      ],
                    ))
                .toList(),
          )
        ],
      ),
    );
  }

  Widget _buildPickBottom(Pl3IntellectController controller) {
    return controller.feeRequired
        ? _buildMemberHint()
        : _buildSavePick(controller);
  }

  Widget _buildSavePick(Pl3IntellectController controller) {
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
                '保存选号记录便于查阅',
                style: TextStyle(
                  color: Colors.brown.withValues(alpha: 0.7),
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
           GestureDetector(
              onTap: () {
                controller.saveLottoPick();
              },
              child: Container(
                height: 36.w,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 4.h),
                      child: Icon(
                        const IconData(0xe664, fontFamily: 'iconfont'),
                        size: 18.sp,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '保存',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
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
}
