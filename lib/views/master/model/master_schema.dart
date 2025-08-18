import 'package:prize_lottery_app/base/model/master_value.dart';
import 'package:prize_lottery_app/base/model/stat_hit_value.dart';

class MasterSchema {
  ///
  late MasterValue master;

  ///
  late String masterId;

  ///
  late String period;

  ///
  late String latest;

  ///
  late int modified;

  MasterSchema.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    latest = json['latest'] ?? '';
    masterId = json['masterId'];
    master = MasterValue.fromJson(json['master']);
    modified = latest.compareTo(period) > 0 ? 1 : 0;
  }
}

class Fc3dSchema extends MasterSchema {
  ///
  late int d3Hit;

  ///
  late int c5Hit;

  ///
  late StatHitValue d3;

  ///
  late StatHitValue c5;

  ///
  late StatHitValue k1;

  ///
  late StatHitValue k2;

  Fc3dSchema.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    d3Hit = json['d3Hit'];
    c5Hit = json['c5Hit'];
    d3 = StatHitValue.fromJson(json['d3']);
    c5 = StatHitValue.fromJson(json['c5']);
    k1 = StatHitValue.fromJson(json['k1']);
    k2 = StatHitValue.fromJson(json['k2']);
  }
}

class Pl3Schema extends MasterSchema {
  ///
  late int d3Hit;

  ///
  late int c5Hit;

  ///
  late StatHitValue d3;

  ///
  late StatHitValue c5;

  ///
  late StatHitValue k1;

  ///
  late StatHitValue k2;

  Pl3Schema.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    d3Hit = json['d3Hit'];
    c5Hit = json['c5Hit'];
    d3 = StatHitValue.fromJson(json['d3']);
    c5 = StatHitValue.fromJson(json['c5']);
    k1 = StatHitValue.fromJson(json['k1']);
    k2 = StatHitValue.fromJson(json['k2']);
  }
}

class SsqSchema extends MasterSchema {
  ///
  late int r12Hit;

  ///
  late int r20Hit;

  ///
  late int b5Hit;

  ///
  late StatHitValue r20;

  ///
  late StatHitValue r25;

  ///
  late StatHitValue rk3;

  ///
  late StatHitValue b5;

  SsqSchema.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    r12Hit = json['r12Hit'];
    r20Hit = json['r20Hit'];
    b5Hit = json['b5Hit'];
    r20 = StatHitValue.fromJson(json['r20']);
    r25 = StatHitValue.fromJson(json['r25']);
    rk3 = StatHitValue.fromJson(json['rk3']);
    b5 = StatHitValue.fromJson(json['b5']);
  }
}

class DltSchema extends MasterSchema {
  ///
  late int r10Hit;

  ///
  late int b6Hit;

  ///
  late StatHitValue r20;

  ///
  late StatHitValue rk3;

  ///
  late StatHitValue b6;

  DltSchema.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    r10Hit = json['r10Hit'];
    b6Hit = json['b6Hit'];
    r20 = StatHitValue.fromJson(json['r20']);
    rk3 = StatHitValue.fromJson(json['rk3']);
    b6 = StatHitValue.fromJson(json['b6']);
  }
}

class QlcSchema extends MasterSchema {
  ///
  late int r12Hit;

  ///
  late int r18Hit;

  ///
  late StatHitValue red18;

  ///
  late StatHitValue red22;

  ///
  late StatHitValue k3;

  QlcSchema.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    r12Hit = json['r12Hit'];
    r18Hit = json['r18Hit'];
    red18 = StatHitValue.fromJson(json['red18']);
    red22 = StatHitValue.fromJson(json['red22']);
    k3 = StatHitValue.fromJson(json['k3']);
  }
}
