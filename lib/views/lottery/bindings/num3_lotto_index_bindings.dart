import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/controller/num3_lotto_index_controller.dart';

class Num3LottoIndexBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Num3LottoIndexController());
  }
}
