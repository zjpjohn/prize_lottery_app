import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/views/news/model/lottery_news.dart';
import 'package:prize_lottery_app/views/news/repository/lottery_news_repository.dart';

class NewsListController extends AbsPageQueryController {
  ///
  ///
  int page = 1, limit = 8, total = 0;
  List<LotteryNews> news = [];

  @override
  Future<void> onInitial() async {
    showLoading();
    await LotteryNewsRepository.newsList(
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      news
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 250), () {
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
      news.addAll(value.records);
      update();
    }).catchError((error) {
      page--;
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
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(news);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
