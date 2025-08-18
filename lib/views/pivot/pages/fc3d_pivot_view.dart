import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/env/env_profile.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/store/user.dart';
import 'package:prize_lottery_app/utils/poster_util.dart';
import 'package:prize_lottery_app/views/pivot/controller/today_pivot_controller.dart';
import 'package:prize_lottery_app/views/pivot/model/pivot_info.dart';
import 'package:prize_lottery_app/views/pivot/widget/pivot_master_view.dart';
import 'package:prize_lottery_app/views/recom/widgets/member_hint_widget.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Fc3dPivotView extends StatefulWidget {
  const Fc3dPivotView({super.key});

  @override
  State<Fc3dPivotView> createState() => _Fc3dPivotViewState();
}

class _Fc3dPivotViewState extends State<Fc3dPivotView> {
  ///
  bool _showNative = false;

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '今日重点',
      border: false,
      right: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return _headerDialog(context);
              });
        },
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Icon(
            const IconData(0xe607, fontFamily: 'iconfont'),
            size: 20.sp,
            color: Colors.black87,
          ),
        ),
      ),
      content: RequestWidget<TodayPivotController>(
        init: TodayPivotController('fsd'),
        builder: (controller) {
          return VisibilityDetector(
            key: const Key('fc3d-pivot'),
            onVisibilityChanged: (visibleInfo) {
              var fraction = visibleInfo.visibleFraction;
              if (mounted) {
                setState(() {
                  _showNative = fraction != 0.0;
                });
              }
            },
            child: Stack(
              children: [
                ScrollConfiguration(
                  behavior: CustomScrollBehavior(),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildPivotHeader(controller),
                        _buildPivotDescription(),
                        _buildPivotContent(controller),
                        _buildPivotHint(),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 16.w,
                  bottom: Get.height / 2 - 64.h,
                  child: _buildPeriodView(controller),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _headerDialog(BuildContext context) {
    return Center(
      child: Container(
        width: 280.w,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '今日重点说明',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.w),
              child: Text(
                '1.今日重点功能是系统对本期开奖数据给出重点号码，首要关注、重点关注号码。'
                '\n2.今日重点每天最新数据会在下午17:30点至19点发布，期间可能会对数据进行多次修正。'
                '\n3.今日重点给出本期数据号码的重点关注方向，便于用户把我本期号码选择方向。',
                style: TextStyle(
                  color: const Color(0xFF666666),
                  fontSize: 14.sp,
                  height: 1.5,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 200.w,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 8.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2254F4).withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                  child: Text(
                    '我知道啦',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodView(TodayPivotController controller) {
    return Container(
      width: 34.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.w),
        border: Border.all(color: Colors.black26, width: 0.4.w),
      ),
      padding: EdgeInsets.symmetric(vertical: 10.w),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (!controller.isFirst()) {
                controller.prevPeriod();
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Column(
              children: [
                Icon(
                  const IconData(0xe682, fontFamily: 'iconfont'),
                  size: 14.w,
                  color: controller.isFirst()
                      ? Colors.black26
                      : const Color(0xFFFF0033),
                ),
                Text(
                  '上期',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: controller.isFirst()
                        ? Colors.black26
                        : const Color(0xFFFF0033),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.4.w,
            width: 34.w,
            color: Colors.black26,
            margin: EdgeInsets.symmetric(vertical: 10.w),
          ),
          GestureDetector(
            onTap: () {
              if (!controller.isEnd()) {
                controller.nextPeriod();
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Column(
              children: [
                Text(
                  '下期',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: controller.isEnd()
                        ? Colors.black26
                        : const Color(0xFFFF0033),
                  ),
                ),
                Icon(
                  const IconData(0xe683, fontFamily: 'iconfont'),
                  size: 14.w,
                  color: controller.isEnd()
                      ? Colors.black26
                      : const Color(0xFFFF0033),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPivotHeader(TodayPivotController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 28.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.w),
            child: RichText(
              text: TextSpan(
                text: '${controller.lotto}第',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: controller.pivot.period,
                    style: const TextStyle(
                      color: Color(0xFFFF0033),
                    ),
                  ),
                  const TextSpan(text: '期重点推荐'),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    controller.lotto,
                    style: TextStyle(
                        color: const Color(0xFFFF0033), fontSize: 14.sp),
                  ),
                  Text(
                    '·第${controller.pivot.period}期',
                    style: TextStyle(color: Colors.black, fontSize: 14.sp),
                  ),
                ],
              ),
              RichText(
                text: TextSpan(
                  text: '${controller.pivot.data!.browse}',
                  style: TextStyle(
                      color: const Color(0xFFFF0033), fontSize: 14.sp),
                  children: [
                    TextSpan(
                      text: '人浏览',
                      style: TextStyle(fontSize: 12.sp, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPivotDescription() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Text(
        '系统彩研师通过对本期预测数据进行精准分析，给出首要关注号码、重点关注号码以及优质选号推荐。'
        '同时系统会精选一批优质精准预测专家，帮助用户快速掌握本期重点预测方向。今日重点推荐会在每天'
        '17:30点至19点进行更新，请用户随时留意更新。为保护应用内容安全，本功能禁用系统截屏，如有需要请长按预测内容保存图片。',
        style: TextStyle(
          height: 1.3,
          fontSize: 15.sp,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildPivotContent(TodayPivotController controller) {
    return Container(
      padding: EdgeInsets.only(bottom: 8.w, left: 16.w, right: 16.w),
      child: controller.pivot.feeRequired
          ? _buildUnAuthedContent(controller.pivot.data!, controller)
          : _buildAuthedContent(controller.pivot.data!, controller),
    );
  }

  Widget _buildUnAuthedContent(
      TodayPivot pivot, TodayPivotController controller) {
    List<PivotMaster> masters = pivot.mockMasters();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Get.offNamed(AppRoutes.member);
          },
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: [
              ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 3.0.w, sigmaY: 3.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: _pivotItem(
                        '首要关注',
                        pivot.pivotWidget(pivot.mockBest()),
                      ),
                    ),
                    _pivotItem('重点关注', pivot.pivotWidget(pivot.mockSecond())),
                    _pivotItem('优质选号', pivot.pivotWidget(pivot.mockQuality())),
                    _buildPivotMaster(masters, controller, masters.length),
                  ],
                ),
              ),
              MemberHintWidget(
                width: Get.width - 24.w,
                height: 424.w,
                period: controller.pivot.period,
                name: '重点推荐',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAuthedContent(
      TodayPivot pivot, TodayPivotController controller) {
    return GestureDetector(
      onLongPress: () {
        PosterUtils.saveWidget(() => _buildPosterWidget(controller));
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _pivotItem('首要关注', pivot.pivotWidget(pivot.best!)),
          _pivotItem('重点关注', pivot.pivotWidget(pivot.second!)),
          _pivotItem('优质选号', pivot.pivotWidget(pivot.quality!)),
          _buildPivotMaster(pivot.masters, controller, pivot.masters.length),
        ],
      ),
    );
  }

  Widget _buildPosterWidget(TodayPivotController controller) {
    TodayPivot pivot = controller.pivot.data!;
    return Container(
      height: 580.w,
      color: Colors.white,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 16.w),
            child: Text(
              '第${pivot.period}期福彩3D预警分析',
              style: TextStyle(
                fontSize: 17.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _pivotItem('首要关注', pivot.pivotWidget(pivot.best!)),
          _pivotItem('重点关注', pivot.pivotWidget(pivot.second!)),
          _pivotItem('优质选号', pivot.pivotWidget(pivot.quality!)),
          _buildPivotMaster(pivot.masters, controller, 4),
          _buildDelimiter(),
          _buildSharePosterQr(),
        ],
      ),
    );
  }

  Widget _buildDelimiter() {
    return Container(
      height: 0.30.w,
      color: Colors.black12,
      margin: EdgeInsets.only(top: 12.w, bottom: 4.w),
    );
  }

  Widget _buildSharePosterQr() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 12.w),
      child: Row(
        children: [
          SizedBox(
            width: 50.w,
            height: 50.w,
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
            height: 50.w,
            margin: EdgeInsets.only(left: 12.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Profile.props.appName,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '扫码下载APP获取更多精彩内容',
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

  Widget _pivotItem(String title, List<Widget> children) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(bottom: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.w, left: 12.w),
            child: Wrap(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPivotMaster(
      List<PivotMaster> masters, TodayPivotController controller, int size) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '精选专家',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.w, left: 12.w),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: _pivotMasters(masters, controller, size),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _pivotMasters(
      List<PivotMaster> masters, TodayPivotController controller, int size) {
    List<Widget> items = [];
    int length = masters.length < size ? masters.length : size;
    for (int i = 0; i < length; i++) {
      items.add(PivotMasterView(
        name: masters[i].master.name,
        avatar: masters[i].master.avatar,
        rank: masters[i].rank,
        hitValue: MapEntry('七码', masters[i].hit),
        margin: EdgeInsets.only(right: i % 2 == 0 ? 16.w : 0),
        onTap: () {
          Get.toNamed(controller.masterRoute(masters[i].master.masterId));
        },
      ));
    }
    return items;
  }

  Widget _buildPivotHint() {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 24.h),
      child: Column(
        children: [
          Text(
            '以上内容仅供参考，不作为投注依据，请您理性购彩',
            style: TextStyle(
              color: Colors.black38,
              fontSize: 11.sp,
            ),
          ),
          Text(
            '备注说明：本页面禁止截屏，用户可长按预测内容保存图片',
            style: TextStyle(
              color: Colors.black38,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }
}
