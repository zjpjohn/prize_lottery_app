import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/views/user/model/user_withdraw.dart';
import 'package:prize_lottery_app/views/user/repository/user_repository.dart';

class WithdrawRecordController extends AbsPageQueryController {
  ///
  int page = 1, limit = 12, total = 0;
  List<WithdrawRecord> records = [];

  @override
  bool loadedAll() {
    return total > 0 && records.length == total;
  }

  @override
  Future<void> onInitial() async {
    showLoading();
    await UserInfoRepository.withdrawRecords(
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      records
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(records);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {
    if (records.length == total) {
      EasyLoading.showToast('没有更多数据');
      return;
    }
    page++;
    await UserInfoRepository.withdrawRecords(
      page: page,
      limit: limit,
    ).then((value) {
      records.addAll(value.records);
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
    await UserInfoRepository.withdrawRecords(
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      records
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(records);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
