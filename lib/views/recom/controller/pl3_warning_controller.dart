import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/base/model/fee_data_result.dart';
import 'package:prize_lottery_app/views/recom/model/n3_warn_recommend.dart';
import 'package:prize_lottery_app/views/recom/repository/warning_repository.dart';

class Pl3WarningController extends AbsRequestController {
  ///预警数据
  late FeeDataResult<N3WarnRecommend> recommend;

  ///缓存预警数据
  Map<String, FeeDataResult<N3WarnRecommend>> results = {};

  ///推荐期号集合
  List<String> periods = [];

  ///当前期号
  String? _period;

  ///期号下标
  int current = 0;

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
      recommend = results[_period]!;
    }
    update();
    if (results[_period] == null) {
      EasyLoading.show(status: '加载中');
      WarnRecommendRepository.pl3WarnRecommend(period: _period).then((value) {
        recommend = value;
        update();
        if (!recommend.feeRequired) {
          results[recommend.period] = value;
        }
      }).catchError((error) {
        showError(error);
      }).whenComplete(() => EasyLoading.dismiss());
    }
  }

  String get title {
    String title = '排列三选号预警分析：';
    if (recommend.data != null && recommend.data!.lastHit != null) {
      title = '$title上期选号预警分析${recommend.data!.lastHit!.description}，';
    }
    if (recommend.data == null || recommend.data!.hit == null) {
      return '$title${recommend.period}期将再接再厉!';
    }
    return '$title${recommend.period}期预警分析${recommend.data!.hit == 0 ? '未命中' : '命中'}!';
  }

  List<Future<void>> asyncTasks() {
    return [
      WarnRecommendRepository.pl3WarnRecommend().then((value) {
        recommend = value;
        if (!value.feeRequired) {
          results[value.period] = value;
        }
        if (recommend.period.isNotEmpty) {
          _period = recommend.period;
        }
      }),
      WarnRecommendRepository.pl3Periods().then((value) {
        periods = value;
        if (periods.isNotEmpty) {
          _period = periods[0];
        }
      }),
    ];
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
}
