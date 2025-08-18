import 'package:prize_lottery_app/utils/date_util.dart';
import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/views/home/model/master_feeds.dart';
import 'package:prize_lottery_app/views/home/model/master_lotto_glad.dart';

///
///
///
class FeedHomeRepository {
  ///
  /// 专家中奖资讯
  ///
  static Future<List<MasterLottoGlad>> masterGlads() {
    return HttpRequest().get('/slotto/app/master/glad/list').then((value) {
      List list = value.data;
      return list.map((e) => MasterLottoGlad.fromJson(e)).toList();
    });
  }

  ///
  /// 查询专家信息流
  ///
  static Future<List<MasterFeeds>> masterFeeds(
      {required DateTime time, int page = 1, int limit = 10}) {
    return HttpRequest().get('/slotto/app/master/feeds/list', params: {
      'time': DateUtil.formatDate(time, format: "yyyy-MM-dd HH:mm:ss"),
      'page': page,
      'limit': limit
    }).then((value) {
      List list = value.data;
      return list.map((e) => MasterFeeds.fromJson(e)).toList();
    });
  }
}
