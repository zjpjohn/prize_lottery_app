import 'package:get/get.dart';
import 'package:prize_lottery_app/views/rank/controller/dlt_item_rank_controller.dart';
import 'package:prize_lottery_app/views/rank/controller/dlt_mul_rank_controller.dart';

class DltMulRankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DltMulRankController());
  }
}

class DltItemRankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DltItemRankController());
  }
}
