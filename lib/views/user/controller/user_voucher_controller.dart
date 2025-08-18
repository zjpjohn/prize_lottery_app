import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/base/model/request_state.dart';
import 'package:prize_lottery_app/views/user/model/user_voucher.dart';
import 'package:prize_lottery_app/views/user/repository/voucher_repository.dart';

class UserVoucherController extends AbsPageQueryController {
  ///
  ///
  late UserVoucher voucherAcct;

  ///
  ///
  int total = 0, page = 1, limit = 10;
  List<UserVoucherLog> records = [];

  ///是否已使用
  int? _used, _expired, _all = 1;

  set all(int? value) {
    _all = value;
    _used = null;
    _expired = null;
    update();
    refreshController.callRefresh();
  }

  int? get all => _all;

  set used(int? value) {
    _used = value;
    _expired = null;
    _all = null;
    update();
    refreshController.callRefresh();
  }

  int? get used => _used;

  set expired(int? value) {
    _expired = value;
    _used = null;
    _all = null;
    update();
    refreshController.callRefresh();
  }

  int? get expired => _expired;

  List<Future<void>> asyncFutures() {
    return [
      VoucherRepository.userVoucher().then((value) => voucherAcct = value),
      VoucherRepository.voucherRecords(
        page: page,
        limit: limit,
        used: _used,
        expired: _expired,
      ).then((value) {
        total = value.total;
        records
          ..clear()
          ..addAll(value.records);
      }),
    ];
  }

  @override
  Future<void> onInitial() async {
    showLoading();
    page = 1;
    await Future.wait(asyncFutures()).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        state = RequestState.success;
        update();
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {
    if (records.length == total) {
      EasyLoading.showToast('没有更多代金券');
      return;
    }
    page++;
    await VoucherRepository.voucherRecords(
      page: page,
      limit: limit,
      used: _used,
      expired: _expired,
    ).then((value) {
      total = value.total;
      records.addAll(value.records);
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
    await Future.wait(asyncFutures()).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        state = RequestState.success;
        update();
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
