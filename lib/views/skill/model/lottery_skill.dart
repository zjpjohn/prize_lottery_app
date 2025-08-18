import 'package:prize_lottery_app/base/model/enum_value.dart';
import 'package:prize_lottery_app/utils/date_util.dart';
import 'package:prize_lottery_app/views/news/model/lottery_news.dart';

class LotterySkill {
  ///唯一标识
  late String seq;

  ///资讯标题
  late String title;

  /// header图片
  late String header;

  ///类型
  late EnumValue type;

  ///技巧摘要
  late String summary;

  ///浏览次数
  late int browse;

  ///创建时间
  late DateTime gmtCreate;

  ///距今时间差
  late TimeDelta delta;

  ///技巧内容
  NewsContent? content;

  LotterySkill.fromJson(Map<String, dynamic> json) {
    seq = json['seq'];
    title = json['title'];
    header = json['header'];
    summary = json['summary'];
    browse = json['browse'];
    gmtCreate = DateUtil.parse(
      json['gmtCreate'],
      pattern: 'yyyy/MM/dd HH:mm:ss',
    );
    delta = DateUtil.timeDeltaText(gmtCreate);
    type = EnumValue.fromJson(json['type']);
    if (json['content'] != null) {
      content = NewsContent.fromJson(json['content']);
    }
  }
}
