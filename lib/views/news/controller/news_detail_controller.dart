import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/news/model/lottery_news.dart';
import 'package:prize_lottery_app/views/news/repository/lottery_news_repository.dart';
import 'package:prize_lottery_app/views/rank/model/dlt_master_rank.dart';
import 'package:prize_lottery_app/views/rank/repository/master_rank_repository.dart';

class NewsDetailController extends AbsRequestController {
  ///
  ///
  late String seq;
  late LotteryNews news;

  ///
  List<DltMasterMulRank> ranks = [];

  @override
  void initialBefore() {
    seq = Get.parameters['seq']!;
  }

  @override
  Future<void> request() async {
    ///
    showLoading();

    ///
    Future<void> rankFuture =
        MasterRankRepository.mulDltMasterRanks(limit: 6).then((value) => ranks
          ..clear()
          ..addAll(value.records));

    ///
    Future<void> newsFuture =
        LotteryNewsRepository.newsDetail(seq).then((value) => news = value);
    Future.wait([rankFuture, newsFuture]).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(news);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
