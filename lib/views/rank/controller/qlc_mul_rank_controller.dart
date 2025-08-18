import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/store/resource.dart';
import 'package:prize_lottery_app/views/rank/model/mul_rank_banner_info.dart';
import 'package:prize_lottery_app/views/rank/model/qlc_master_rank.dart';
import 'package:prize_lottery_app/views/rank/repository/master_rank_repository.dart';

class QlcMulRankController extends AbsPageQueryController {
  ///
  ///
  List<RankBannerInfo> banners = [
    RankBannerInfo(
      url: ResourceStore().resource(R.batchPkBanner),
      onTap: () {
        Get.toNamed(AppRoutes.qlcBattle);
      },
    ),
    RankBannerInfo(
      url: ResourceStore().resource(R.vipCensusBanner),
      onTap: () {
        Get.toNamed(AppRoutes.qlcVipCensus);
      },
    ),
    RankBannerInfo(
      url: ResourceStore().resource(R.fullCensusBanner),
      onTap: () {
        Get.toNamed(AppRoutes.qlcFullCensus);
      },
    ),
    RankBannerInfo(
      url: ResourceStore().resource(R.rateCensusBanner),
      onTap: () {
        Get.toNamed(AppRoutes.qlcRateCensus);
      },
    ),
  ];

  int total = 0, page = 1, limit = 8;
  List<QlcMasterMulRank> ranks = [];

  @override
  Future<void> onInitial() async {
    showLoading();
    page = 1;
    await MasterRankRepository.mulQlcMasterRanks(
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
    await MasterRankRepository.mulQlcMasterRanks(
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
    await MasterRankRepository.mulQlcMasterRanks(
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
}
