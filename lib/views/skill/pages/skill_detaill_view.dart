import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/model/enum_value.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/utils/date_util.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/news/model/lottery_news.dart';
import 'package:prize_lottery_app/views/rank/model/ssq_master_rank.dart';
import 'package:prize_lottery_app/views/skill/controller/skill_detail_controller.dart';
import 'package:prize_lottery_app/views/skill/model/lottery_skill.dart';
import 'package:prize_lottery_app/widgets/aspect_ratio_cache_image.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class SkillDetailView extends StatelessWidget {
  ///
  ///
  const SkillDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '实用技巧',
      content: Container(
        color: Colors.white,
        child: RequestWidget<SkillDetailController>(
          global: false,
          init: SkillDetailController(),
          builder: (controller) {
            return ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSkillPanel(controller.skill),
                    _buildRankPanel(controller.ranks),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _intervalBlock() {
    return Container(
      height: 12.w,
      alignment: Alignment.center,
      color: const Color(0xFFF6F6FB),
    );
  }

  Widget _buildSkillPanel(LotterySkill skill) {
    return Container(
      padding: EdgeInsets.only(top: 16.w, bottom: 16.w),
      child: Column(
        children: [
          _buildSkillTitle(skill.title),
          _buildSubTitle(skill.gmtCreate),
          _buildSkillContent(skill.content!),
          _buildSkillTag(skill.type),
        ],
      ),
    );
  }

  Widget _buildSkillTitle(String title) {
    return Container(
      margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 4.w),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        maxLines: 2,
        style: TextStyle(
          fontSize: 18.sp,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSubTitle(DateTime time) {
    return Container(
      margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 8.w),
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '哇彩助手',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Text(
              DateUtil.formatDate(time, format: 'yyyy/MM/dd HH:mm'),
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.black38,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillContent(NewsContent content) {
    int pCount = content.paragraphs.length;
    List<Widget> views = [];
    for (int i = 0; i < pCount; i++) {
      NewsParagraph e = content.paragraphs[i];
      views.add(
        e.type == 2
            ? Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 12.w, bottom: 12.w),
                child: AspectRatioCacheImage(
                  width: Get.width - 24.w,
                  height: 100.h,
                  url: e.content.isNotEmpty
                      ? '${e.content}?x-oss-process=image/resize,w_500'
                      : '',
                ),
              )
            : Container(
                padding: EdgeInsets.only(top: 6.w, left: 12.w, right: 12.w),
                child: Text(
                  '    ${e.content.trim()}',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15.sp,
                    height: 1.25,
                  ),
                ),
              ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: views,
    );
  }

  Widget _buildSkillTag(EnumValue type) {
    return Container(
      margin: EdgeInsets.only(left: 12.w, right: 12.w, top: 16.w, bottom: 8.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (lottoRankMaps[type.value] == null) {
                return;
              }
              Get.toNamed(lottoRankMaps[type.value]!);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16.w),
              ),
              child: Row(
                children: [
                  Image.asset(R.tag, width: 12.w, height: 12.w),
                  Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: Text(
                      type.description,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.skillList);
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              margin: EdgeInsets.only(left: 16.w),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.w),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16.w),
              ),
              child: Row(
                children: [
                  Image.asset(R.tag, width: 12.w, height: 12.w),
                  Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: Text(
                      '实用技巧',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.skillList, arguments: {'type': type.value});
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              margin: EdgeInsets.only(left: 16.w),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.w),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16.w),
              ),
              child: Row(
                children: [
                  Image.asset(R.tag, width: 12.w, height: 12.w),
                  Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: Text(
                      '${type.description}技巧',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 12.sp,
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

  Widget _buildRankPanel(List<SsqMasterMulRank> ranks) {
    if (ranks.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: EdgeInsets.only(bottom: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _intervalBlock(),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 16.w, bottom: 6.w),
            child: Text(
              '— 双色球大师精选 —',
              style: TextStyle(
                color: const Color(0xFFFF0044),
                fontSize: 13.sp,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10.w),
            decoration: const BoxDecoration(),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  SizedBox(width: 16.w),
                  ...ranks.map((e) => _buildMasterItem(e)),
                  SizedBox(width: 16.w),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMasterItem(SsqMasterMulRank rank) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/ssq/master/${rank.master.masterId}');
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 66.w,
              height: 76.w,
              margin: EdgeInsets.only(bottom: 4.w),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.w),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(rank.master.avatar),
                ),
              ),
            ),
            Text(
              Tools.limitText(rank.master.name, 5),
              style: TextStyle(color: Colors.black, fontSize: 13.sp),
            ),
            Container(
              margin: EdgeInsets.only(top: 2.w),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(text: '最近'),
                    TextSpan(
                      text: rank.rk3.count,
                      style: const TextStyle(color: Color(0xFFFF0044)),
                    ),
                    const TextSpan(text: '期'),
                  ],
                  style: TextStyle(fontSize: 10.5.sp, color: Colors.black38),
                ),
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(text: '近期连红'),
                  TextSpan(
                    text: '${rank.rk3.series}',
                    style: const TextStyle(color: Color(0xFFFF0044)),
                  ),
                  const TextSpan(text: '期'),
                ],
                style: TextStyle(fontSize: 10.5.sp, color: Colors.black38),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
