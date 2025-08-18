import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/authed_refresh_widget.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/views/master/controllers/center/fc3d_master_controller.dart';
import 'package:prize_lottery_app/views/master/model/master_schema.dart';
import 'package:prize_lottery_app/views/master/widgets/item_rank_panel.dart';
import 'package:prize_lottery_app/views/master/widgets/master_schema_panel.dart';
import 'package:prize_lottery_app/views/master/widgets/multiple_rank_panel.dart';
import 'package:prize_lottery_app/views/master/widgets/recent_browse_view.dart';
import 'package:prize_lottery_app/views/master/widgets/renew_master_swiper.dart';
import 'package:prize_lottery_app/views/rank/model/fc3d_master_rank.dart';
import 'package:prize_lottery_app/widgets/dropdown_filter_widget.dart';

class Fc3dMasterView extends StatefulWidget {
  ///
  ///
  const Fc3dMasterView({super.key});

  @override
  Fc3dMasterViewState createState() => Fc3dMasterViewState();
}

class Fc3dMasterViewState extends State<Fc3dMasterView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: const Color(0xFFF8F8FB),
      child: AuthedRefreshWidget<Fc3dMasterController>(
        global: true,
        enableLoad: false,
        init: Fc3dMasterController(),
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
  Widget _buildRecentBrowseView(Fc3dMasterController controller) {
    return RecentBrowseView(
      name: '福彩3D',
      type: 'fc3d',
      record: controller.browseRecord,
    );
  }

  ///
  ///
  ///
  Widget _buildRenewMasterView(Fc3dMasterController controller) {
    if (controller.renewMasters.isEmpty || controller.renewMasters.length < 4) {
      return const SizedBox.shrink();
    }
    return RenewMasterSwiper(masters: controller.renewMasters);
  }

  ///
  ///
  ///
  Widget _buildSchemaListView(List<Fc3dSchema> schemas) {
    return MasterSchemaPanel<Fc3dSchema>(
      schemas: schemas,
      onTap: (schema) {
        Get.toNamed(schema.modified == 1
            ? '/fc3d/forecast/${schema.masterId}'
            : '/fc3d/master/${schema.masterId}');
      },
      rateCallback: (schema) {
        return schema.k1;
      },
      achieveCallback: (schema) {
        if (schema.d3Hit == 3) {
          return '前期预测3胆全中，杀2码${schema.k2.series > 0 ? '连续${schema.k2.series}期命中' : '上期未命中'}';
        }
        if (schema.c5Hit == 3) {
          return '上期预测5码命中，杀2码${schema.k2.series > 0 ? '连续${schema.k2.series}期命中' : '上期未命中'}';
        }
        return '上期预测3胆中${schema.d3Hit}，杀1码${schema.k1.series > 0 ? '连续${schema.k1.series}期命中' : '上期未命中'}';
      },
    );
  }

  Widget _buildRankView(List<Fc3dMasterMulRank> ranks) {
    return MultipleRankPanel(
      detailPrefix: '/fc3d/master/',
      moreAction: () {
        Get.toNamed(AppRoutes.fc3dMulRank);
      },
      ranks: ranks
          .map((e) => MultipleMasterRank(
                rank: e,
                hit: e.com7,
              ))
          .toList(),
    );
  }

  Widget _buildItemRankView(Fc3dMasterController controller) {
    return DropdownFilterContainer(
      title: '福彩3D分类榜',
      initialIndex: controller.initialIndex,
      entries: controller.dropEntries,
      onSelected: (index, entry) {
        controller.currentIndex = index;
      },
      child: ItemRankPanel(
        channel: controller.channel,
        masters: controller.picked,
        detailPrefix: '/fc3d/master/',
        rankPrefix: '/fc3d/item_rank/',
      ),
    );
  }
}
