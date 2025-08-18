import 'package:get/get.dart';
import 'package:prize_lottery_app/views/glad/controller/fc3d_glad_list_controller.dart';

class Fc3dGladBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Fc3dGladListController());
  }
}
