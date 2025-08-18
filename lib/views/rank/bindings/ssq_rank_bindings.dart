import 'package:get/get.dart';
import 'package:prize_lottery_app/views/rank/controller/ssq_item_rank_controller.dart';
import 'package:prize_lottery_app/views/rank/controller/ssq_mul_rank_controller.dart';

class SsqMulRankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SsqMulRankController());
  }
}

class SsqItemRankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SsqItemRankController());
  }
}
