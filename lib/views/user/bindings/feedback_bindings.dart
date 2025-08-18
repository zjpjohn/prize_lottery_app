import 'package:get/get.dart';
import 'package:prize_lottery_app/views/user/controller/feedback_controller.dart';

class FeedbackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FeedbackController());
  }
}
