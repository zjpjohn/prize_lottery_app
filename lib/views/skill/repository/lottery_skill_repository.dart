import 'package:prize_lottery_app/base/model/page_result.dart';
import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/views/skill/model/lottery_skill.dart';

class LotterySkillRepository {
  ///
  ///分页查询使用技巧
  static Future<PageResult<LotterySkill>> skillList(
      {String? type, int page = 1, int limit = 8}) {
    return HttpRequest().get(
      '/slotto/app/skill/list',
      params: {'type': type, 'page': page, 'limit': limit},
    ).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => LotterySkill.fromJson(e),
      ),
    );
  }

  ///
  /// 实用技巧详情
  static Future<LotterySkill> skillDetail(String seq) {
    return HttpRequest()
        .get('/slotto/app/skill/$seq')
        .then((value) => LotterySkill.fromJson(value.data));
  }
}
