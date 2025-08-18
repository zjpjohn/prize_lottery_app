import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/views/skill/model/lottery_skill.dart';
import 'package:prize_lottery_app/views/skill/repository/lottery_skill_repository.dart';

class SkillListController extends AbsPageQueryController {
  ///
  int page = 1, limit = 10, total = 0;
  List<LotterySkill> skills = [];

  @override
  Future<void> onInitial() async {
    showLoading();
    await LotterySkillRepository.skillList(
      type: Get.arguments?['type'],
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

  @override
  Future<void> onLoadMore() async {
    if (skills.length == total) {
      EasyLoading.showToast('没有更多资讯');
      return;
    }
    page++;
    await LotterySkillRepository.skillList(
            type: Get.arguments?['type'], page: page, limit: limit)
        .then((value) {
      skills.addAll(value.records);
      update();
    }).catchError((error) {
      page--;
    });
  }

  @override
  Future<void> onRefresh() async {
    page = 1;
    await LotterySkillRepository.skillList(
            type: Get.arguments?['type'], page: page, limit: limit)
        .then((value) {
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
