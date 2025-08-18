import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/views/glad/model/qlc_master_glad.dart';
import 'package:prize_lottery_app/views/glad/repository/master_glad_repository.dart';
import 'package:prize_lottery_app/views/master/repository/lotto_master_repository.dart';
import 'package:prize_lottery_app/views/rank/model/qlc_master_rank.dart';

class QlcGladListController extends AbsPageQueryController {
  ///
  List<QlcMasterGlad> glads = [];

  ///
  List<QlcMasterMulRank> recommends = [];

  ///
  int total = 0, page = 1, limit = 10;

  @override
  Future<void> onInitial() async {
    ///
    showLoading();
    page = 1;

    ///
    Future<void> gladAsync = MasterGladRepository.qlcGladList(
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      glads
        ..clear()
        ..addAll(value.records);
    });

    ///
    Future<void> recAsync =
        LottoMasterRepository.qlcRandomMasters().then((value) {
      recommends
        ..clear()
        ..addAll(value);
    });

    ///
    await Future.wait([gladAsync, recAsync]).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(glads);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {
    if (glads.length == total) {
      EasyLoading.showToast('没有更多中奖');
      return;
    }

    ///
    page++;

    ///
    await MasterGladRepository.qlcGladList(
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      glads.addAll(value.records);
      Future.delayed(const Duration(milliseconds: 200), () {
        update();
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onRefresh() async {
    page = 1;

    ///
    Future<void> gladAsync = MasterGladRepository.qlcGladList(
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      glads
        ..clear()
        ..addAll(value.records);
    });

    ///
    Future<void> recAsync =
        LottoMasterRepository.qlcRandomMasters().then((value) {
      recommends
        ..clear()
        ..addAll(value);
    });

    ///
    await Future.wait([gladAsync, recAsync]).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(glads);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
