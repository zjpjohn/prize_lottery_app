import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/base/model/forecast_expend.dart';
import 'package:prize_lottery_app/base/model/request_state.dart';
import 'package:prize_lottery_app/utils/request.dart';

///
/// 后端返回收费code标识码
const int feeCode = 10403;

abstract class AbsFeeRequestController extends AbsRequestController {
  ///
  /// 是否要付费观看
  bool feeBrowse = false;

  ///
  /// 消耗账户余额
  ForecastExpend expend = ForecastExpend(
    expend: 60,
    bounty: 20,
  );

  AbsFeeRequestController();

  ///
  /// 付费判断
  bool showFee(ResponseError error) {
    feeBrowse = error.code == feeCode;
    if (feeBrowse) {
      expend = ForecastExpend.fromJson(error.data!);
      state = RequestState.success;
      update();
    }
    return feeBrowse;
  }

}
