import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/views/user/model/user_member.dart';
import 'package:prize_lottery_app/views/user/repository/member_repository.dart';

class MemberRecordController extends AbsPageQueryController {
  ///
  /// 分页参数
  int page = 1, limit = 10, total = 0;

  ///购买会员记录
  List<UserMemberLog> list = [];

  @override
  bool loadedAll() {
    return total > 0 && list.length >= total;
  }

  @override
  Future<void> onInitial() async {
    showLoading();
    await MemberRepository.memberLogs(page: page, limit: limit).then((value) {
      total = value.total;
      list
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(list);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {
    if (list.length >= total) {
      EasyLoading.showToast('没有更多记录');
      return;
    }
    page++;
    await MemberRepository.memberLogs(page: page, limit: limit).then((value) {
      list.addAll(value.records);
      update();
    }).catchError((error) {
      page--;
    });
  }

  @override
  Future<void> onRefresh() async {
    page = 1;
    await MemberRepository.memberLogs(page: page, limit: limit).then((value) {
      total = value.total;
      list
        ..clear()
        ..addAll(value.records);
      showSuccess(list);
    }).catchError((error) {
      showError(error);
    });
  }
}
