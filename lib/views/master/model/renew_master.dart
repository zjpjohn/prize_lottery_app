import 'package:prize_lottery_app/base/model/enum_value.dart';
import 'package:prize_lottery_app/base/model/master_value.dart';

class RenewMaster {
  ///
  /// 最新更新方案期号
  late String period;

  ///
  /// 专家标识
  late String masterId;

  ///
  /// 专家信息
  late MasterValue master;

  ///
  /// 彩种类型
  late EnumValue type;

  RenewMaster.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    masterId = json['masterId'];
    master = MasterValue.fromJson(json['master']);
    type = EnumValue.fromJson(json['type']);
  }

  RenewMaster.fromMock({required String avatar, required String name}) {
    period = '2022050';
    masterId = '623213895544245628';
    master = MasterValue('623213895544245628', name, avatar);
    type = EnumValue.fromJson({'value': 'fc3d', 'description': '福彩3D'});
  }

  static List<RenewMaster> mockList() {
    return [
      RenewMaster.fromMock(
        avatar: 'https://image.icaiwa.com/avatar/face1848.png',
        name: '恰似惊鸿落人间',
      ),
      RenewMaster.fromMock(
        avatar: 'https://image.icaiwa.com/avatar/face131.png',
        name: '十年萤火照君眠',
      ),
      RenewMaster.fromMock(
        avatar: 'https://image.icaiwa.com/avatar/face2883.png',
        name: '独听寒山夜半钟',
      ),
      RenewMaster.fromMock(
        avatar: 'https://image.icaiwa.com/avatar/face2900.png',
        name: '单衫杏子红',
      ),
      RenewMaster.fromMock(
        avatar: 'https://image.icaiwa.com/avatar/face2037.png',
        name: '千里落花风',
      ),
    ];
  }
}
