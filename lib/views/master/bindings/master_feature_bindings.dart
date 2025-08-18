import 'package:get/get.dart';
import 'package:prize_lottery_app/views/master/controllers/feature/dlt_master_feature_controller.dart';
import 'package:prize_lottery_app/views/master/controllers/feature/fc3d_master_feature_controller.dart';
import 'package:prize_lottery_app/views/master/controllers/feature/pl3_master_feature_controller.dart';
import 'package:prize_lottery_app/views/master/controllers/feature/qlc_master_feature_controller.dart';
import 'package:prize_lottery_app/views/master/controllers/feature/ssq_master_feature_controller.dart';

class Fc3dFeatureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Fc3dMasterFeatureController>(
      () => Fc3dMasterFeatureController(),
    );
  }
}

class Pl3FeatureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Pl3MasterFeatureController>(
      () => Pl3MasterFeatureController(),
    );
  }
}

class SsqFeatureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SsqMasterFeatureController>(
      () => SsqMasterFeatureController(),
    );
  }
}

class DltFeatureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DltMasterFeatureController>(
      () => DltMasterFeatureController(),
    );
  }
}

class QlcFeatureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QlcMasterFeatureController>(
      () => QlcMasterFeatureController(),
    );
  }
}
