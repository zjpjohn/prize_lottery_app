import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/resources/styles.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/master/controllers/detail/fc3d_master_detail_controller.dart';
import 'package:prize_lottery_app/views/master/model/fc3d_master.dart';
import 'package:prize_lottery_app/views/master/widgets/achieve_mark.dart';
import 'package:prize_lottery_app/views/master/widgets/follow_master_sheet.dart';
import 'package:prize_lottery_app/views/master/widgets/master_header.dart';
import 'package:prize_lottery_app/views/master/widgets/toggle_expand.dart';
import 'package:prize_lottery_app/views/master/widgets/trace_master_sheet.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';
import 'package:prize_lottery_app/widgets/common_widgets.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_phasics.dart';
import 'package:prize_lottery_app/widgets/tab_filter_view.dart';

class Fc3dMasterDetailView extends StatefulWidget {
  const Fc3dMasterDetailView({super.key});

  @override
  State<Fc3dMasterDetailView> createState() => _Fc3dMasterDetailViewState();
}

class _Fc3dMasterDetailViewState extends State<Fc3dMasterDetailView> {
  ///
  ///
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: UiStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: RequestWidget<Fc3dMasterDetailController>(
            global: false,
            duration: 50,
            init: Fc3dMasterDetailController(),
            builder: (controller) {
              return ExtendedNestedScrollView(
                onlyOneScrollInBody: true,
                pinnedHeaderSliverHeightBuilder: () => 46,
                headerSliverBuilder: (context, scrolled) {
                  return [
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: MasterHeader(
                        master: controller.master.master,
                        subscribed: controller.master.subscribed,
                        expandedHeight: controller.expandedHeight,
                        widget: buildMasterView(controller),
                        onTap: () {
                          Get.toNamed(
                            '/fc3d/master/feature/${controller.master.master.masterId}',
                          );
                        },
                      ),
                    ),
                    if (controller.showRecommend)
                      SliverToBoxAdapter(
                        child: _buildRecommendMasters(controller),
                      ),
                  ];
                },
                body: TabFilterView(
                  initialIndex: controller.initialIndex,
                  entries: controller.tabEntries,
                  onSelected: (index, entry) {
                    controller.currentIndex = index;
                  },
                  moreIcon: const IconData(0xe616, fontFamily: 'iconfont'),
                  child: Container(
                    color: const Color(0xFFFDFDFD),
                    child: ScrollConfiguration(
                      behavior: CustomScrollBehavior(),
                      child: ListView.builder(
                          padding: EdgeInsets.only(bottom: 16.w),
                          itemCount: controller.histories.length,
                          physics: const EasyRefreshPhysics(topBouncing: false),
                          itemBuilder: (context, index) {
                            return CommonWidgets.hitItemView(
                                controller.current[index]);
                          }),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildMasterView(Fc3dMasterDetailController controller) {
    Fc3dMasterDetail detail = controller.master;
    return SizedBox(
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16.w, top: 10.w, bottom: 10.w),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 18.w),
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEBEBEB),
                    borderRadius: BorderRadius.circular(25.w),
                  ),
                  child: CachedAvatar(
                    width: 42.w,
                    height: 42.w,
                    radius: 25.w,
                    url: detail.master.avatar,
                  ),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 4.w),
                          child: Text(
                            '浏览量',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        Text(
                          '${detail.master.browse}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontFamily: 'bebas',
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30.w),
                      color: Colors.black54,
                      height: 20.w,
                      width: 0.25.w,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 4.w),
                          child: Text(
                            '关注量',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        Text(
                          '${detail.master.subscribe}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontFamily: 'bebas',
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30.w),
                      color: Colors.black54,
                      height: 20.w,
                      width: 0.25.w,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 4.w),
                          child: Text(
                            '搜索量',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        Text(
                          '${detail.master.browse}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontFamily: 'bebas',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16.w, bottom: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 1.5.w),
                  child: Text(
                    Tools.limitText(detail.master.name, 8),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  '专家多维度历史详情，为您提供精准判断',
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16.w, bottom: 6.w),
            child: Row(
              children: [
                Text(
                  '擅长：',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  getSkillTxt(detail).join('、'),
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: Get.width,
            height: 30.w,
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  SizedBox(width: 16.w),
                  if (detail.dan3 != null)
                    AchieveMark(name: '三胆', achieve: detail.dan3!.count),
                  if (detail.com7 != null)
                    AchieveMark(name: '七码', achieve: detail.com7!.count),
                  if (detail.kill1 != null)
                    AchieveMark(name: '杀一', achieve: detail.kill1!.count),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (detail.subscribed == 1) {
                        Constants.bottomSheet(
                          FollowMasterSheet(
                            masterId: detail.master.masterId,
                            trace: detail.trace,
                            traceZh: detail.traceZh,
                            special: detail.special,
                            traceTap: () {
                              Navigator.of(context).pop();
                              Constants.bottomSheet(
                                TraceMasterSheet(
                                  title: '追踪专家',
                                  trace: detail.trace,
                                  traceZh: detail.traceZh,
                                  hits: controller.getTraceHits(),
                                  onTrace: (trace, traceZh) {
                                    controller.traceMaster(trace, traceZh);
                                  },
                                ),
                              );
                            },
                            cancelTap: () {
                              controller.cancelFollow(() {
                                Navigator.of(context).pop();
                              });
                            },
                            specialTap: () {
                              controller.specialFollow();
                            },
                          ),
                        );
                        return;
                      }
                      Constants.bottomSheet(
                        TraceMasterSheet(
                          title: '关注追踪',
                          leftTitle: '仅关注',
                          trace: detail.trace,
                          traceZh: detail.traceZh,
                          hits: controller.getTraceHits(),
                          leftTap: () {
                            controller.followMaster(success: () {
                              Navigator.of(context).pop();
                            });
                          },
                          onTrace: (trace, traceZh) {
                            controller.followMaster(
                              trace: trace,
                              traceZh: traceZh,
                              success: () {
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 32.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: detail.subscribed == 1
                            ? const Color(0xFFF4F4F4)
                            : const Color(0xFFFD4A68),
                        borderRadius: BorderRadius.circular(4.w),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            detail.subscribed == 1 ? '已关注' : '关注专家',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: detail.subscribed == 1
                                  ? Colors.black87
                                  : Colors.white,
                            ),
                          ),
                          if (detail.subscribed == 1)
                            Padding(
                              padding: EdgeInsets.only(left: 2.w),
                              child: Icon(
                                const IconData(0xe67d, fontFamily: 'iconfont'),
                                size: 10.sp,
                                color: Colors.black87,
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 14.w,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed('/fc3d/forecast/${detail.master.masterId}');
                    },
                    child: Container(
                      height: 32.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: detail.modified == 1
                            ? const Color(0xFFFd4A68)
                            : const Color(0xFFF4F4F4),
                        borderRadius: BorderRadius.circular(4.w),
                      ),
                      child: Text(
                        detail.modified == 1 ? '查看方案' : '历史方案',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: detail.modified == 1
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.showRecommendMasters(() {
                      (_key.currentState as ToggleExpandState).toggleExpand();
                    });
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 38.w,
                    height: 32.w,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 8.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                    child: controller.recommendLoading
                        ? SpinKitRing(
                            color: Colors.black,
                            lineWidth: 1.8.w,
                            size: 12.w,
                            duration: const Duration(milliseconds: 600),
                          )
                        : ToggleExpand(key: _key),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<String> getSkillTxt(Fc3dMasterDetail detail) {
    List<String> txt = [];
    if (detail.dan3 != null && detail.dan3!.rate >= 0.75) {
      txt.add('三胆');
    }
    if (detail.com6 != null && detail.com6!.rate >= 0.8) {
      txt.add('六码');
    }
    if (detail.com7 != null && detail.com7!.rate >= 0.8) {
      txt.add('七码');
    }
    if (detail.kill1 != null && detail.kill1!.rate >= 0.8) {
      txt.add('杀一码');
    }
    if (detail.kill2 != null && detail.kill2!.rate >= 0.75) {
      txt.add('杀二码');
    }
    if (txt.isEmpty) {
      txt.add('加油ing');
    }
    return txt;
  }

  Widget _buildRecommendMasters(Fc3dMasterDetailController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.w, top: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 12.w, left: 16.w),
            child: Text(
              '您可能感兴趣',
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.black38,
              ),
            ),
          ),
          ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 16.w),
                  ...controller.masters.map(
                    (e) => GestureDetector(
                      onTap: () {
                        Get.toNamed('/fc3d/master/${e.master.masterId}');
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: EdgeInsets.all(0.3.w),
                        margin: EdgeInsets.only(right: 16.w, bottom: 4.w),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.w),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CachedAvatar(
                                width: 56.w,
                                height: 56.w,
                                radius: 30.w,
                                url: e.master.avatar,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.w),
                                child: Text(
                                  Tools.limitText(e.master.name.trim(), 4),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                    text: '七码',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.black87,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: e.com7.count,
                                        style: const TextStyle(
                                          color: Color(0xFFFF0045),
                                        ),
                                      ),
                                      const TextSpan(text: '期'),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
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
}
