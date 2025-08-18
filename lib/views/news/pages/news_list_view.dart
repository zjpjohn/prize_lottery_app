import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/views/news/controller/news_list_controller.dart';
import 'package:prize_lottery_app/views/news/model/lottery_news.dart';
import 'package:prize_lottery_app/widgets/feed_item_widget.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class NewsListView extends StatefulWidget {
  ///
  ///
  const NewsListView({super.key});

  @override
  NewsListViewState createState() => NewsListViewState();
}

class NewsListViewState extends State<NewsListView> {
  ///
  ///
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '中奖资讯',
      content: Container(
        color: Colors.white,
        child: RefreshWidget<NewsListController>(
          global: false,
          init: NewsListController(),
          scrollController: _scrollController,
          topConfig: const ScrollTopConfig(align: TopAlign.right),
          builder: (controller) {
            return ListView.builder(
              itemCount: controller.news.length,
              itemBuilder: (context, index) => _buildNewsItem(
                controller.news[index],
                index,
                index < controller.news.length - 1,
                controller.limit,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNewsItem(
    LotteryNews news,
    int index,
    bool border,
    int pageSize,
  ) {
    return FeedItemWidget(
      title: news.title,
      delta: news.delta,
      header: news.header,
      browse: news.browse,
      border: border,
      showAds: index > 0 && index % 20 == 4,
      onTap: () {
        Get.toNamed('/news/detail/${news.seq}');
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
