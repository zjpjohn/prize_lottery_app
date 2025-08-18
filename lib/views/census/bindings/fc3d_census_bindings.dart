import 'package:get/get.dart';
import 'package:prize_lottery_app/views/census/controller/fc3d/fc3d_full_census_controller.dart';
import 'package:prize_lottery_app/views/census/controller/fc3d/fc3d_hot_census_controller.dart';
import 'package:prize_lottery_app/views/census/controller/fc3d/fc3d_lotto_ana_controller.dart';
import 'package:prize_lottery_app/views/census/controller/fc3d/fc3d_rate_census_controller.dart';
import 'package:prize_lottery_app/views/census/controller/fc3d/fc3d_vip_census_controller.dart';

class Fc3dFullCensusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Fc3dFullCensusController());
  }
}

class Fc3dVipCensusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Fc3dVipCensusController());
  }
}

class Fc3dHotCensusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Fc3dHotCensusController());
  }
}

class Fc3dRateCensusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Fc3dRateCensusController());
  }
}

class Fc3dAnalyzeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Fc3dAnalyzeController());
  }
}
