import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/resources/colors.dart';
import 'package:prize_lottery_app/resources/styles.dart';
import 'package:prize_lottery_app/views/home/pages/dlt_home_view.dart';
import 'package:prize_lottery_app/views/home/pages/fc3d_home_view.dart';
import 'package:prize_lottery_app/views/home/pages/feed_home_view.dart';
import 'package:prize_lottery_app/views/home/pages/news_home_view.dart';
import 'package:prize_lottery_app/views/home/pages/pl3_home_view.dart';
import 'package:prize_lottery_app/views/home/pages/qlc_home_view.dart';
import 'package:prize_lottery_app/views/home/pages/skill_home_view.dart';
import 'package:prize_lottery_app/views/home/pages/ssq_home_view.dart';
import 'package:prize_lottery_app/widgets/tabbar_container_widget.dart';

class HomeCenterView extends StatefulWidget {
  const HomeCenterView({super.key});

  @override
  HomeCenterViewState createState() => HomeCenterViewState();
}

class HomeCenterViewState extends State<HomeCenterView> {
  ///
  ///tab选项集合
  final List<String> _tabs = [
    '推 荐',
    '双色球',
    '大乐透',
    '福彩3D',
    '排列三',
    '七乐彩',
    '选号技巧',
    '中奖新闻',
  ];

  ///
  ///tab页面集合
  final List<Widget> _pages = [
    const FeedHomeView(),
    const SsqHomeView(),
    const DltHomeView(),
    const Fc3dHomeView(),
    const Pl3HomeView(),
    const QlcHomeView(),
    const SkillHomeView(),
    const NewsHomeView(),
  ];

  List<List<Color>> gradients = [
    recomColors,
    ssqColors,
    dltColors,
    fc3dColors,
    pl3Colors,
    qlcColors,
    skillColors,
    newsColors,
  ];

  List<Color> colors = recomColors;

  @override
  Widget build(BuildContext context) {
    double statusBar = MediaQuery.of(context).padding.top;
    return AnnotatedRegion(
      value: UiStyle.light,
      child: Scaffold(
        extendBody: true,
        backgroundColor: const Color(0xFFF8F8FB),
        body: Stack(
          children: [
            Container(
              height: Get.height * 0.55,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.25, 0.40, 0.55, 0.70, 0.85, 1.0],
                  colors: colors,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: statusBar),
              child: TabBarContainer(
                tabs: _tabs,
                pages: _pages,
                initialIndex: 0,
                tabHeight: 44.w,
                onChange: (index) {
                  setState(() {
                    colors = gradients[index];
                  });
                },
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                labeledStyle:
                    TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                unselectedStyle:
                    TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                moreIcon: Icon(
                  const IconData(0xe616, fontFamily: 'iconfont'),
                  color: Colors.white70,
                  size: 19.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
