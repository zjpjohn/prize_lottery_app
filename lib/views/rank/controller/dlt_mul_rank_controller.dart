import 'package:get/get.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/store/resource.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/views/rank/model/dlt_master_rank.dart';
import 'package:prize_lottery_app/views/rank/model/mul_rank_banner_info.dart';
import 'package:prize_lottery_app/views/rank/repository/master_rank_repository.dart';

class DltMulRankController extends AbsPageQueryController {
  ///
  ///
  List<RankBannerInfo> banners = [
    RankBannerInfo(
      url: ResourceStore().resource(R.batchPkBanner),
      onTap: () {
        Get.toNamed(AppRoutes.dltBattle);
      },
    ),
    RankBannerInfo(
      url: ResourceStore().resource(R.vipCensusBanner),
      onTap: () {
        Get.toNamed(AppRoutes.dltVipCensus);
      },
    ),
    RankBannerInfo(
      url: ResourceStore().resource(R.fullCensusBanner),
      onTap: () {
        Get.toNamed(AppRoutes.dltFullCensus);
      },
    ),
    RankBannerInfo(
      url: ResourceStore().resource(R.rateCensusBanner),
      onTap: () {
        Get.toNamed(AppRoutes.dltRateCensus);
      },
    ),
  ];

  int total = 0, page = 1, limit = 8;
  List<DltMasterMulRank> ranks = [];
  late int type;

  @override
  Future<void> onInitial() async {
    showLoading();
    await MasterRankRepository.mulDltMasterRanks(
      type: type,
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      ranks
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(ranks);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {
    if (ranks.length == total) {
      EasyLoading.showToast('没有更多数据');
      return;
    }
    page++;
    await MasterRankRepository.mulDltMasterRanks(
      type: type,
      page: page,
      limit: limit,
    ).then((value) {
      ranks.addAll(value.records);
      update();
    }).catchError((error) {
      page--;
    });
  }

  @override
  Future<void> onRefresh() async {
    page = 1;
    await MasterRankRepository.mulDltMasterRanks(
      type: type,
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      ranks
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(ranks);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  void initialBefore() {
    type = int.parse(Get.parameters['type']!);
  }
}
