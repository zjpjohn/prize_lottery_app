import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/utils/storage.dart';
import 'package:prize_lottery_app/views/user/model/message_center.dart';
import 'package:prize_lottery_app/views/user/repository/message_repository.dart';

const String localSettingKey = 'msg_center_channel';

class MessageCenterController extends AbsPageQueryController {
  ///
  /// 渠道及最新消息
  List<ChannelMessage> channels = [];

  ///
  /// 渠道本地设置
  Map<String, int> localSetting = {};

  List<ChannelMessage> announceChannels() {
    return channels.where((e) => e.type == 0).toList();
  }

  List<ChannelMessage> remindChannels() {
    return channels.where((e) => e.type == 1).toList();
  }

  ///
  /// 清理消息红点提醒
  ///
  void clearMessageRemind() {
    List<String> channelList =
        channels.where((e) => e.read == 0).map((e) => e.channel).toList();
    if (channelList.isEmpty) {
      EasyLoading.showToast(
        '暂无未读消息',
        toastPosition: EasyLoadingToastPosition.bottom,
      );
      return;
    }
    EasyLoading.show();
    MessageRepository.clearMessage(channelList).then((value) {
      channels.where((e) => e.read == 0).forEach((e) => e.read = 1);
      update();
      EasyLoading.showToast(
        '消息全部已读',
        toastPosition: EasyLoadingToastPosition.bottom,
      );
    });
  }

  ///
  /// 加载本地设置
  ///
  void loadLocalSetting() {
    Map<dynamic, dynamic> setting = Storage().getObj(
      localSettingKey,
      (v) => Map.from(v),
      defValue: {},
    )!;
    localSetting = Map.from(setting);

    ///本地渠道禁止提醒设置
    for (var e in channels) {
      ///本地渠道设置
      int? remind = localSetting[e.channel];

      ///本地已设置禁止提醒，远程设置为提醒，此时更新为本地禁止提醒
      if (remind != null && remind == 0 && e.remind == 1) {
        e.local = 0;
      }
    }
    update();
  }

  ///
  /// 设置渠道提醒开关
  /// 1.远程已禁止提醒，本地设置不起作用
  /// 2.远程未禁止提醒，本地设置禁用，
  /// remind:0-禁止提醒,1-提醒
  ///
  void setting({required ChannelMessage channel, required int remind}) {
    if (channel.remind == 0) {
      return;
    }
    if (remind == 1) {
      channel.local = 1;
      localSetting.remove(channel.channel);
      Storage().putObject(localSettingKey, localSetting);
      update();
      return;
    }
    channel.local = 0;
    localSetting[channel.channel] = 0;
    Storage().putObject(localSettingKey, localSetting);
    update();
  }

  ///
  /// 加载消息渠道
  ///
  void loadMessageChannels() async {
    await MessageRepository.channelMessages().then((value) {
      channels
        ..clear()
        ..addAll(value);
      loadLocalSetting();
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(channels);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onInitial() async {
    showLoading();
    loadMessageChannels();
  }

  @override
  Future<void> onRefresh() async {
    loadMessageChannels();
  }

  @override
  Future<void> onLoadMore() async {}
}
