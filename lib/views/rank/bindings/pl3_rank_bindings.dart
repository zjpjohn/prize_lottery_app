import 'package:get/get.dart';
import 'package:prize_lottery_app/views/rank/controller/pl3_item_rank_controller.dart';
import 'package:prize_lottery_app/views/rank/controller/pl3_mul_rank_controller.dart';

class Pl3MulRankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Pl3MulRankController());
  }
}

class Pl3ItemRankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Pl3ItemRankController());
  }
}
