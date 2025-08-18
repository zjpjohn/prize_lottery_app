import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:screenshot/screenshot.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/base/model/fee_data_result.dart';
import 'package:prize_lottery_app/utils/screen_protect.dart';
import 'package:prize_lottery_app/views/pivot/model/pivot_info.dart';
import 'package:prize_lottery_app/views/pivot/repository/pivot_repository.dart';

class TodayPivotController extends AbsRequestController {
  ///
  /// 组件截图控制器
  final ScreenshotController screenshotController = ScreenshotController();

  /// 今日要点类型
  late String type;

  /// 期号集合
  List<String> periods = [];

  ///当前期号
  String? _period;

  ///当前期号位置下标
  int current = 0;

  /// 今日重点
  late FeeDataResult<TodayPivot> pivot;

  /// 今日要点集合
  Map<String, FeeDataResult<TodayPivot>> results = {};

  TodayPivotController(this.type);

  String get lotto {
    return type == 'fsd' ? '福彩3D' : '排列三';
  }

  String get title {
    return '$lotto第${pivot.period}期重点推荐';
  }

  String masterRoute(String masterId) {
    if (type == 'fsd') {
      return '/fc3d/master/$masterId';
    }
    return '/pl3/master/$masterId';
  }

  List<Future<void>> asyncTasks() {
    return [
      PivotRepository.pivotPeriods(type).then((value) {
        periods = value;
        if (periods.isNotEmpty) {
          _period = periods[0];
        }
      }),
      PivotRepository.todayPivot(type: type, period: _period).then((value) {
        pivot = value;
        if (!pivot.feeRequired) {
          results[pivot.period] = value;
        }
        if (pivot.period.isNotEmpty) {
          _period = pivot.period;
        }
      }),
    ];
  }

  String? get period => _period;

  bool isFirst() {
    if (periods.isNotEmpty) {
      return current >= periods.length - 1;
    }
    return true;
  }

  bool isEnd() {
    return current <= 0;
  }

  void prevPeriod() {
    if (isFirst()) {
      return;
    }
    current = current + 1;
    period = periods[current];
  }

  void nextPeriod() {
    if (isEnd()) {
      return;
    }
    current = current - 1;
    period = periods[current];
  }

  set period(String? period) {
    if (period == null || _period == period) {
      return;
    }
    _period = period;
    if (results[_period] != null) {
      pivot = results[_period]!;
      update();
      return;
    }
    EasyLoading.show(status: '加载中');
    PivotRepository.todayPivot(type: type, period: _period).then((value) {
      pivot = value;
      update();
      if (!pivot.feeRequired) {
        results[pivot.period] = value;
      }
    }).catchError((error) {
      showError(error);
    }).whenComplete(() => EasyLoading.dismiss());
  }

  @override
  Future<void> request() async {
    showLoading();
    Future.wait(asyncTasks()).then((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(true);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  void initialBefore() {
    ///开启数据保护
    ScreenProtect.protectOn();
  }

  @override
  void onClose() {
    super.onClose();

    ///关闭数据保护
    ScreenProtect.protectOff();
  }
}
