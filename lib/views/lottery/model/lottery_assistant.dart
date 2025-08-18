class LotteryAssistant {
  ///
  late int id;

  ///
  late String type;

  ///
  late String title;

  ///
  late String content;

  ///
  late int sort;

  LotteryAssistant.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    sort = json['sort'];
    type = json['type'];
    title = json['title'];
    content = json['content'] ?? '';
  }
}
