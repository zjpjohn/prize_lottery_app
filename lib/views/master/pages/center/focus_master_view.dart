import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/store/store.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/master/controllers/center/focus_master_controller.dart';
import 'package:prize_lottery_app/views/master/model/recommend_master.dart';
import 'package:prize_lottery_app/views/master/widgets/subscrib_master_widget.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';

class FocusMasterView extends StatefulWidget {
  ///
  ///
  const FocusMasterView({super.key});

  @override
  FocusMasterViewState createState() => FocusMasterViewState();
}

class FocusMasterViewState extends State<FocusMasterView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: const Color(0xFFF8F8FB),
      child: _buildContainerView(),
    );
  }

  Widget _buildContainerView() {
    return GetBuilder<UserStore>(builder: (store) {
      if (store.authUser == null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              R.unLoginIllus,
              width: 180.w,
              height: 180.w,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.login);
              },
              behavior: HitTestBehavior.opaque,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '登录后查看，',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black26,
                    ),
                  ),
                  Text(
                    '去登录吧',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFFFFAC27),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }
      return GetBuilder<FocusMasterController>(
          init: FocusMasterController(),
          builder: (controller) {
            return RefreshWidget<FocusMasterController>(
              init: FocusMasterController(),
              enableLoad: controller.total > 0,
              enableRefresh: controller.total > 0,
              builder: (_) {
                if (controller.total == 0) {
                  return Container(
                    padding: EdgeInsets.only(top: 20.w),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildRecommendTitle(),
                          ...controller.recommends
                              .map((e) => _buildRecommendView(e)),
                          _buildBatchFocusBtn(controller),
                        ],
                      ),
                    ),
                  );
                }
                return Column(
                  children: controller.focusList
                      .map((e) => SubscribeMasterWidget(master: e))
                      .toList(),
                );
              },
            );
          });
    });
  }

  Widget _buildRecommendTitle() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 20.w),
      child: Text(
        '系统为您推荐以下优秀专家',
        style: TextStyle(
          fontSize: 14.5.sp,
          color: const Color(0xFFFF0033).withValues(alpha: 0.75),
        ),
      ),
    );
  }

  Widget _buildBatchFocusBtn(FocusMasterController controller) {
    return Container(
      margin: EdgeInsets.only(top: 16.w, bottom: 32.w),
      width: 240.w,
      height: 38.w,
      decoration: BoxDecoration(
        color: const Color(0xFFFD4A68),
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: GestureDetector(
        onTap: () {
          controller.batchFocusMasters();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '一键关注专家',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Icon(
                const IconData(0xe8b1, fontFamily: 'iconfont'),
                size: 18.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendView(RecommendMaster master) {
    return Container(
      margin: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: GestureDetector(
        onTap: () {
          Get.toNamed('/${master.type.value}/master/${master.master.masterId}');
        },
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 12.w,
                bottom: 8.w,
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 14.w),
                    alignment: Alignment.center,
                    child: CachedAvatar(
                      width: 42.w,
                      height: 42.w,
                      radius: 25.w,
                      color: const Color(0xFFF9F9F9),
                      url: master.master.avatar,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 8.w),
                          padding: EdgeInsets.only(top: 8.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                Tools.limitName(master.master.name, 9),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: 8.w),
                          child: Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 13.sp, color: Colors.black38),
                                  children: [
                                    const TextSpan(text: '近'),
                                    TextSpan(
                                      text: master.hitCount,
                                      style: const TextStyle(
                                        color: Color(0xFFFF0033),
                                      ),
                                    ),
                                    const TextSpan(text: '期'),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 12.w),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13.sp, color: Colors.black38),
                                    children: [
                                      const TextSpan(text: '连红'),
                                      TextSpan(
                                        text: '${master.series}',
                                        style: const TextStyle(
                                          color: Color(0xFFFF0033),
                                        ),
                                      ),
                                      const TextSpan(text: '期'),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 12.w),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13.sp, color: Colors.black38),
                                    children: [
                                      const TextSpan(text: '命中率'),
                                      TextSpan(
                                        text:
                                            '${(master.hitRate * 100).toInt()}%',
                                        style: TextStyle(
                                          color: const Color(0xFFFF0033),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0.5.w,
              left: 0.5.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.w),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6.w),
                    bottomRight: Radius.circular(6.w),
                  ),
                ),
                child: Text(
                  master.type.description,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: const Color(0xFFFF0033).withValues(alpha: 0.75),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
