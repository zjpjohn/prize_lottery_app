import 'package:prize_lottery_app/base/model/enum_value.dart';
import 'package:prize_lottery_app/utils/date_util.dart';

///
/// 用户会员信息
class UserMember {
  late int times;
  late String expireAt;
  late String lastExpire;
  late EnumValue state;
  late String renewTime;
  late DateTime expireTime;

  UserMember.fromJson(Map json) {
    times = json['times'];
    expireAt = json['expireAt'];
    lastExpire = json['lastExpire'] ?? '';
    state = EnumValue.fromJson(json['state']);
    renewTime = json['renewTime'];
    expireTime = _expireTime();
  }

  DateTime _expireTime() {
    return DateUtil.parse(expireAt, pattern: 'yyyy/MM/dd HH:mm:ss');
  }

  Map toJson() {
    return {
      'times': times,
      'expireAt': expireAt,
      'lastExpire': lastExpire,
      "state": state.toJson(),
      'renewTime': renewTime
    };
  }
}

///
/// 用户会员日志
class UserMemberLog {
  late int id;
  late String orderNo;
  late String packNo;
  late String packName;
  late String channel;
  late EnumValue timeUnit;
  late int type;
  late int payed;
  late String expireStart;
  late String expireEnd;
  late String gmtCreate;

  UserMemberLog.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    orderNo = json['orderNo'];
    packNo = json['packNo'];
    packName = json['packName'];
    channel = json['channel'] ?? '';
    type = json['type'] ?? 2;
    timeUnit = EnumValue.fromJson(json['timeUnit']);
    payed = int.parse(json['payed']);
    expireStart = DateUtil.formatDate(
        DateUtil.parse(json['expireStart'], pattern: 'yyyy/MM/dd HH:mm:ss'),
        format: 'yyyy/MM/dd');
    expireEnd = DateUtil.formatDate(
        DateUtil.parse(json['expireEnd'], pattern: 'yyyy/MM/dd HH:mm:ss'),
        format: 'yyyy/MM/dd');
    gmtCreate = DateUtil.formatDate(
        DateUtil.parse(json['gmtCreate'], pattern: 'yyyy/MM/dd HH:mm:ss'),
        format: 'yyyy/MM/dd');
  }
}

///
/// 会员套餐信息
class MemberPackage {
  ///
  /// 套餐编号
  late String seqNo;

  ///套餐名称
  late String name;

  ///描述信息
  late String remark;

  ///套餐价格
  late int price;

  ///折扣价格
  late int discount;

  ///有效期单位
  late EnumValue timeUnit;

  ///套餐优先级
  late int priority;

  ///是否为试用套餐
  late int onTrial;

  MemberPackage.fromJson(Map<String, dynamic> json) {
    seqNo = json['seqNo'];
    name = json['name'];
    remark = json['remark'];
    price = int.parse(json['price']);
    discount = int.parse(json['discount']);
    timeUnit = EnumValue.fromJson(json['timeUnit']);
    priority = json['priority'] ?? 0;
    onTrial = json['onTrial'] ?? 0;
  }
}

///
/// 会员特权信息
class MemberPrivilege {
  late String name;
  late String icon;
  late String content;
  late int sorted;

  MemberPrivilege.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
    content = json['content'];
    sorted = json['sorted'];
  }
}
