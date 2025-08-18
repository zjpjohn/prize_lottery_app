import 'package:get/get.dart';
import 'package:prize_lottery_app/views/rank/controller/fc3d_item_rank_controller.dart';
import 'package:prize_lottery_app/views/rank/controller/fc3d_mul_rank_controller.dart';

class Fc3dMulRankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Fc3dMulRankController());
  }
}

class Fc3dItemRankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Fc3dItemRankController());
  }
  
}
