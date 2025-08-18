import 'package:flutter/material.dart';
import 'package:prize_lottery_app/base/model/enum_value.dart';

///
///
/// 用户账户领取信息
class UserVoucher {
  late int allNum;
  late int usedNum;
  late int expiredNum;
  late int total;
  late int used;
  late int expired;
  late String gmtCreate;
  late String gmtModify;

  UserVoucher.fromJson(Map<String, dynamic> json) {
    allNum = json['allNum'];
    usedNum = json['usedNum'];
    expiredNum = json['expiredNum'];
    total = json['total'];
    used = json['used'];
    expired = json['expired'];
    gmtCreate = json['gmtCreate'] ?? '';
    gmtModify = json['gmtModify'] ?? '';
  }
}

///
/// 用户领取代金券结果
class DrawVoucher {
  late String seqNo;
  late int voucher;
  late int disposable;
  late String expireAt;
  late String nextTime;

  DrawVoucher.fromJson(Map<String, dynamic> json) {
    seqNo = json['seqNo'];
    voucher = json['voucher'];
    disposable = json['disposable'];
    expireAt = json['expireAt'] ?? '';
    nextTime = json['nextTime'] ?? '';
  }
}

///
/// 代金券信息
class VoucherInfo {
  late String seqNo;
  late String name;
  late String remark;
  late int voucher;
  late int disposable;
  late int expire;
  late int interval;
  late bool canDraw;
  late String lastDraw;
  late String nextDraw;

  VoucherInfo.fromJson(Map<String, dynamic> json) {
    seqNo = json['seqNo'];
    name = json['name'];
    remark = json['remark'];
    voucher = json['voucher'];
    disposable = json['disposable'];
    expire = json['expire'] ?? 0;
    interval = json['interval'] ?? 0;
    canDraw = json['canDraw'] ?? false;
    lastDraw = json['lastDraw'] ?? '';
    nextDraw = json['nextDraw'] ?? '';
  }
}

///
/// 领取代金券日志
class UserVoucherLog {
  late int id;
  late String bizNo;
  late int voucher;
  late int used;
  late EnumValue state;
  late EnumValue expired;
  late String expireAt;
  late String gmtCreate;
  late String gmtModify;
  List<String> description = [];
  Color stateColor = const Color(0xFF00FFFB);
  Color background = const Color(0xFF2A2C3B);

  UserVoucherLog.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    bizNo = json['bizNo'];
    voucher = json['voucher'];
    used = json['used'];
    state = EnumValue.fromJson(json['state']);
    expired = EnumValue.fromJson(json['expired']);
    expireAt = json['expireAt'] ?? '';
    gmtCreate = json['gmtCreate'];
    gmtModify = json['gmtModify'];
    _calcStateDesc();
  }

  String remark() {
    if (expireAt.isEmpty) {
      return '代金券永久有效';
    }
    return '有效期至$expireAt';
  }

  void _calcStateDesc() {
    if (expired.value == 2) {
      background = Colors.grey.shade500;
      stateColor = const Color(0xFF00FFFB);
      description = ['已过期', '很遗憾已过期'];
      return;
    }
    if (state.value == 0) {
      description = ['未使用', '请尽快使用'];
      return;
    }
    if (state.value == 1) {
      description = ['部分使用', '已使用$used金币'];
      return;
    }
    background = Colors.blueGrey.shade500;
    stateColor = const Color(0xFF00FFFB);
    description = ['已使用', '已成功使用'];
  }
}

class UserDraw {
  ///用户名称
  late String name;

  ///用户头像
  late String avatar;

  ///代金券编号
  late String bizNo;

  ///代金券金额
  late int voucher;

  ///领取时间
  late String timestamp;

  UserDraw.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
    bizNo = json['bizNo'];
    voucher = json['voucher'];
    timestamp = json['timestamp'];
  }

  String nameMark() {
    return '${name.substring(0, 4)}**';
  }
}
