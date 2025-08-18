import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/views/skill/controller/skill_list_controller.dart';
import 'package:prize_lottery_app/views/skill/model/lottery_skill.dart';
import 'package:prize_lottery_app/widgets/feed_item_widget.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class SkillListView extends StatefulWidget {
  ///
  ///
  const SkillListView({super.key});

  @override
  SkillListViewState createState() => SkillListViewState();
}

class SkillListViewState extends State<SkillListView> {
  ///
  ///
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '技巧攻略',
      content: Container(
        color: Colors.white,
        child: RefreshWidget<SkillListController>(
          global: false,
          init: SkillListController(),
          scrollController: _scrollController,
          topConfig: const ScrollTopConfig(align: TopAlign.right),
          builder: (controller) {
            return ListView.builder(
              itemCount: controller.skills.length,
              itemBuilder: (context, index) =>
                  _buildSkillItem(
                    controller.skills[index],
                    index,
                    index < controller.skills.length - 1,
                    controller.limit,
                  ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSkillItem(LotterySkill skill,
      int index,
      bool border,
      int pageSize,) {
    return FeedItemWidget(
      title: skill.title,
      delta: skill.delta,
      header: skill.header,
      browse: skill.browse,
      border: border,
      showAds: index > 0 && index % 20 == 4,
      onTap: () {
        Get.toNamed('/skill/detail/${skill.seq}');
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
