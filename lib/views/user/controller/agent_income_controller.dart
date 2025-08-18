import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/views/user/model/agent_account.dart';
import 'package:prize_lottery_app/views/user/repository/agent_repository.dart';

class AgentIncomeController extends AbsPageQueryController {
  ///
  ///
  int page = 1, limit = 15, total = 0;
  List<AgentIncome> histories = [];

  @override
  bool loadedAll() {
    return total > 0 && histories.length == total;
  }

  @override
  Future<void> onInitial() async {
    showLoading();
    page = 1;
    await AgentRepository.incomeList({'page': page, 'limit': limit})
        .then((value) {
      total = value.total;
      histories
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(histories);
      }).catchError((error) {
        showError(error);
      });
    });
  }

  @override
  Future<void> onLoadMore() async {
    page++;
    await AgentRepository.incomeList({'page': page, 'limit': limit})
        .then((value) {
      total = value.total;
      histories.addAll(value.records);
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(histories);
      }).catchError((error) {
        page--;
        showError(error);
      });
    });
  }

  @override
  Future<void> onRefresh() async {
    page = 1;
    await AgentRepository.incomeList({'page': page, 'limit': limit})
        .then((value) {
      total = value.total;
      histories
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(histories);
      }).catchError((error) {
        showError(error);
      });
    });
  }
}
