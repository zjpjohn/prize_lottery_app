import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/authed_refresh_widget.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/views/master/controllers/center/pl3_master_controller.dart';
import 'package:prize_lottery_app/views/master/model/master_schema.dart';
import 'package:prize_lottery_app/views/master/widgets/item_rank_panel.dart';
import 'package:prize_lottery_app/views/master/widgets/master_schema_panel.dart';
import 'package:prize_lottery_app/views/master/widgets/multiple_rank_panel.dart';
import 'package:prize_lottery_app/views/master/widgets/recent_browse_view.dart';
import 'package:prize_lottery_app/views/master/widgets/renew_master_swiper.dart';
import 'package:prize_lottery_app/views/rank/model/pl3_master_rank.dart';
import 'package:prize_lottery_app/widgets/dropdown_filter_widget.dart';

class Pl3MasterView extends StatefulWidget {
  ///
  const Pl3MasterView({super.key});

  @override
  Pl3MasterViewState createState() => Pl3MasterViewState();
}

class Pl3MasterViewState extends State<Pl3MasterView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: const Color(0xFFF8F8FB),
      child: AuthedRefreshWidget<Pl3MasterController>(
        global: true,
        enableLoad: false,
        init: Pl3MasterController(),
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
  Widget _buildRecentBrowseView(Pl3MasterController controller) {
    return RecentBrowseView(
      name: '排列三',
      type: 'pl3',
      record: controller.browseRecord,
    );
  }

  Widget _buildRenewMasterView(Pl3MasterController controller) {
    if (controller.renewMasters.isEmpty || controller.renewMasters.length < 4) {
      return const SizedBox.shrink();
    }
    return RenewMasterSwiper(masters: controller.renewMasters);
  }

  Widget _buildSchemaListView(List<Pl3Schema> schemas) {
    return MasterSchemaPanel<Pl3Schema>(
      schemas: schemas,
      onTap: (schema) {
        Get.toNamed(schema.modified == 1
            ? '/pl3/forecast/${schema.masterId}'
            : '/pl3/master/${schema.masterId}');
      },
      rateCallback: (schema) {
        return schema.k1;
      },
      achieveCallback: (schema) {
        if (schema.d3Hit == 3) {
          return '前期预测3胆全中，杀2码'
              '${schema.k2.series > 0 ? '连续${schema.k2.series}期命中' : '上期未命中'}';
        }
        if (schema.c5Hit == 3) {
          return '上期预测5码命中，杀2码'
              '${schema.k2.series > 0 ? '连续${schema.k2.series}期命中' : '上期未命中'}';
        }
        return '上期预测3胆中${schema.d3Hit}，杀1码'
            '${schema.k1.series > 0 ? '连续${schema.k1.series}期命中' : '上期未命中'}';
      },
    );
  }

  Widget _buildRankView(List<Pl3MasterMulRank> ranks) {
    return MultipleRankPanel(
      detailPrefix: '/pl3/master/',
      moreAction: () {
        Get.toNamed(AppRoutes.pl3MulRank);
      },
      ranks: ranks
          .map((e) => MultipleMasterRank(
                rank: e,
                hit: e.com7,
              ))
          .toList(),
    );
  }

  Widget _buildItemRankView(Pl3MasterController controller) {
    return DropdownFilterContainer(
      title: '排列三分类榜',
      initialIndex: controller.initialIndex,
      entries: controller.dropEntries,
      onSelected: (index, entry) {
        controller.currentIndex = index;
      },
      child: ItemRankPanel(
        channel: controller.channel,
        masters: controller.picked,
        detailPrefix: '/pl3/master/',
        rankPrefix: '/pl3/item_rank/',
      ),
    );
  }
}
