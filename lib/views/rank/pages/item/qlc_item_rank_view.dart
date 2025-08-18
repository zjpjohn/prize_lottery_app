import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/resources/styles.dart';
import 'package:prize_lottery_app/store/resource.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/glad/model/qlc_master_glad.dart';
import 'package:prize_lottery_app/views/rank/controller/qlc_item_rank_controller.dart';
import 'package:prize_lottery_app/views/rank/model/qlc_master_rank.dart';
import 'package:prize_lottery_app/views/rank/widgets/channel_tab_layout.dart';
import 'package:prize_lottery_app/views/rank/widgets/item_rank_entry_widget.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';
import 'package:prize_lottery_app/widgets/tab_filter_view.dart';
import 'package:prize_lottery_app/widgets/vertical_marquee.dart';

class QlcItemRankView extends StatefulWidget {
  ///
  const QlcItemRankView({super.key});

  @override
  QlcItemRankViewState createState() => QlcItemRankViewState();
}

class QlcItemRankViewState extends State<QlcItemRankView>
    with TickerProviderStateMixin {
  ///
  final StreamController<bool> _streamController =
      StreamController<bool>.broadcast();

  ///
  final ScrollController _scrollController = ScrollController();

  ///
  late TabController _tabController;

  ///
  final List<TabEntry> tabEntries = qlcChannels.entries
      .map((e) => TabEntry(key: e.key, value: e.value))
      .toList();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: UiStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            RefreshWidget<QlcItemRankController>(
              header: MaterialHeader(),
              scrollController: _scrollController,
              topConfig: const ScrollTopConfig(align: TopAlign.right),
              builder: (controller) {
                return _buildRankContainer(controller);
              },
            ),
            StreamBuilder<bool>(
              stream: _streamController.stream,
              initialData: false,
              builder: (context, snapshot) {
                if (!snapshot.data!) {
                  return const SizedBox.shrink();
                }
                return Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                  ),
                  child: GetBuilder<QlcItemRankController>(
                    builder: (controller) {
                      return ChannelTabLayout(
                        tabs: tabEntries,
                        expanded: controller.expanded,
                        tabController: _tabController,
                        margin: EdgeInsets.zero,
                        expandRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(6.w),
                          bottomRight: Radius.circular(6.w),
                        ),
                        expandShadow: const [
                          BoxShadow(
                            color: Color(0x99ECECEC),
                            blurRadius: 8,
                            offset: Offset(0, 5),
                          ),
                        ],
                        packUpShadow: const [
                          BoxShadow(
                            color: Color(0x99ECECEC),
                            blurRadius: 8,
                            offset: Offset(0, 5),
                          ),
                        ],
                        tabTap: (index) {
                          _tabController.index = index;
                        },
                        panelTap: (expanded) {
                          controller.expanded = expanded;
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRankContainer(QlcItemRankController controller) {
    return ListView.builder(
      itemCount: controller.ranks.length - 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _topRankMasterView(
            controller,
            controller.glads,
            controller.ranks.sublist(0, 3),
          );
        }
        int realIndex = index + 2;
        QlcMasterRank rank = controller.ranks[realIndex];
        return ItemRankEntryWidget(
          data: rank,
          radius: false,
          border: realIndex < controller.ranks.length,
          showAds: realIndex % 10 == 3,
          onTap: () {
            String channel = tabEntries[_tabController.index].key;
            Get.toNamed(
              '/qlc/master/${rank.master.masterId}',
              parameters: {'channel': channel},
            );
          },
        );
      },
    );
  }

  Widget _topRankMasterView(
    QlcItemRankController controller,
    List<QlcMasterGlad> glads,
    List<QlcMasterRank> ranks,
  ) {
    return Stack(
      children: [
        _headerBackground(glads),
        Column(
          children: [
            SizedBox(height: 180.w),
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 6.w),
                  margin: EdgeInsets.only(top: 56.w),
                  child: Column(
                    children: _topRankMasters(ranks),
                  ),
                ),
                ChannelTabLayout(
                  tabs: tabEntries,
                  expanded: controller.expanded,
                  tabController: _tabController,
                  packUpRadius: BorderRadius.circular(6.w),
                  expandRadius: BorderRadius.circular(6.w),
                  expandShadow: const [
                    BoxShadow(
                      color: Color(0x99ECECEC),
                      blurRadius: 8,
                      offset: Offset(0, 5),
                    ),
                  ],
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  tabTap: (index) {
                    _tabController.index = index;
                  },
                  panelTap: (expanded) {
                    controller.expanded = expanded;
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _topRankMasters(List<QlcMasterRank> ranks) {
    List<Widget> views = [];
    for (int i = 0; i < ranks.length; i++) {
      views.add(ItemRankEntryWidget(
        data: ranks[i],
        radius: i == 0,
        border: true,
        showAds: false,
        onTap: () {
          String channel = tabEntries[_tabController.index].key;
          Get.toNamed(
            '/qlc/master/${ranks[i].master.masterId}',
            parameters: {'channel': channel},
          );
        },
      ));
    }
    return views;
  }

  Widget _headerBackground(List<QlcMasterGlad> glads) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CachedAvatar(
          width: MediaQuery.of(context).size.width,
          height: 270.w,
          color: const Color(0xFFF2F2F2),
          url: ResourceStore().resource(R.qlcItemRankBg),
        ),
        VerticalMarquee(
          height: 28.w,
          width: MediaQuery.of(context).size.width / 2,
          color: Colors.white54,
          radius: BorderRadius.circular(20.w),
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          items: glads.map((e) {
            return GestureDetector(
              onTap: () {
                Get.toNamed('/qlc/master/${e.master.masterId}');
              },
              behavior: HitTestBehavior.opaque,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAEAEA),
                      borderRadius: BorderRadius.circular(20.w),
                    ),
                    child: CachedAvatar(
                      width: 20.w,
                      height: 20.w,
                      radius: 20.w,
                      url: e.master.avatar,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 6.w),
                    child: RichText(
                      text: TextSpan(
                        text: Tools.limitName(e.master.name, 5),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black87,
                        ),
                        children: const [
                          TextSpan(
                            text: '推荐命中',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: tabEntries
          .lastIndexWhere((element) => element.key == Get.parameters['type']!),
      length: tabEntries.length,
      vsync: this,
    );
    _tabController.addListener(() {
      if (_tabController.index == _tabController.animation!.value) {
        QlcItemRankController controller = Get.find<QlcItemRankController>();
        controller.type = tabEntries[_tabController.index].key;
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 100),
          curve: Curves.linear,
        );
      }
    });
    _scrollController.addListener(() {
      _streamController.sink.add(_scrollController.position.pixels > 140);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _streamController.close();
    _tabController.dispose();
    super.dispose();
  }
}
