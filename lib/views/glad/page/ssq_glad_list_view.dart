import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/views/glad/controller/ssq_glad_list_controller.dart';
import 'package:prize_lottery_app/views/glad/model/ssq_master_glad.dart';
import 'package:prize_lottery_app/views/glad/widgets/master_glad_view.dart';
import 'package:prize_lottery_app/views/glad/widgets/master_recommend_panel.dart';
import 'package:prize_lottery_app/views/rank/model/ssq_master_rank.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class SsqGladListView extends StatefulWidget {
  ///
  ///
  const SsqGladListView({super.key});

  @override
  SsqGladListViewState createState() => SsqGladListViewState();
}

class SsqGladListViewState extends State<SsqGladListView> {
  ///
  ///
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '中奖专家',
      content: Container(
        color: const Color(0xFFF6F6F6),
        child: RefreshWidget<SsqGladListController>(
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

  Widget _buildRecommendView(List<SsqMasterMulRank> masters) {
    return MasterRecommendPanel<SsqMasterMulRank>(
      masters: masters,
      tapCallback: (master) {
        Get.toNamed('/ssq/master/${master.master.masterId}');
      },
      hitCallback: (master) {
        return master.rk3;
      },
    );
  }

  Widget _buildGladMasterView(SsqMasterGlad glad, int index, bool bordered) {
    return MasterGladView<SsqMasterGlad>(
      glad: glad,
      border: bordered,
      showAds: index > 0 && index % 15 == 3,
      hitValue: HitValue(name: '25码', hit: glad.red25),
      masterTap: (glad) {
        Get.toNamed(
          '/ssq/master/${glad.master.masterId}',
          parameters: {'channel': 'r25'},
        );
      },
      achievedCallback: (glad) {
        return {
          '三胆': glad.red3.count,
          '25码': glad.red25.count,
          '杀三码': glad.rk3.count,
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
