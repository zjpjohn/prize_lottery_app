///
///
class MasterLottery {
  ///
  late int id;

  ///
  late String type;

  ///
  late String latest;

  ///
  late String gmtModify;

  MasterLottery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    latest = json['latest'];
    gmtModify = json['gmtModify'];
  }

}
