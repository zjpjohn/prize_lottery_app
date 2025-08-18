import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/views/glad/model/dlt_master_glad.dart';
import 'package:prize_lottery_app/views/glad/repository/master_glad_repository.dart';
import 'package:prize_lottery_app/views/rank/model/dlt_master_rank.dart';
import 'package:prize_lottery_app/views/rank/repository/master_rank_repository.dart';
import 'package:prize_lottery_app/views/skill/model/lottery_skill.dart';
import 'package:prize_lottery_app/views/skill/repository/lottery_skill_repository.dart';

class SkillHomeController extends AbsPageQueryController {
  ///
  List<DltMasterMulRank> ranks = [];
  List<DltMasterGlad> glads = [];

  ///
  int page = 1, limit = 8, total = 0;
  List<LotterySkill> skills = [];

  @override
  Future<void> onInitial() async {
    showLoading();

    ///
    Future<void> newsFuture =
        LotterySkillRepository.skillList(page: page, limit: limit)
            .then((value) {
      total = value.total;
      skills
        ..clear()
        ..addAll(value.records);
    });

    ///
    Future<void> rankFuture =
        MasterRankRepository.mulDltMasterRanks(limit: 3).then((value) => ranks
          ..clear()
          ..addAll(value.records));

    ///
    Future<void> gladFuture =
        MasterGladRepository.dltGladList(limit: 6).then((value) => glads
          ..clear()
          ..addAll(value.records));

    ///
    await Future.wait([newsFuture, rankFuture, gladFuture]).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(skills);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {
    if (skills.length == total) {
      EasyLoading.showToast('没有更多资讯');
      return;
    }
    page++;
    await LotterySkillRepository.skillList(
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      skills.addAll(value.records);
      Future.delayed(const Duration(milliseconds: 200), () {
        update();
      });
    }).catchError((error) {
      page--;
      showError(error);
    });
  }

  @override
  Future<void> onRefresh() async {
    page = 1;
    await LotterySkillRepository.skillList(
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      skills
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(skills);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
