import 'package:get/get.dart';
import 'package:prize_lottery_app/views/glad/controller/pl3_glad_list_controller.dart';

class Pl3GladBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Pl3GladListController());
  }
}
