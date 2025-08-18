import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/env/env_profile.dart';
import 'package:prize_lottery_app/store/config.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_assistant.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

class LotteryAssistantController extends AbsRequestController {
  ///
  List<LotteryAssistant> assistants = [];

  ///
  late String _type = 'fc3d';
  List<LotteryAssistant> currents = [];

  String get type => _type;

  set type(String type) {
    if (_type == type) {
      return;
    }
    _type = type;
    currents = assistants.where((e) => e.type == type).toList();
    update();
  }

  List<LotteryAssistant> comAssistant() {
    return assistants
        .where((e) => e.type == 'func' || e.type == 'acct')
        .toList();
  }

  @override
  Future<void> request() async {
    showLoading();
    LotteryInfoRepository.appAssistants(
      appNo: Profile.props.appNo,
      version: ConfigStore().version,
    ).then((value) {
      assistants
        ..clear()
        ..addAll(value);
      Future.delayed(const Duration(milliseconds: 200), () {
        currents = assistants.where((e) => e.type == type).toList();
        showSuccess(assistants);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
