import 'package:get/get.dart';
import 'package:prize_lottery_app/views/glad/controller/qlc_glad_list_controller.dart';

class QlcGladBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QlcGladListController());
  }
}
