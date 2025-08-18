import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/authed_refresh_widget.dart';
import 'package:prize_lottery_app/views/master/controllers/center/ssq_master_controller.dart';
import 'package:prize_lottery_app/views/master/model/master_schema.dart';
import 'package:prize_lottery_app/views/master/widgets/item_rank_panel.dart';
import 'package:prize_lottery_app/views/master/widgets/master_schema_panel.dart';
import 'package:prize_lottery_app/views/master/widgets/multiple_rank_panel.dart';
import 'package:prize_lottery_app/views/master/widgets/recent_browse_view.dart';
import 'package:prize_lottery_app/views/master/widgets/renew_master_swiper.dart';
import 'package:prize_lottery_app/views/rank/model/ssq_master_rank.dart';
import 'package:prize_lottery_app/widgets/dropdown_filter_widget.dart';

class SsqMasterView extends StatefulWidget {
  ///
  ///
  const SsqMasterView({super.key});

  @override
  SsqMasterViewState createState() => SsqMasterViewState();
}

class SsqMasterViewState extends State<SsqMasterView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: const Color(0xFFF8F8FB),
      child: AuthedRefreshWidget<SsqMasterController>(
        global: true,
        enableLoad: false,
        init: SsqMasterController(),
        builder: (controller) {
          return Column(
            children: [
              _buildRecentBrowseView(controller),
              _buildRenewMasterView(controller),
              _buildSchemaListView(controller.schemas),
              _buildRankView(controller.ranks),
              _buildItemRankView(controller),
            ],
          );
        },
      ),
    );
  }

  ///
  ///
  ///
  Widget _buildRecentBrowseView(SsqMasterController controller) {
    return RecentBrowseView(
      name: '双色球',
      type: 'ssq',
      record: controller.browseRecord,
    );
  }

  ///
  ///
  ///
  Widget _buildRenewMasterView(SsqMasterController controller) {
    if (controller.renewMasters.isEmpty || controller.renewMasters.length < 4) {
      return const SizedBox.shrink();
    }
    return RenewMasterSwiper(masters: controller.renewMasters);
  }

  Widget _buildSchemaListView(List<SsqSchema> schemas) {
    return MasterSchemaPanel<SsqSchema>(
      schemas: schemas,
      onTap: (schema) {
        Get.toNamed(schema.modified == 1
            ? '/ssq/forecast/${schema.masterId}'
            : '/ssq/master/${schema.masterId}');
      },
      rateCallback: (schema) {
        return schema.r25;
      },
      achieveCallback: (schema) {
        if (schema.r12Hit == 6 && schema.b5Hit == 1) {
          return '前期预测命中一等奖，杀红三码${schema.rk3.series > 0 ? '连续${schema.rk3.series}期命中' : '上期未命中'}';
        }
        if (schema.r12Hit == 6 && schema.b5Hit == 0) {
          return '上期预测命中二等奖，杀红三码${schema.rk3.series > 0 ? '连续${schema.rk3.series}期命中' : '上期未命中'}';
        }
        return '上期预测命中${schema.r12Hit}+${schema.b5Hit}，杀红三码${schema.rk3.series > 0 ? '连续${schema.rk3.series}期命中' : '上期未命中'}';
      },
    );
  }

  Widget _buildRankView(List<SsqMasterMulRank> ranks) {
    return MultipleRbRankPanel(
      detailPrefix: '/ssq/master/',
      moreRed: () {
        Get.toNamed('/ssq/mul_rank/0');
      },
      moreBlue: () {
        Get.toNamed('/ssq/mul_rank/1');
      },
      ranks: ranks
          .map((e) => MultipleMasterRank(
                rank: e,
                hit: e.rk3,
              ))
          .toList(),
    );
  }

  Widget _buildItemRankView(SsqMasterController controller) {
    return DropdownFilterContainer(
      title: '双色球分类榜',
      initialIndex: controller.initialIndex,
      entries: controller.dropEntries,
      onSelected: (index, entry) {
        controller.currentIndex = index;
      },
      child: ItemRankPanel(
        channel: controller.channel,
        masters: controller.picked,
        detailPrefix: '/ssq/master/',
        rankPrefix: '/ssq/item_rank/',
      ),
    );
  }
}
