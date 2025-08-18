import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/env/env_profile.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_assistant.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

class AssistantDetailController extends AbsRequestController {
  ///
  late LotteryAssistant assistant;

  @override
  Future<void> request() async {
    showLoading();
    LotteryInfoRepository.assistant(
      id: int.parse(Get.parameters['id']!),
      appNo: Profile.props.appNo,
    ).then((value) {
      assistant = value;
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(assistant);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
