import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/authed_refresh_widget.dart';
import 'package:prize_lottery_app/views/master/controllers/center/dlt_master_controller.dart';
import 'package:prize_lottery_app/views/master/model/master_schema.dart';
import 'package:prize_lottery_app/views/master/widgets/item_rank_panel.dart';
import 'package:prize_lottery_app/views/master/widgets/master_schema_panel.dart';
import 'package:prize_lottery_app/views/master/widgets/multiple_rank_panel.dart';
import 'package:prize_lottery_app/views/master/widgets/recent_browse_view.dart';
import 'package:prize_lottery_app/views/master/widgets/renew_master_swiper.dart';
import 'package:prize_lottery_app/views/rank/model/dlt_master_rank.dart';
import 'package:prize_lottery_app/widgets/dropdown_filter_widget.dart';

class DltMasterView extends StatefulWidget {
  ///
  ///
  const DltMasterView({super.key});

  @override
  DltMasterViewState createState() => DltMasterViewState();
}

class DltMasterViewState extends State<DltMasterView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: const Color(0xFFF8F8FB),
      child: AuthedRefreshWidget<DltMasterController>(
        global: true,
        enableLoad: false,
        init: DltMasterController(),
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

  Widget _buildRecentBrowseView(DltMasterController controller) {
    return RecentBrowseView(
      name: '大乐透',
      type: 'dlt',
      record: controller.browseRecord,
    );
  }

  Widget _buildRenewMasterView(DltMasterController controller) {
    if (controller.renewMasters.isEmpty || controller.renewMasters.length < 4) {
      return const SizedBox.shrink();
    }
    return RenewMasterSwiper(masters: controller.renewMasters);
  }

  Widget _buildSchemaListView(List<DltSchema> schemas) {
    return MasterSchemaPanel<DltSchema>(
      schemas: schemas,
      onTap: (schema) {
        Get.toNamed(schema.modified == 1
            ? '/dlt/forecast/${schema.masterId}'
            : '/dlt/master/${schema.masterId}');
      },
      rateCallback: (schema) {
        return schema.rk3;
      },
      achieveCallback: (schema) {
        if (schema.r10Hit == 5 && schema.b6Hit == 2) {
          return '前期预测命中一等奖，杀红三码${schema.rk3.series > 0 ? '连续${schema.rk3.series}期命中' : '上期未命中'}';
        }
        if (schema.r10Hit == 5 && schema.b6Hit == 1) {
          return '上期预测命中二等奖，杀红三码${schema.rk3.series > 0 ? '连续${schema.rk3.series}期命中' : '上期未命中'}';
        }
        return '上期预测命中${schema.r10Hit}+${schema.b6Hit}，杀红三码${schema.rk3.series > 0 ? '连续${schema.rk3.series}期命中' : '上期未命中'}';
      },
    );
  }

  Widget _buildRankView(List<DltMasterMulRank> ranks) {
    return MultipleRbRankPanel(
      detailPrefix: '/dlt/master/',
      moreRed: () {
        Get.toNamed('/dlt/mul_rank/0');
      },
      moreBlue: () {
        Get.toNamed('/dlt/mul_rank/1');
      },
      ranks: ranks
          .map((e) => MultipleMasterRank(
                rank: e,
                hit: e.rk,
              ))
          .toList(),
    );
  }

  Widget _buildItemRankView(DltMasterController controller) {
    return DropdownFilterContainer(
      title: '大乐透分类榜',
      initialIndex: controller.initialIndex,
      entries: controller.dropEntries,
      onSelected: (index, entry) {
        controller.currentIndex = index;
      },
      child: ItemRankPanel(
        channel: controller.channel,
        masters: controller.picked,
        detailPrefix: '/dlt/master/',
        rankPrefix: '/dlt/item_rank/',
      ),
    );
  }
}
