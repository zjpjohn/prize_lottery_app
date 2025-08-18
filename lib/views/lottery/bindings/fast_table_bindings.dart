import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/diagrams_table_controller.dart';
import 'package:prize_lottery_app/views/lottery/controller/fast_table_controller.dart';
import 'package:prize_lottery_app/views/lottery/controller/hunt_table_controller.dart';
import 'package:prize_lottery_app/views/lottery/controller/wuxing_table_controller.dart';

class FastTableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FastTableController());
  }
}

class HuntTableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HuntTableController());
  }
}

class DiagramsTableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DiagramsTableController());
  }
}

class WuXingTableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WuXingTableController());
  }
}
