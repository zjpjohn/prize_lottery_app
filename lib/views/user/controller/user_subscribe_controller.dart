import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/views/battle/controller/dlt_battle_controller.dart';
import 'package:prize_lottery_app/views/battle/controller/fc3d_battle_controller.dart';
import 'package:prize_lottery_app/views/battle/controller/pl3_battle_controller.dart';
import 'package:prize_lottery_app/views/battle/controller/qlc_battle_controller.dart';
import 'package:prize_lottery_app/views/battle/controller/ssq_battle_controller.dart';
import 'package:prize_lottery_app/views/master/model/focus_master.dart';
import 'package:prize_lottery_app/views/master/repository/lotto_master_repository.dart';

class UserSubscribeController extends AbsPageQueryController {
  ///
  int page = 1, limit = 12, total = 0;
  List<SubscribeMaster> focusList = [];

  void addToBattle(int index) {
    if (index < 0 || focusList.isEmpty || focusList.length <= index) {
      EasyLoading.showToast('加入对战错误');
      return;
    }
    SubscribeMaster master = focusList[index];
    String type = master.channel.value;
    switch (type) {
      case 'fc3d':
        Fc3dBattleController().addBattle(master.masterId, success: (masterId) {
          Get.toNamed(AppRoutes.fc3dBattle);
        });
        break;
      case 'ssq':
        SsqBattleController().addBattle(master.masterId, success: (masterId) {
          Get.toNamed(AppRoutes.ssqBattle);
        });
        break;
      case 'pl3':
        Pl3BattleController().addBattle(master.masterId, success: (masterId) {
          Get.toNamed(AppRoutes.pl3Battle);
        });
        break;
      case 'dlt':
        DltBattleController().addBattle(master.masterId, success: (masterId) {
          Get.toNamed(AppRoutes.dltBattle);
        });
        break;
      case 'qlc':
        QlcBattleController().addBattle(master.masterId, success: (masterId) {
          Get.toNamed(AppRoutes.qlcBattle);
        });
        break;
    }
  }

  void specialMaster(int index) async {
    if (index < 0 || focusList.isEmpty || focusList.length <= index) {
      EasyLoading.showToast('重点关注错误');
      return;
    }
    SubscribeMaster master = focusList[index];
    String action = master.special == 0 ? '重点关注' : '取消重点关注';
    EasyLoading.show(status: '正在$action');
    try {
      await LottoMasterRepository.specialOrCancelMaster(
        masterId: master.masterId,
        type: master.channel.value,
      );
      master.special = master.special == 0 ? 1 : 0;
      update();
      EasyLoading.showToast('$action成功');
    } catch (error) {
      EasyLoading.showToast('$action失败');
    }
  }

  ///
  /// 取消订阅专家
  void unSubscribe({required String masterId, required String type}) async {
    EasyLoading.show(status: '正在取消');
    try {
      await LottoMasterRepository.unFollowMaster(
        masterId: masterId,
        type: type,
      );
      int index = focusList
          .indexWhere((e) => e.masterId == masterId && e.channel.value == type);
      await refreshFocusList(index);
      EasyLoading.showToast('取消成功');
    } catch (error) {
      EasyLoading.showError('取消失败');
    }
  }

  Future<void> refreshFocusList(int index) async {
    page = index ~/ limit + 1;
    focusList.removeRange((page - 1) * limit, focusList.length);
    await LottoMasterRepository.subscribeMasters(
      page: page,
      limit: limit,
    ).then((value) {
      focusList.addAll(value.records);
      update();
    });
  }

  @override
  Future<void> onInitial() async {
    showLoading();
    await LottoMasterRepository.subscribeMasters(
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      focusList
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(focusList);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {
    if (focusList.length == total) {
      EasyLoading.showToast('没有更多专家');
      return;
    }
    page++;
    await LottoMasterRepository.subscribeMasters(
      page: page,
      limit: limit,
    ).then((value) {
      focusList.addAll(value.records);
      update();
    }).catchError((error) {
      page--;
    });
  }

  @override
  Future<void> onRefresh() async {
    page = 1;
    await LottoMasterRepository.subscribeMasters(
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      focusList
        ..clear()
        ..addAll(value.records);
      showSuccess(focusList);
    }).catchError((error) {
      showError(error);
    });
  }
}
