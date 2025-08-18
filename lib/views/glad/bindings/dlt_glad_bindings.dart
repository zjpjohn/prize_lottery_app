import 'package:get/get.dart';
import 'package:prize_lottery_app/views/glad/controller/dlt_glad_list_controller.dart';

class DltGladBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DltGladListController());
  }
}
