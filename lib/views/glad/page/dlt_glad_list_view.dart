import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/views/glad/controller/dlt_glad_list_controller.dart';
import 'package:prize_lottery_app/views/glad/model/dlt_master_glad.dart';
import 'package:prize_lottery_app/views/glad/widgets/master_glad_view.dart';
import 'package:prize_lottery_app/views/glad/widgets/master_recommend_panel.dart';
import 'package:prize_lottery_app/views/rank/model/dlt_master_rank.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class DltGladListView extends StatefulWidget {
  ///
  ///
  const DltGladListView({super.key});

  @override
  DltGladListViewState createState() => DltGladListViewState();
}

class DltGladListViewState extends State<DltGladListView> {
  ///
  ///
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '中奖专家',
      content: Container(
        color: const Color(0xFFF6F6F6),
        child: RefreshWidget<DltGladListController>(
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

  Widget _buildRecommendView(List<DltMasterMulRank> masters) {
    return MasterRecommendPanel<DltMasterMulRank>(
      masters: masters,
      tapCallback: (master) {
        Get.toNamed(
          '/dlt/master/${master.master.masterId}',
          parameters: {'channel': 'rk3'},
        );
      },
      hitCallback: (master) {
        return master.rk;
      },
    );
  }

  Widget _buildGladMasterView(DltMasterGlad glad, int index, bool bordered) {
    return MasterGladView<DltMasterGlad>(
      glad: glad,
      border: bordered,
      showAds: index > 0 && index % 15 == 3,
      hitValue: HitValue(name: '20码', hit: glad.red20),
      masterTap: (glad) {
        Get.toNamed(
          '/dlt/master/${glad.master.masterId}',
          parameters: {'channel': 'r20'},
        );
      },
      achievedCallback: (glad) {
        return {
          '三胆': glad.red3.count,
          '20码': glad.red20.count,
          '杀三码': glad.rk.count,
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
