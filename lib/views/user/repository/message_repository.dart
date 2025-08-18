import 'package:prize_lottery_app/base/model/page_result.dart';
import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/views/user/model/message_center.dart';

///
///
///
class MessageRepository {
  ///
  /// 消息中心消息列表
  ///
  static Future<List<ChannelMessage>> channelMessages() {
    return HttpRequest().get('/push/app/message/channel').then((value) {
      List list = value.data;
      return list.map((e) => ChannelMessage.fromJson(e)).toList();
    });
  }

  ///
  /// 站内信信息查询
  ///
  static Future<PageResult<MessageInfo>> messageList({
    required String channel,
    required String type,
    int page = 1,
    int limit = 10,
  }) {
    return HttpRequest().post('/push/app/message/list', params: {
      'type': type,
      'channel': channel,
      'page': page,
      'limit': limit,
    }).then((value) => PageResult.fromJson(
          json: value.data,
          handle: (e) => MessageInfo.fromJson(e),
        ));
  }

  ///
  /// 清理站内信提醒，设置最新已读
  ///
  static Future<void> clearMessage(List<String> channels) {
    return HttpRequest().postJson(
      '/push/app/message/clear',
      data: {'channels': channels},
    ).then((value) => null);
  }
}
