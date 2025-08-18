import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/views/user/model/message_center.dart';
import 'package:prize_lottery_app/views/user/repository/message_repository.dart';

class ChannelMessageController extends AbsPageQueryController {
  ///
  /// 分页查询参数
  int page = 1, limit = 10, total = 0;
  List<MessageInfo> messages = [];

  ///
  /// 站内信渠道
  late String channel;

  ///
  /// 站内信类型
  late String type;

  ///
  /// 渠道名称
  late String name;

  @override
  void initialBefore() {
    type = Get.parameters['type']!;
    name = Get.parameters['name']!;
    channel = Get.parameters['channel']!;
  }

  @override
  bool loadedAll() {
    return total > 0 && messages.length == total;
  }

  @override
  Future<void> onInitial() async {
    showLoading();
    page = 1;
    await MessageRepository.messageList(
      channel: channel,
      type: type,
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      messages
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(messages);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {
    page++;
    await MessageRepository.messageList(
      channel: channel,
      type: type,
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      messages.addAll(value.records);
      Future.delayed(const Duration(milliseconds: 200), () {
        update();
      });
    }).catchError((error) {
      page--;
      showError(error);
    });
  }

  @override
  Future<void> onRefresh() async {
    page = 1;
    await MessageRepository.messageList(
      channel: channel,
      type: type,
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      messages
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(messages);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
