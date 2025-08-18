import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/views/user/model/balance_log.dart';
import 'package:prize_lottery_app/views/user/repository/user_repository.dart';

class SurplusObtainController extends AbsPageQueryController {
  ///
  ///
  int page = 1, limit = 12, total = 0;

  ///
  List<BalanceLog> logs = [];

  @override
  bool loadedAll() {
    return total > 0 && logs.length >= total;
  }

  @override
  Future<void> onInitial() async {
    showLoading();
    await UserInfoRepository.balanceLogs(
      direct: 1,
      type: 2,
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      logs
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(logs);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {
    if (logs.length == total) {
      EasyLoading.showToast('没有更多数据');
      return;
    }
    page++;
    await UserInfoRepository.balanceLogs(
      direct: 1,
      type: 2,
      page: page,
      limit: limit,
    ).then((value) {
      logs.addAll(value.records);
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
    await UserInfoRepository.balanceLogs(
      direct: 1,
      type: 2,
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      logs
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(logs);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
