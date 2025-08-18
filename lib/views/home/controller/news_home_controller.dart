import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/views/glad/model/ssq_master_glad.dart';
import 'package:prize_lottery_app/views/glad/repository/master_glad_repository.dart';
import 'package:prize_lottery_app/views/news/model/lottery_news.dart';
import 'package:prize_lottery_app/views/news/repository/lottery_news_repository.dart';
import 'package:prize_lottery_app/views/rank/model/ssq_master_rank.dart';
import 'package:prize_lottery_app/views/rank/repository/master_rank_repository.dart';

class NewsHomeController extends AbsPageQueryController {
  ///
  List<SsqMasterMulRank> ranks = [];
  List<SsqMasterGlad> glads = [];

  int page = 1, limit = 8, total = 0;
  List<LotteryNews> news = [];

  @override
  Future<void> onInitial() async {
    showLoading();

    ///
    Future<void> newsFuture = LotteryNewsRepository.newsList(
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      news
        ..clear()
        ..addAll(value.records);
    });

    ///
    Future<void> rankFuture =
        MasterRankRepository.mulSsqMasterRanks(limit: 9).then((value) => ranks
          ..clear()
          ..addAll(value.records));

    ///
    Future<void> gladFuture =
        MasterGladRepository.ssqGladList(limit: 6).then((value) => glads
          ..clear()
          ..addAll(value.records));

    ///
    await Future.wait([newsFuture, rankFuture, gladFuture]).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(news);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {
    if (news.length == total) {
      EasyLoading.showToast('没有更多资讯');
      return;
    }
    page++;
    await LotteryNewsRepository.newsList(
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      news.addAll(value.records);
      Future.delayed(const Duration(milliseconds: 200), () {
        update();
      });
    }).catchError((error) {
      page--;
      showError(error);
    });
  }

  @override
  Future<void> onRefresh() async {
    page = 1;
    await LotteryNewsRepository.newsList(
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      news
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(news);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
