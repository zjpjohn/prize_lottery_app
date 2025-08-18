import 'package:prize_lottery_app/base/controller/request_controller.dart';

class Pl3RealTimeController extends AbsRequestController {
  @override
  Future<void> request() async {
    showLoading();
    Future.delayed(const Duration(milliseconds: 350), () {
      showSuccess(null);
    });
  }
}
