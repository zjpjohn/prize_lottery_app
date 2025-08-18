import 'package:get/get.dart';
import 'package:prize_lottery_app/views/rank/controller/qlc_item_rank_controller.dart';
import 'package:prize_lottery_app/views/rank/controller/qlc_mul_rank_controller.dart';

class QlcMulRankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QlcMulRankController());
  }
}

class QlcItemRankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QlcItemRankController());
  }
}
