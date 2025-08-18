import 'package:get/get.dart';
import 'package:prize_lottery_app/views/census/controller/ssq/ssq_full_census_controller.dart';
import 'package:prize_lottery_app/views/census/controller/ssq/ssq_hot_census_controller.dart';
import 'package:prize_lottery_app/views/census/controller/ssq/ssq_lotto_ana_controller.dart';
import 'package:prize_lottery_app/views/census/controller/ssq/ssq_rate_census_controller.dart';
import 'package:prize_lottery_app/views/census/controller/ssq/ssq_vip_census_controller.dart';

class SsqFullCensusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SsqFullCensusController());
  }
}

class SsqVipCensusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SsqVipCensusController());
  }
}

class SsqRateCensusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SsqRateCensusController());
  }
}

class SsqHotCensusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SsqHotCensusController());
  }
}

class SsqAnalyzeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SsqAnalyzeController());
  }
}
