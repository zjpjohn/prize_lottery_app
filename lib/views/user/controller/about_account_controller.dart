import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/env/env_profile.dart';
import 'package:prize_lottery_app/store/config.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_assistant.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

class AboutAccountController extends AbsRequestController {
  ///
  List<LotteryAssistant> assistants = [];

  @override
  Future<void> request() async {
    showLoading();
    LotteryInfoRepository.appAssistants(
      appNo: Profile.props.appNo,
      version: ConfigStore().version,
      type: 'acct',
      detail: true,
    ).then((value) {
      assistants
        ..clear()
        ..addAll(value);
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(assistants);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
