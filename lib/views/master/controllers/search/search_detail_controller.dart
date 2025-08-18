import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/master/model/master_detail.dart';
import 'package:prize_lottery_app/views/master/repository/lotto_master_repository.dart';

class SearchDetailController extends AbsRequestController {
  ///
  ///
  late MasterDetail master;

  ///是否显示banner广告
  bool _showBanner = true;

  bool get showBanner => _showBanner;

  set showBanner(bool value) {
    if (_showBanner == value) {
      return;
    }
    _showBanner = value;
    update();
  }

  void followMaster() {
    if (master.focused == 1) {
      EasyLoading.showToast('已关注专家');
      return;
    }
    EasyLoading.show(status: '关注中');
    LottoMasterRepository.focusMaster(master.masterId).then((value) {
      master.focused = 1;
      update();
    }).catchError((error) {
      EasyLoading.showError('关注失败');
    }).whenComplete(() => EasyLoading.dismiss());
  }

  @override
  Future<void> request() async {
    showLoading();
    LottoMasterRepository.masterDetail(
      masterId: Get.parameters['masterId']!,
      search: 1,
    ).then((value) {
      master = value;
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(master);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
