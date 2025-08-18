import 'package:get/get.dart';
import 'package:prize_lottery_app/views/census/controller/pl3/pl3_full_census_controller.dart';
import 'package:prize_lottery_app/views/census/controller/pl3/pl3_hot_census_controller.dart';
import 'package:prize_lottery_app/views/census/controller/pl3/pl3_lotto_ana_controller.dart';
import 'package:prize_lottery_app/views/census/controller/pl3/pl3_rate_census_controller.dart';
import 'package:prize_lottery_app/views/census/controller/pl3/pl3_vip_census_controller.dart';

class Pl3FullCensusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Pl3FullCensusController());
  }
}

class Pl3VipCensusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Pl3VipCensusController());
  }
}

class Pl3RateCensusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Pl3RateCensusController());
  }
}

class Pl3HotCensusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Pl3HotCensusController());
  }
}

class Pl3AnalyzeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Pl3AnalyzeController());
  }
}
