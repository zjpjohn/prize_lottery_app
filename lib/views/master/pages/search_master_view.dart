import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/model/master_value.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/resources/styles.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/master/controllers/search/search_master_controller.dart';
import 'package:prize_lottery_app/views/master/widgets/search_input.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SearchMasterView extends StatefulWidget {
  ///
  const SearchMasterView({super.key});

  @override
  SearchMasterViewState createState() => SearchMasterViewState();
}

class SearchMasterViewState extends State<SearchMasterView>
    with TickerProviderStateMixin {
  ///
  /// 是否显示banner广告
  bool showBanner = true;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: UiStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          top: true,
          child: VisibilityDetector(
            key: const Key('search-center-key'),
            onVisibilityChanged: (visibleInfo) {
              var fraction = visibleInfo.visibleFraction;
              if (mounted) {
                setState(() {
                  showBanner = fraction != 0.0;
                });
              }
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  children: [
                    GetBuilder<SearchMasterController>(
                      builder: (controller) {
                        return SearchInput(
                          hintText: '请输入搜索专家名称',
                          controller: controller.controller,
                          searchHeight: 52.h,
                          vertical: 8.h,
                          onValueChanged: (text) {
                            controller.search = text;
                          },
                          onSubmitted: (text) {
                            controller.search = text;
                          },
                          onCancel: (value) {
                            controller.search = '';
                          },
                        );
                      },
                    ),
                    Expanded(
                      child: RequestWidget<SearchMasterController>(
                        showLoading: false,
                        builder: (controller) {
                          return _buildSearchPanel(controller);
                        },
                      ),
                    ),
                  ],
                ),
                GetBuilder<SearchMasterController>(builder: (controller) {
                  return Positioned(
                    left: 0,
                    right: 0,
                    top: 52.w,
                    child: controller.search.isNotEmpty
                        ? Container(
                            height: MediaQuery.of(context).size.height - 52.w,
                            color: Colors.white,
                            alignment: Alignment.topCenter,
                            child: _buildResultView(controller),
                          )
                        : Container(),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  /// 搜索面板
  Widget _buildSearchPanel(SearchMasterController controller) {
    return ScrollConfiguration(
      behavior: CustomScrollBehavior(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '搜索历史',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.clearHistory();
                    },
                    child: Icon(
                      const IconData(0xe63b, fontFamily: 'iconfont'),
                      size: 18.sp,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(bottom: 16.w, left: 16.w, right: 16.w),
              child: Wrap(
                spacing: 10.w,
                runSpacing: 10.w,
                children: controller.histories
                    .map((e) => _buildHistoryItem(controller, e))
                    .toList(),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(
                vertical: 12.w,
                horizontal: 16.w,
              ),
              child: Text(
                '搜索发现',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(minHeight: 110.h),
              padding: EdgeInsets.only(bottom: 6.w, left: 12.w, right: 12.w),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 10,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 8.w,
                  childAspectRatio: 0.80,
                  mainAxisSpacing: 8.w,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.circular(6.w),
                    ),
                    child: _buildHotMaster(controller, index),
                  );
                },
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(
                vertical: 12.w,
                horizontal: 16.w,
              ),
              child: Text(
                '热门频道',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.w),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildLottoChannel(
                      title: '双色球频道',
                      subTitle: '双色球优质专家大师荟萃',
                      image: R.ssqLottoIcon,
                      onTap: () {
                        Get.toNamed('/ssq/mul_rank/0');
                      },
                    ),
                    SizedBox(width: 12.w),
                    _buildLottoChannel(
                      title: '福彩3D频道',
                      subTitle: '福彩3D优质大师荟萃云集',
                      image: R.fc3dLottoIcon,
                      onTap: () {
                        Get.toNamed(AppRoutes.fc3dMulRank);
                      },
                    ),
                    SizedBox(width: 12.w),
                    _buildLottoChannel(
                      title: '大乐透频道',
                      subTitle: '大乐透臻享专家预测推荐',
                      image: R.dltLottoIcon,
                      onTap: () {
                        Get.toNamed('/dlt/mul_rank/0');
                      },
                    ),
                    SizedBox(width: 12.w),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLottoChannel({
    required String title,
    required String subTitle,
    required String image,
    required GestureTapCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.w, left: 4.w),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.w),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFFF4D3),
                    Color(0xFFFFF9E2),
                    Color(0xFFFFFCF0),
                  ],
                ),
              ),
              child: Row(
                children: [
                  SizedBox(width: 28.w),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 8.w,
                      right: 16.w,
                      top: 12.w,
                      bottom: 12.w,
                    ),
                    child: Column(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: Colors.brown,
                            fontSize: 16.sp,
                          ),
                        ),
                        Text(
                          subTitle,
                          style: TextStyle(
                            color: Colors.brown.withValues(alpha: 0.75),
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              image,
              width: 42.w,
              height: 42.w,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(SearchMasterController controller, String history) {
    return GestureDetector(
      onTap: () {
        controller.search = history;
        controller.controller.text = history;
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(3.w),
        ),
        child: Text(
          Tools.limitText(history, 7),
          style: TextStyle(
            color: Colors.black87,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildHotMaster(SearchMasterController controller, int index) {
    if (controller.hotMasters.length <= index) {
      return const SizedBox.shrink();
    }
    var master = controller.hotMasters[index];
    return GestureDetector(
      onTap: () {
        Get.toNamed('/search/detail/${master.masterId}');
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 6.w),
            child: Container(
              width: 46.w,
              height: 46.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFE6E6E6),
                borderRadius: BorderRadius.circular(46.w),
              ),
              child: CachedAvatar(
                width: 43.w,
                height: 43.w,
                radius: 40.w,
                url: master.avatar,
              ),
            ),
          ),
          Text(
            Tools.limitText(master.name, 4),
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// 搜索结果
  Widget _buildResultView(SearchMasterController controller) {
    if (controller.results.isNotEmpty) {
      return ListView.builder(
        itemCount: controller.results.length,
        padding: EdgeInsets.only(top: 6.w),
        itemBuilder: (context, index) {
          MasterValue master = controller.results[index];
          return GestureDetector(
            onTap: () {
              controller.gotoMasterDetail(master, history: true);
            },
            child: Container(
              padding: EdgeInsets.only(left: 24.w, top: 6.w, bottom: 6.w),
              child: Text(
                master.name,
                style: TextStyle(
                  color: const Color(0xBB000000),
                  fontSize: 14.sp,
                ),
              ),
            ),
          );
        },
      );
    } else if (controller.search.isNotEmpty) {
      return Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 12.w),
        child: Text(
          '没有您要查找的专家',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black87,
          ),
        ),
      );
    }
    return Container();
  }
}
