import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/views/glad/controller/pl3_glad_list_controller.dart';
import 'package:prize_lottery_app/views/glad/model/pl3_master_glad.dart';
import 'package:prize_lottery_app/views/glad/widgets/master_glad_view.dart';
import 'package:prize_lottery_app/views/glad/widgets/master_recommend_panel.dart';
import 'package:prize_lottery_app/views/rank/model/pl3_master_rank.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class Pl3GladListView extends StatefulWidget {
  ///
  ///
  const Pl3GladListView({super.key});

  @override
  Pl3GladListViewState createState() => Pl3GladListViewState();
}

class Pl3GladListViewState extends State<Pl3GladListView> {
  ///
  ///
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '中奖专家',
      content: Container(
        color: const Color(0xFFF6F6F6),
        child: RefreshWidget<Pl3GladListController>(
          scrollController: _scrollController,
          topConfig: const ScrollTopConfig(align: TopAlign.right),
          builder: (controller) {
            return ListView.builder(
              itemCount: controller.glads.length + 1,
              padding: EdgeInsets.only(top: 0.w),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildRecommendView(controller.recommends);
                }
                return _buildGladMasterView(
                  controller.glads[index - 1],
                  index - 1,
                  index < controller.glads.length,
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildRecommendView(List<Pl3MasterMulRank> masters) {
    return MasterRecommendPanel<Pl3MasterMulRank>(
      masters: masters,
      tapCallback: (master) {
        Get.toNamed(
          '/pl3/master/${master.master.masterId}',
          parameters: {'channel': 'k1'},
        );
      },
      hitCallback: (master) {
        return master.com7;
      },
    );
  }

  Widget _buildGladMasterView(Pl3MasterGlad glad, int index, bool bordered) {
    return MasterGladView<Pl3MasterGlad>(
      glad: glad,
      border: bordered,
      showAds: index > 0 && index % 15 == 3,
      hitValue: HitValue(name: '七码', hit: glad.com7),
      masterTap: (glad) {
        Get.toNamed(
          '/pl3/master/${glad.master.masterId}',
          parameters: {'channel': 'd3'},
        );
      },
      achievedCallback: (glad) {
        return {
          '三胆': glad.dan3.count,
          '六码': glad.com6.count,
          '杀一码': glad.kill1.count,
        };
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

}
