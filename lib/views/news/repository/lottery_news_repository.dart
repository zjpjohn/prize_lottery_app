import 'package:prize_lottery_app/base/model/page_result.dart';
import 'package:prize_lottery_app/utils/request.dart';
import 'package:prize_lottery_app/views/news/model/lottery_news.dart';

class LotteryNewsRepository {
  ///
  ///分页查询资讯
  static Future<PageResult<LotteryNews>> newsList({
    String? type,
    int page = 1,
    int limit = 8,
  }) {
    return HttpRequest().get('/slotto/app/news/list', params: {
      'type': type,
      'page': page,
      'limit': limit,
    }).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => LotteryNews.fromJson(e),
      ),
    );
  }

  ///
  /// 资讯详情
  static Future<LotteryNews> newsDetail(String seq) {
    return HttpRequest()
        .get('/slotto/app/news/$seq')
        .then((value) => LotteryNews.fromJson(value.data));
  }
}
