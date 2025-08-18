import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/views/glad/controller/fc3d_glad_list_controller.dart';
import 'package:prize_lottery_app/views/glad/model/fc3d_master_glad.dart';
import 'package:prize_lottery_app/views/glad/widgets/master_glad_view.dart';
import 'package:prize_lottery_app/views/glad/widgets/master_recommend_panel.dart';
import 'package:prize_lottery_app/views/rank/model/fc3d_master_rank.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class Fc3dGladListView extends StatefulWidget {
  ///
  ///
  const Fc3dGladListView({super.key});

  @override
  Fc3dGladListViewState createState() => Fc3dGladListViewState();
}

class Fc3dGladListViewState extends State<Fc3dGladListView> {
  ///
  ///
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '中奖专家',
      content: Container(
        color: const Color(0xFFF6F6F6),
        child: RefreshWidget<Fc3dGladListController>(
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

  Widget _buildRecommendView(List<Fc3dMasterMulRank> masters) {
    return MasterRecommendPanel<Fc3dMasterMulRank>(
      masters: masters,
      tapCallback: (master) {
        Get.toNamed(
          '/fc3d/master/${master.master.masterId}',
          parameters: {'channel': 'k1'},
        );
      },
      hitCallback: (master) {
        return master.com7;
      },
    );
  }

  Widget _buildGladMasterView(Fc3dMasterGlad glad, int index, bool bordered) {
    return MasterGladView<Fc3dMasterGlad>(
      glad: glad,
      border: bordered,
      showAds: index > 0 && index % 15 == 3,
      hitValue: HitValue(name: '七码', hit: glad.com7),
      masterTap: (glad) {
        Get.toNamed(
          '/fc3d/master/${glad.master.masterId}',
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
