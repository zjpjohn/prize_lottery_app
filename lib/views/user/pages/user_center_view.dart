import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/resources/styles.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/store/balance.dart';
import 'package:prize_lottery_app/store/member.dart';
import 'package:prize_lottery_app/views/user/controller/user_center_controller.dart';
import 'package:prize_lottery_app/views/user/model/user_balance.dart';
import 'package:prize_lottery_app/views/user/widgets/master_recommend_view.dart';
import 'package:prize_lottery_app/views/user/widgets/ucenter_header.dart';
import 'package:prize_lottery_app/widgets/animate_view.dart';
import 'package:prize_lottery_app/widgets/clipper_views.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/lottery_hint_widget.dart';

class UserCenterView extends StatefulWidget {
  ///
  const UserCenterView({super.key});

  @override
  UserCenterViewState createState() => UserCenterViewState();
}

class UserCenterViewState extends State<UserCenterView>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  /// 动画控制器
  late AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    UserCenterController controller = Get.put(UserCenterController());
    return AnnotatedRegion(
      value: UiStyle.dark,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7F9),
        body: SafeArea(
          top: false,
          child: _buildContentLayout(controller),
        ),
      ),
    );
  }

  Widget _buildContentLayout(UserCenterController controller) {
    return EasyRefresh(
      topBouncing: true,
      bottomBouncing: false,
      controller: controller.refreshController,
      header: MaterialHeader(),
      onRefresh: controller.refreshing,
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: UCenterHeader(
              MediaQuery.of(context).padding.top,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _acctNumberView(),
                _functionPanelView(),
                _buildLottoChannel(),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: GetBuilder<UserCenterController>(
              builder: (controller) {
                if (controller.ranks.isNotEmpty) {
                  return Container(
                    color: const Color(0xFFF6F6FB),
                    child: _recommendView(controller),
                  );
                }
                return Container(
                  height: 375.w,
                  color: const Color(0xFFF6F6FB),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: GetBuilder<UserCenterController>(builder: (controller) {
              if (controller.ranks.isNotEmpty) {
                return Container(
                  color: const Color(0xFFF6F6FB),
                  child: _buildBottomHint(),
                );
              }
              return const SizedBox.shrink();
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomHint() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.w),
      child: const LotteryHintWidget(
        hint: '本应用不提供购彩服务，请理性购彩',
      ),
    );
  }

  ///
  /// 会员特权面板
  Widget _userMemberView() {
    return Container(
      height: 58.w,
      margin: EdgeInsets.only(left: 16.w, right: 16.w),
      decoration: BoxDecoration(
        color: Color(0xFF222126),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6.w),
          topRight: Radius.circular(6.w),
        ),
      ),
      child: Stack(
        children: [
          Image.asset(
            R.memberBg,
            height: 58.h,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.member);
            },
            behavior: HitTestBehavior.opaque,
            child: GetBuilder<MemberStore>(builder: (store) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '会员服务',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                              fontFamily: 'shuhei',
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2.w),
                            child: Text(
                              store.memberText(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 4.w),
                      child: Text(
                        store.buttonText(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  ///
  /// 数字账户面板
  Widget _acctNumberView() {
    return Container(
      height: 138.w,
      margin: EdgeInsets.only(top: 16.w),
      child: Stack(
        children: [
          Positioned(
            child: _userMemberView(),
          ),
          Positioned(
            top: 48.w,
            left: 0,
            width: Get.width,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(6.w),
                  bottomRight: Radius.circular(6.w),
                ),
                child: ClipPath(
                  clipper: MemberClipper(),
                  child: Container(
                    color: Colors.white,
                    height: 90.w,
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.w),
                    child: _balanceAcctView(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// 账户余额面板
  Widget _balanceAcctView() {
    return GetBuilder<BalanceInstance>(
      builder: (store) {
        UserBalance? balance = store.balance;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Get.toNamed('/balance/0');
              },
              child: Column(
                children: [
                  Container(
                    height: 26.w,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: 2.w),
                    child: Text(
                      '${balance != null ? balance.balance : 0}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontFamily: 'bebas',
                      ),
                    ),
                  ),
                  Text(
                    '奖励金',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    '可抵扣提现',
                    style: TextStyle(fontSize: 10.sp, color: Colors.black38),
                  ),
                ],
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Get.toNamed('/balance/1');
              },
              child: Column(
                children: [
                  Container(
                    height: 26.w,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: 2.w),
                    child: Text(
                      '${balance != null ? balance.surplus : 0}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontFamily: 'bebas',
                      ),
                    ),
                  ),
                  Text(
                    '金 币',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '仅付费抵扣',
                    style: TextStyle(fontSize: 10.sp, color: Colors.black38),
                  ),
                ],
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Get.toNamed(AppRoutes.sign);
              },
              child: Column(
                children: [
                  Container(
                    height: 26.w,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: 2.w),
                    child: Text(
                      '${balance != null ? balance.coupon : 0}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontFamily: 'bebas',
                      ),
                    ),
                  ),
                  Text(
                    '积 分',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '兑换金币',
                    style: TextStyle(fontSize: 10.sp, color: Colors.black38),
                  ),
                ],
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Get.toNamed(AppRoutes.voucher);
              },
              child: Column(
                children: [
                  Container(
                    height: 26.w,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: 2.w),
                    child: Text(
                      '${balance != null ? balance.voucher : 0}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontFamily: 'bebas',
                      ),
                    ),
                  ),
                  Text(
                    '代金券',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '定期赠送',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.black38,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Get.toNamed(AppRoutes.account);
              },
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 2.w),
                    child: Image.asset(
                      R.acctBalance,
                      height: 26.w,
                      width: 30.w,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    '我的账户',
                    style: TextStyle(color: Colors.black, fontSize: 12.sp),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  ///
  /// 用户功能面板
  Widget _functionPanelView() {
    return Container(
      margin: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
      padding: EdgeInsets.only(
        left: 8.w,
        right: 8.w,
        top: 12.w,
        bottom: 8.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: GridView.count(
        padding: EdgeInsets.zero,
        crossAxisCount: 5,
        mainAxisSpacing: 4.w,
        crossAxisSpacing: 8.w,
        childAspectRatio: 1,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Get.toNamed(AppRoutes.subscribe);
            },
            child: _cellView(
              icon: R.subscribe,
              title: '关注收藏',
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Get.toNamed(AppRoutes.sign);
            },
            child: _cellView(
              icon: R.sign,
              title: '签到活动',
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Get.toNamed(AppRoutes.invite);
            },
            child: _cellView(
              icon: R.shareGift,
              title: '邀请赚钱',
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Get.toNamed(AppRoutes.skillList);
            },
            child: _cellView(
              icon: R.skill,
              title: '选号攻略',
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Get.toNamed(AppRoutes.memberLog);
            },
            child: _cellView(
              icon: R.order,
              title: '我的订单',
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Get.toNamed(AppRoutes.browse);
            },
            child: _cellView(
              icon: R.history,
              title: '浏览历史',
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Get.toNamed(AppRoutes.assistant);
            },
            child: _cellView(
              icon: R.assistant,
              title: '彩票助手',
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.reset);
            },
            behavior: HitTestBehavior.opaque,
            child: _cellView(
              icon: R.forecastMoney,
              title: '账户安全',
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Get.toNamed(AppRoutes.feedback);
            },
            child: _cellView(
              icon: R.feedback2,
              title: '反馈建议',
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Get.toNamed(AppRoutes.manualBook);
            },
            child: _cellView(
              icon: R.manual,
              title: '使用指南',
            ),
          ),
        ],
      ),
    );
  }

  Widget _cellView({required String icon, required String title}) {
    return Column(
      children: [
        Image.asset(
          icon,
          width: 36.w,
          height: 36.w,
        ),
        Padding(
          padding: EdgeInsets.only(top: 4.w),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLottoChannel() {
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.w),
      padding:
          EdgeInsets.only(left: 12.w, right: 12.w, top: 12.w, bottom: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: 8.w),
            child: Text(
              '主要频道',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _lotteryChannel(
                  title: '双色球频道',
                  subTitle: '优质牛人大师荟萃',
                  image: R.ssqLottoIcon,
                  onTap: () {
                    Get.toNamed('/ssq/mul_rank/0');
                  },
                ),
                SizedBox(width: 14.w),
                _lotteryChannel(
                  title: '大乐透频道',
                  subTitle: '臻享专家预测推荐',
                  image: R.dltLottoIcon,
                  onTap: () {
                    Get.toNamed('/dlt/mul_rank/0');
                  },
                ),
                SizedBox(width: 14.w),
                _lotteryChannel(
                  title: '福彩3D频道',
                  subTitle: '优质大师荟萃云集',
                  image: R.fc3dLottoIcon,
                  onTap: () {
                    Get.toNamed(AppRoutes.fc3dMulRank);
                  },
                ),
                SizedBox(width: 14.w),
                _lotteryChannel(
                  title: '排列三频道',
                  subTitle: '精选专家推荐指导',
                  image: R.pl3LottoIcon,
                  onTap: () {
                    Get.toNamed('/dlt/mul_rank/0');
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _lotteryChannel({
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
            padding: EdgeInsets.only(top: 4.w, left: 4.w),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.w),
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
                  SizedBox(width: 20.w),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 16.w,
                      top: 12.w,
                      bottom: 12.w,
                    ),
                    child: Column(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          subTitle,
                          style: TextStyle(
                            color: Colors.brown.withValues(alpha: 0.65),
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
              width: 26.w,
              height: 26.w,
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// 用户推荐面板
  Widget _recommendView(UserCenterController controller) {
    List<Widget> views = [];
    List<MasterRankRecommend> ranks = controller.notEmptyRanks;
    int count = ranks.length;
    for (int i = 0; i < count; i++) {
      MasterRankRecommend rank = ranks[i];
      Animation<double> animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      animationController.forward();
      views.add(
        AnimateView(
          vertical: false,
          animation: animation,
          controller: animationController,
          child: MasterRecommendView(
            recommend: rank,
            marginLeft: i == 0 ? 10.w : 0,
          ),
        ),
      );
    }
    return Container(
      margin: EdgeInsets.only(bottom: 16.w),
      color: Colors.transparent,
      child: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: views,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
