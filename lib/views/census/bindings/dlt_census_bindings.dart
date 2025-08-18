import 'package:get/get.dart';
import 'package:prize_lottery_app/views/census/controller/dlt/dlt_full_census_controller.dart';
import 'package:prize_lottery_app/views/census/controller/dlt/dlt_hot_census_controller.dart';
import 'package:prize_lottery_app/views/census/controller/dlt/dlt_lotto_ana_controller.dart';
import 'package:prize_lottery_app/views/census/controller/dlt/dlt_rate_census_controller.dart';
import 'package:prize_lottery_app/views/census/controller/dlt/dlt_vip_census_controller.dart';

class DltFullCensusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DltFullCensusController());
  }
}

class DltVipCensusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DltVipCensusController());
  }
}

class DltRateCensusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DltRateCensusController());
  }
}

class DltHotCensusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DltHotCensusController());
  }
}

class DltAnalyzeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DltAnalyzeController());
  }
}
