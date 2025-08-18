import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/authed_refresh_widget.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/views/master/controllers/center/qlc_master_controller.dart';
import 'package:prize_lottery_app/views/master/model/master_schema.dart';
import 'package:prize_lottery_app/views/master/widgets/item_rank_panel.dart';
import 'package:prize_lottery_app/views/master/widgets/master_schema_panel.dart';
import 'package:prize_lottery_app/views/master/widgets/multiple_rank_panel.dart';
import 'package:prize_lottery_app/views/master/widgets/recent_browse_view.dart';
import 'package:prize_lottery_app/views/master/widgets/renew_master_swiper.dart';
import 'package:prize_lottery_app/views/rank/model/qlc_master_rank.dart';
import 'package:prize_lottery_app/widgets/dropdown_filter_widget.dart';

class QlcMasterView extends StatefulWidget {
  ///
  ///
  const QlcMasterView({super.key});

  @override
  QlcMasterViewState createState() => QlcMasterViewState();
}

class QlcMasterViewState extends State<QlcMasterView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: const Color(0xFFF8F8FB),
      child: AuthedRefreshWidget<QlcMasterController>(
        global: true,
        enableLoad: false,
        init: QlcMasterController(),
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

  Widget _buildRecentBrowseView(QlcMasterController controller) {
    return RecentBrowseView(
      name: '七乐彩',
      type: 'qlc',
      record: controller.browseRecord,
    );
  }

  Widget _buildRenewMasterView(QlcMasterController controller) {
    if (controller.renewMasters.isEmpty || controller.renewMasters.length < 4) {
      return const SizedBox.shrink();
    }
    return RenewMasterSwiper(masters: controller.renewMasters);
  }

  Widget _buildSchemaListView(List<QlcSchema> schemas) {
    return MasterSchemaPanel<QlcSchema>(
      schemas: schemas,
      onTap: (schema) {
        Get.toNamed(schema.modified == 1
            ? '/qlc/forecast/${schema.masterId}'
            : '/qlc/master/${schema.masterId}');
      },
      rateCallback: (schema) {
        return schema.red22;
      },
      achieveCallback: (schema) {
        if (schema.r12Hit == 7) {
          return '前期预测12码命中一等奖，杀3码'
              '${schema.k3.series > 0 ? '连续${schema.k3.series}期命中' : '上期未命中'}';
        }
        if (schema.r12Hit == 6) {
          return '上期预测12码命中二等奖，杀3码'
              '${schema.k3.series > 0 ? '连续${schema.k3.series}期命中' : '上期未命中'}';
        }
        return '上期预测12码中${schema.r12Hit}，杀3码'
            '${schema.k3.series > 0 ? '连续${schema.k3.series}期命中' : '上期未命中'}';
      },
    );
  }

  Widget _buildRankView(List<QlcMasterMulRank> ranks) {
    return MultipleRankPanel(
      detailPrefix: '/qlc/master/',
      moreAction: () {
        Get.toNamed(AppRoutes.qlcMulRank);
      },
      ranks: ranks
          .map((e) => MultipleMasterRank(
                rank: e,
                hit: e.red22,
              ))
          .toList(),
    );
  }

  Widget _buildItemRankView(QlcMasterController controller) {
    return DropdownFilterContainer(
      title: '七乐彩分类榜',
      initialIndex: controller.initialIndex,
      entries: controller.dropEntries,
      onSelected: (index, entry) {
        controller.currentIndex = index;
      },
      child: ItemRankPanel(
        channel: controller.channel,
        masters: controller.picked,
        detailPrefix: '/qlc/master/',
        rankPrefix: '/qlc/item_rank/',
      ),
    );
  }
}
