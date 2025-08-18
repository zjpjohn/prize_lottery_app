import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/resources/styles.dart';
import 'package:prize_lottery_app/views/home/widgets/achieve_tag_view.dart';
import 'package:prize_lottery_app/views/rank/controller/fc3d_mul_rank_controller.dart';
import 'package:prize_lottery_app/views/rank/model/fc3d_master_rank.dart';
import 'package:prize_lottery_app/views/rank/widgets/mul_rank_appbar.dart';
import 'package:prize_lottery_app/views/rank/widgets/mul_rank_entry_widget.dart';
import 'package:prize_lottery_app/widgets/indicator_banner.dart';

class Fc3dMasterRankView extends StatefulWidget {
  ///
  ///
  const Fc3dMasterRankView({super.key});

  @override
  Fc3dMasterRankViewState createState() => Fc3dMasterRankViewState();
}

class Fc3dMasterRankViewState extends State<Fc3dMasterRankView> {
  ///
  ///
  final ScrollController _scrollController = ScrollController();

  ///
  final StreamController<double> _streamController =
      StreamController<double>.broadcast();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: UiStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            RefreshWidget<Fc3dMulRankController>(
              header: MaterialHeader(),
              scrollController: _scrollController,
              topConfig: const ScrollTopConfig(align: TopAlign.right),
              builder: (controller) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: _buildSwiper(controller),
                    ),
                    _buildRankHeader(),
                    _buildRankList(controller.ranks, controller.limit)
                  ],
                );
              },
            ),
            StreamBuilder<double>(
              stream: _streamController.stream,
              initialData: 0.0,
              builder: (context, snapshot) {
                if (snapshot.data == null || snapshot.data! <= 0) {
                  return const SizedBox.shrink();
                }
                return MulRankAppbar(
                  title: '排行榜',
                  throttle: 80.h,
                  shrinkOffset: snapshot.data!,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwiper(Fc3dMulRankController controller) {
    return LiquidBanner(
      height: 180.w,
      inner: 4.5.w,
      outer: 8.w,
      children: controller.banners
          .map((e) => BannerImage(
                url: e.url!,
                width: Get.width,
                height: 180.w,
                onTap: () {
                  e.onTap!();
                },
              ))
          .toList(),
    );
  }

  Widget _buildRankHeader() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 10.w,
            ),
            Text(
              '福彩3D排行榜',
              style: TextStyle(
                color: const Color(0xFF333333),
                fontSize: 16.sp,
              ),
            ),
            Text(
              '严格甄选，只为最好',
              style: TextStyle(
                color: const Color(0xFF7F7F7F),
                fontSize: 12.sp,
              ),
            ),
            SizedBox(
              height: 10.w,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRankList(List<Fc3dMasterMulRank> ranks, int pageSize) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          Fc3dMasterMulRank rank = ranks[index];
          return MulRankEntryWidget(
            border: index < ranks.length,
            showAds: index > 0 && index % 10 == 3,
            data: MulMasterRank(
              rank: rank,
              achieves: [
                AchieveInfo(name: '三胆', count: rank.dan3.count),
                AchieveInfo(name: '七码', count: rank.com7.count),
                AchieveInfo(
                    name: '杀一码', count: rank.kill1.count, color: TagColor.blue),
              ],
            ),
            onTap: () {
              Get.toNamed('/fc3d/master/${rank.master.masterId}');
            },
          );
        },
        childCount: ranks.length,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _streamController.sink.add(_scrollController.offset);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
