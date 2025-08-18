import 'package:prize_lottery_app/utils/date_util.dart';

///
///
class LotteryNews {
  ///唯一标识
  late String seq;

  ///资讯标题
  late String title;

  /// header图片
  late String header;

  ///
  late String source;

  /// 资讯类型
  String? type;

  ///资讯摘要
  late String summary;

  ///浏览次数
  late int browse;

  ///创建时间
  late DateTime gmtCreate;

  ///距今时间差
  late TimeDelta delta;

  ///资讯内容
  NewsContent? content;

  LotteryNews.fromJson(Map<String, dynamic> json) {
    seq = json['seq'];
    title = json['title'];
    header = json['header'];
    source = json['source'];
    summary = json['summary'];
    browse = json['browse'];
    gmtCreate = DateUtil.parse(
      json['gmtCreate'],
      pattern: 'yyyy/MM/dd HH:mm:ss',
    );
    delta = DateUtil.timeDeltaText(gmtCreate);
    if (json['type'] != null) {
      type = json['type'];
    }
    if (json['content'] != null) {
      content = NewsContent.fromJson(json['content']);
    }
  }
}

class NewsContent {
  ///
  late List<NewsParagraph> paragraphs;

  NewsContent.fromJson(Map<String, dynamic> json) {
    List result = json['paragraphs'];
    paragraphs = result.map((e) => NewsParagraph.fromJson(e)).toList();
  }
}

class NewsParagraph {
  ///
  /// 段落类型：1-文本,2-图片
  late int type;

  ///内容
  late String content;

  NewsParagraph.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    content = json['content'];
  }
}
