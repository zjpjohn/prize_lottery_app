import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/resources/colors.dart';
import 'package:prize_lottery_app/resources/constants.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/glad/model/dlt_master_glad.dart';
import 'package:prize_lottery_app/views/home/controller/skill_home_controller.dart';
import 'package:prize_lottery_app/views/master/widgets/search_master_rank.dart';
import 'package:prize_lottery_app/views/rank/model/dlt_master_rank.dart';
import 'package:prize_lottery_app/views/skill/model/lottery_skill.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_phasics.dart';
import 'package:prize_lottery_app/widgets/feed_item_widget.dart';

class SkillHomeView extends StatefulWidget {
  ///
  ///
  const SkillHomeView({super.key});

  @override
  SkillHomeViewState createState() => SkillHomeViewState();
}

class SkillHomeViewState extends State<SkillHomeView>
    with AutomaticKeepAliveClientMixin {
  ///
  ///
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshWidget<SkillHomeController>(
      init: SkillHomeController(),
      scrollController: _scrollController,
      topConfig: const ScrollTopConfig(align: TopAlign.right),
      builder: (controller) {
        return _buildSkillHomeView(controller);
      },
    );
  }

  Widget _buildSkillHomeView(SkillHomeController controller) {
    return ListView.builder(
      itemCount: controller.skills.length + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildMaterRankView(controller.ranks, controller.glads);
        }
        if (index == 1) {
          return _buildSkillPanelHeader();
        }
        return _buildSkillItem(
          controller.skills[index - 2],
          index - 2,
          index - 2 < controller.skills.length - 1,
          controller.limit,
        );
      },
    );
  }

  Widget _buildMaterRankView(
      List<DltMasterMulRank> ranks, List<DltMasterGlad> glads) {
    if (ranks.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      padding: EdgeInsets.only(top: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white, width: 0.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 12.w),
            child: SizedBox(
              height: 24.w,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Container(
                      width: 60.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.w),
                          bottomLeft: Radius.circular(5.w),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.blueAccent.withValues(alpha: 0.75),
                            Colors.blueAccent.withValues(alpha: 0.05),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 1.w),
                    child: Text(
                      '大乐透热榜',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 6.w),
            padding: EdgeInsets.only(top: 6.w),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const EasyRefreshPhysics(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 12.w, right: 12.w),
                    padding: EdgeInsets.only(
                      left: 12.w,
                      top: 10.w,
                      right: 10.w,
                      bottom: 2.w,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.w),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.redAccent.withValues(alpha: 0.1),
                          Colors.redAccent.withValues(alpha: 0.025),
                        ],
                      ),
                    ),
                    child: Column(
                      children: ranks.map((e) => _buildMasterRank(e)).toList(),
                    ),
                  ),
                  _buildMasterGladView(glads),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMasterRank(DltMasterMulRank rank) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Get.toNamed('/dlt/master/${rank.master.masterId}');
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8.w),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 12.w),
                  child: CachedAvatar(
                    width: 24.w,
                    height: 24.w,
                    url: rank.master.avatar,
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: ClipPath(
                    clipper: VoucherClipper(),
                    child: Container(
                      width: 13.w,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 1.w, bottom: 5.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            itemRankColors[rank.rank <= 4 ? rank.rank : 4]!,
                            itemRankColors[rank.rank <= 4 ? rank.rank : 4]!
                                .withValues(alpha: 0.6),
                          ],
                        ),
                      ),
                      child: Text(
                        '${rank.rank}',
                        style: TextStyle(
                          fontSize: 9.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 24.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100.w,
                    child: Text(
                      Tools.limitText(rank.master.name, 7),
                      textAlign: TextAlign.start,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontSize: 12.sp,
                        height: 0.98,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '最近',
                      style: TextStyle(color: Colors.black26, fontSize: 9.sp),
                      children: [
                        TextSpan(
                          text: rank.rk.count,
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                        const TextSpan(text: '期'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMasterGladView(List<DltMasterGlad> glads) {
    return Row(
      children: [
        ...List.generate(2, (index) {
          return Container(
            margin: EdgeInsets.only(right: 10.w),
            padding: EdgeInsets.only(
              top: 10.w,
              left: 12.w,
              right: 12.w,
              bottom: 2.w,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.w),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.redAccent.withValues(alpha: 0.1),
                  Colors.redAccent.withValues(alpha: 0.025),
                ],
              ),
            ),
            child: Column(
              children: [
                _buildMasterGlad(glads[index * 3]),
                _buildMasterGlad(glads[index * 3 + 1]),
                _buildMasterGlad(glads[index * 3 + 2]),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildMasterGlad(DltMasterGlad glad) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Get.toNamed('/dlt/master/${glad.master.masterId}');
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8.w),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 12.w),
              child: CachedAvatar(
                width: 24.w,
                height: 24.w,
                radius: 3.w,
                url: glad.master.avatar,
              ),
            ),
            SizedBox(
              height: 24.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 110.w,
                    child: Text(
                      Tools.limitText(glad.master.name, 8),
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12.sp,
                        height: 0.98,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '上期预测命中',
                      style: TextStyle(color: Colors.black26, fontSize: 9.sp),
                      children: [
                        TextSpan(
                          text: dltLevel['${glad.r20Hit}${glad.b6Hit}'],
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSkillPanelHeader() {
    return Container(
      padding: EdgeInsets.only(left: 12.w, top: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white, width: 0.0),
      ),
      child: Row(
        children: [
          Image.asset(R.skillOut, height: 18.w),
          Padding(
            padding: EdgeInsets.only(left: 4.w, bottom: 2.w),
            child: Text(
              '实用技巧',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillItem(
    LotterySkill skill,
    int index,
    bool border,
    int pageSize,
  ) {
    return FeedItemWidget(
      title: skill.title,
      delta: skill.delta,
      header: skill.header,
      browse: skill.browse,
      border: border,
      showAds: index > 0 && index % 20 == 3,
      onTap: () {
        Get.toNamed('/skill/detail/${skill.seq}');
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
