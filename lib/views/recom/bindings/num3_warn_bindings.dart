import 'package:get/get.dart';
import 'package:prize_lottery_app/views/recom/controller/num3_layer_controller.dart';
import 'package:prize_lottery_app/views/recom/controller/num3_warn_controller.dart';

class Num3WarnBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Num3WarnController());
  }
}

class Num3LayerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Num3LayerController());
  }
}
