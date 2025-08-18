import 'package:get/get.dart';
import 'package:prize_lottery_app/views/census/controller/qlc/qlc_full_census_controller.dart';
import 'package:prize_lottery_app/views/census/controller/qlc/qlc_hot_census_controller.dart';
import 'package:prize_lottery_app/views/census/controller/qlc/qlc_lotto_ana_controller.dart';
import 'package:prize_lottery_app/views/census/controller/qlc/qlc_rate_census_controller.dart';
import 'package:prize_lottery_app/views/census/controller/qlc/qlc_vip_census_controller.dart';

class QlcFullCensusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QlcFullCensusController());
  }
}

class QlcVipCensusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QlcVipCensusController());
  }
}

class QlcRateCensusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QlcRateCensusController());
  }
}

class QlcHotCensusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QlcHotCensusController());
  }
}

class QlcAnalyzeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QlcAnalyzeController());
  }
}
