import 'package:get/get.dart';
import 'package:prize_lottery_app/views/master/controllers/search/search_detail_controller.dart';
import 'package:prize_lottery_app/views/master/controllers/search/search_master_controller.dart';

class SearchMasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchMasterController());
  }
}

class SearchDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchDetailController());
  }
}
