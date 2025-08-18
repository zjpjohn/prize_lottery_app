import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/views/master/model/focus_master.dart';
import 'package:prize_lottery_app/views/master/model/recommend_master.dart';
import 'package:prize_lottery_app/views/master/repository/lotto_master_repository.dart';

class FocusMasterController extends AbsPageQueryController {
  ///
  int page = 1, limit = 10, total = 0;

  ///
  List<SubscribeMaster> focusList = [];
  List<RecommendMaster> recommends = [];

  void batchFocusMasters() {
    if (recommends.isEmpty) {
      EasyLoading.showToast('没有专家');
      return;
    }
    List<Map<String, String>> followMasters = recommends
        .map((e) => {'masterId': e.masterId, 'type': e.type.value.toString()})
        .toList();
    EasyLoading.show(status: '操作中');
    LottoMasterRepository.batchFollow(followMasters).then((value) {
      Future.delayed(const Duration(milliseconds: 250), () {
        EasyLoading.showToast('关注成功');
      });
      onRefresh();
    }).catchError((error) {
      Future.delayed(const Duration(milliseconds: 250), () {
        EasyLoading.showToast('关注失败');
      });
    });
  }

  @override
  Future<void> onInitial() async {
    showLoading();
    LottoMasterRepository.subscribeMasters(
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      if (total == 0) {
        LottoMasterRepository.recommendMasters().then((value) {
          recommends
            ..clear()
            ..addAll(value);
          showSuccess(recommends);
        }).catchError((error) {
          showError(error);
        });
        return;
      }
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
      Future.delayed(const Duration(milliseconds: 250), () {
        update();
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onRefresh() async {
    page = 1;
    LottoMasterRepository.subscribeMasters(
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      if (total == 0) {
        LottoMasterRepository.recommendMasters().then((value) {
          recommends
            ..clear()
            ..addAll(value);
          showSuccess(recommends);
        }).catchError((error) {
          showError(error);
        });
        return;
      }
      focusList
        ..clear()
        ..addAll(value.records);
      showSuccess(focusList);
    }).catchError((error) {
      showError(error);
    });
  }
}
