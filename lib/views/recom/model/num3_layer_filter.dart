import 'package:prize_lottery_app/base/model/enum_value.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/recom/model/n3_warn_recommend.dart';

///
/// 分层预警信息
class Num3Layer {
  late EnumValue type;
  late String period;
  late int browses;
  late Lottery last;
  Lottery? current;
  late LayerValue layer1;
  late LayerValue layer2;
  late LayerValue layer3;
  late LayerValue layer4;
  late LayerValue layer5;

  Num3Layer.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    type = EnumValue.fromJson(json['type']);
    browses = Tools.randLimit(json['browses'] ?? 0, 1000);
    last = Lottery.fromJson(json['last'], true);
    layer1 = LayerValue.fromJson(json['layer1']);
    layer2 = LayerValue.fromJson(json['layer2']);
    layer3 = LayerValue.fromJson(json['layer3']);
    layer4 = LayerValue.fromJson(json['layer4']);
    layer5 = LayerValue.fromJson(json['layer5']);
    if (json['current'] != null) {
      current = Lottery.fromJson(json['current'], true);
    }
  }
}

class LayerValue {
  late String name;
  late int hit;
  late List<int> condition;
  late WarnComplex zu3;
  late WarnComplex zu6;

  LayerValue.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    hit = json['hit'];
    condition = (json['condition'] as List).cast<int>();
    zu3 = WarnComplex.fromJson(json['zu3']);
    zu6 = WarnComplex.fromJson(json['zu6']);
  }
}

class Num3LayerState {
  ///彩种类型
  late EnumValue type;

  ///预测期号
  late String period;

  ///0-未知，1-命中,2-已更新
  late int state;

  Num3LayerState.fromJson(Map<String, dynamic> json) {
    type = EnumValue.fromJson(json['type']);
    period = json['period'] ?? '';
    state = json['state'] ?? 0;
  }

  Num3LayerState.empty(String value) {
    type = EnumValue.fromJson({'type': value, 'description': ''});
    period = '';
    state = 0;
  }
}
