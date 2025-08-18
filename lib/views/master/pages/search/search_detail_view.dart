import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/master/controllers/search/search_detail_controller.dart';
import 'package:prize_lottery_app/views/master/model/master_detail.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:visibility_detector/visibility_detector.dart';

const List<int> years = [1, 2, 3, 4, 5];

class SearchDetailView extends StatelessWidget {
  ///
  const SearchDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '专家详情',
      content: RequestWidget<SearchDetailController>(
        builder: (controller) {
          return VisibilityDetector(
            key: Key('search-detail-${controller.master.masterId}'),
            onVisibilityChanged: (visibleInfo) {
              var fraction = visibleInfo.visibleFraction;
              controller.showBanner = (fraction != 0.0);
            },
            child: ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildMasterInfo(controller),
                    Container(height: 10.w, color: const Color(0xFFF6F6FB)),
                    _buildLotteryList(controller.master),
                    Container(height: 10.w, color: const Color(0xFFF6F6FB)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMasterInfo(SearchDetailController controller) {
    MasterDetail master = controller.master;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 12.w),
                    child: CachedAvatar(
                      width: 50.w,
                      height: 50.w,
                      radius: 50.w,
                      url: master.avatar,
                    ),
                  ),
                  SizedBox(
                    height: 46.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Tools.limitName(master.name, 8),
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${master.browse}',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: const Color(0xFFFF0033),
                              ),
                            ),
                            Text(
                              '次浏览',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.black26,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12.w),
                              child: Text(
                                '${master.subscribe}',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: const Color(0xFFFF0033),
                                ),
                              ),
                            ),
                            Text(
                              '人订阅',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.black26,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.5.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.w),
                  border: Border.all(
                    width: 0.6.w,
                    color: master.focused == 0
                        ? const Color(0xFFFF0033)
                        : Colors.black38,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    if (master.focused == 1) {
                      return;
                    }
                    controller.followMaster();
                  },
                  child: Row(
                    children: [
                      Icon(
                        const IconData(0xe8b1, fontFamily: 'iconfont'),
                        size: 16.sp,
                        color: master.focused == 0
                            ? const Color(0xFFFF0033)
                            : Colors.black38,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: Text(
                          '关注',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: master.focused == 0
                                ? const Color(0xFFFF0033)
                                : Colors.black38,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.w),
            child: Text(
              '专家把全部时间花在研究上，居然什么都没留下！',
              style: TextStyle(
                color: Colors.black38,
                fontSize: 13.sp,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLotteryList(MasterDetail master) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 16.w,
        bottom: 24.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '社区彩龄',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: 16.w),
            padding: EdgeInsets.symmetric(vertical: 16.w),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black26, width: 0.12.w),
              ),
            ),
            child: Text(
              '加入社区约${years[master.masterId.hashCode % years.length]}年',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14.sp,
              ),
            ),
          ),
          Text(
            '预测频道',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 16.w, bottom: 4.w),
            child: GridView.count(
              padding: EdgeInsets.zero,
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.w,
              childAspectRatio: 3.2,
              physics: const NeverScrollableScrollPhysics(),
              children: master.lotteries
                  .map((e) => _buildLotteryItem(master.masterId, e))
                  .toList(),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 16.w, bottom: 16.w),
            margin: EdgeInsets.only(top: 16.w),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.black26, width: 0.12.w),
              ),
            ),
            child: Text(
              '打赏收益',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
              ),
            ),
          ),
          Text(
            '暂无打赏收益',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLotteryItem(String masterId, LotteryItem lottery) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/${lottery.lottery.value}/master/$masterId');
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.75.w,
            color: const Color(0xFFFF0033).withValues(alpha: 0.5),
          ),
          borderRadius: BorderRadius.circular(6.w),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 8.w),
              child: CachedAvatar(
                width: 34.w,
                height: 34.w,
                color: Colors.white,
                url: lotteryIcons[lottery.lottery.value]!,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  lottery.lottery.description,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                lottery.latest.isNotEmpty
                    ? RichText(
                        text: TextSpan(
                          text: '最新第',
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 12.sp,
                          ),
                          children: [
                            TextSpan(
                              text: lottery.latest,
                              style: TextStyle(
                                color: const Color(0xFFFF0033),
                                fontSize: 13.sp,
                              ),
                            ),
                            const TextSpan(text: '期'),
                          ],
                        ),
                      )
                    : Text(
                        '暂无预测',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.sp,
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
