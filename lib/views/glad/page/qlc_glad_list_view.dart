import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/views/rank/model/qlc_master_rank.dart';
import 'package:prize_lottery_app/views/glad/model/qlc_master_glad.dart';
import 'package:prize_lottery_app/views/glad/widgets/master_glad_view.dart';
import 'package:prize_lottery_app/views/glad/widgets/master_recommend_panel.dart';
import 'package:prize_lottery_app/views/glad/controller/qlc_glad_list_controller.dart';

class QlcGladListView extends StatefulWidget {
  ///
  ///
  const QlcGladListView({super.key});

  @override
  QlcGladListViewState createState() => QlcGladListViewState();
}

class QlcGladListViewState extends State<QlcGladListView> {
  ///
  ///
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '中奖专家',
      content: Container(
        color: const Color(0xFFF6F6F6),
        child: RefreshWidget<QlcGladListController>(
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

  Widget _buildRecommendView(List<QlcMasterMulRank> masters) {
    return MasterRecommendPanel<QlcMasterMulRank>(
      masters: masters,
      tapCallback: (master) {
        Get.toNamed('/qlc/master/${master.master.masterId}');
      },
      hitCallback: (master) {
        return master.red22;
      },
    );
  }

  Widget _buildGladMasterView(QlcMasterGlad glad, int index, bool bordered) {
    return MasterGladView<QlcMasterGlad>(
      glad: glad,
      border: bordered,
      showAds: index > 0 && index % 15 == 3,
      hitValue: HitValue(name: '22码', hit: glad.red22),
      masterTap: (glad) {
        Get.toNamed(
          '/qlc/master/${glad.master.masterId}',
          parameters: {'channel': 'r22'},
        );
      },
      achievedCallback: (glad) {
        return {
          '三胆': glad.red3.count,
          '22码': glad.red22.count,
          '杀三码': glad.kill3.count,
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
