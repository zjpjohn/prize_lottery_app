import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/store/balance.dart';

class UserAccountController extends AbsRequestController {
  @override
  void initialBefore() {
    BalanceInstance().refreshBalance();
  }

  @override
  Future<void> request() async {
    showLoading();
    Future.delayed(const Duration(milliseconds: 250), () {
      showSuccess(true);
    });
  }
}
