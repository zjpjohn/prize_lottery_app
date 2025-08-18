import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/rank/model/ssq_master_rank.dart';
import 'package:prize_lottery_app/views/rank/repository/master_rank_repository.dart';
import 'package:prize_lottery_app/views/skill/model/lottery_skill.dart';
import 'package:prize_lottery_app/views/skill/repository/lottery_skill_repository.dart';

class SkillDetailController extends AbsRequestController {
  late String seq;
  late LotterySkill skill;

  List<SsqMasterMulRank> ranks = [];

  @override
  void initialBefore() {
    seq = Get.parameters['seq']!;
  }

  @override
  Future<void> request() async {
    ///
    showLoading();

    ///
    Future<void> rankFuture =
        MasterRankRepository.mulSsqMasterRanks(limit: 6).then((value) => ranks
          ..clear()
          ..addAll(value.records));

    ///
    Future<void> newsFuture =
        LotterySkillRepository.skillDetail(seq).then((value) => skill = value);
    Future.wait([rankFuture, newsFuture]).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(skill);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
