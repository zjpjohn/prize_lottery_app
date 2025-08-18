import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_code.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

class LotteryCodeController extends AbsRequestController {
  ///
  ///彩种类型
  final String lotto;

  ///万能码类型
  final int type;

  ///万能码类型
  List<LotteryCode> codes = [];

  LotteryCodeController({required this.lotto, required this.type});

  @override
  Future<void> request() async {
    showLoading();
    LotteryInfoRepository.codeList(lotto: lotto, type: type).then((value) {
      codes
        ..clear()
        ..addAll(value);
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(codes);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
