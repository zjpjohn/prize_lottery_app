import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/resources/styles.dart';
import 'package:prize_lottery_app/store/balance.dart';
import 'package:prize_lottery_app/views/user/controller/user_sign_controller.dart';
import 'package:prize_lottery_app/views/user/model/sign_info.dart';
import 'package:prize_lottery_app/views/user/model/user_balance.dart';
import 'package:prize_lottery_app/views/user/widgets/sign_widget.dart';
import 'package:prize_lottery_app/widgets/animate_number.dart';
import 'package:prize_lottery_app/widgets/clipper_views.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/custome_card.dart';
import 'package:prize_lottery_app/widgets/dash_line.dart';
import 'package:prize_lottery_app/widgets/empty_widget.dart';
import 'package:prize_lottery_app/widgets/flip_card.dart';
import 'package:prize_lottery_app/widgets/nav_app_bar.dart';

class UserSignView extends StatelessWidget {
  ///
  ///
  const UserSignView({super.key});

  @override
  Widget build(BuildContext context) {
    //获取状态栏高度
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return AnnotatedRegion(
      value: UiStyle.light,
      child: Scaffold(
        body: Stack(
          children: [
            ClipPath(
              clipper: SignClipper(),
              child: Container(
                height: 240.h,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xFFFA753E),
                    Color(0xFFF83600),
                  ]),
                ),
              ),
            ),
            Column(
              children: [
                _buildAppBar(statusBarHeight),
                Expanded(
                  child: RequestWidget<UserSignController>(
                    builder: (controller) {
                      return ScrollConfiguration(
                        behavior: CustomScrollBehavior(),
                        child: ExtendedNestedScrollView(
                          onlyOneScrollInBody: true,
                          headerSliverBuilder: (context, scrolled) {
                            return [
                              SliverToBoxAdapter(
                                child: Container(
                                  alignment: Alignment.topCenter,
                                  padding: EdgeInsets.only(top: 16.w),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              showSignRule(controller.signInfo);
                                            },
                                            child: Container(
                                              height: 28.h,
                                              padding: EdgeInsets.fromLTRB(
                                                  12.w, 0, 6.w, 0),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFFF7648),
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(14.w),
                                                  bottomLeft:
                                                      Radius.circular(14.w),
                                                ),
                                              ),
                                              child: Text(
                                                '签到规则',
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 12.w),
                                            child: Text(
                                              '连签',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22.sp,
                                                fontFamily: 'shuhei',
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '${controller.signInfo.throttle}',
                                            style: TextStyle(
                                              color: const Color(0xffF3F748),
                                              fontSize: 24.sp,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'shuhei',
                                            ),
                                          ),
                                          Text(
                                            '天',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 21.sp,
                                              fontFamily: 'shuhei',
                                            ),
                                          ),
                                          ClipPath(
                                            clipper: TopLeftClipper(),
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  16.w, 2.w, 8.w, 4.w),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFFEEBB1),
                                                borderRadius:
                                                    BorderRadius.circular(2.w),
                                              ),
                                              child: Text(
                                                '赢大额积分',
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xFFFF421A),
                                                  fontSize: 12.sp,
                                                  fontFamily: 'shuhei',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(top: 10.w),
                                        child: _buildSignInfo(controller),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ];
                          },
                          body: Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                _buildCouponBalance(controller),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: _signLogViews(controller),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(double statusBarHeight) {
    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      child: NavAppBar(
        gradients: const [
          Color(0xFFFA753E),
          Color(0xFFF83600),
        ],
        left: Container(
          width: 32.w,
          height: 32.w,
          alignment: Alignment.centerLeft,
          child: Icon(
            const IconData(0xe669, fontFamily: 'iconfont'),
            size: 18.w,
            color: Colors.white,
          ),
        ),
        center: Text(
          '积分签到',
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSignInfo(UserSignController controller) {
    return Container(
      margin: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 12.w),
      child: _buildSignView(controller),
    );
  }

  Widget _buildSignView(UserSignController controller) {
    SignInfo signInfo = controller.signInfo;
    return CCard(
      borderRadius: 8.w,
      child: Container(
        margin: EdgeInsets.only(left: 8.w, right: 8.w, top: 12.w, bottom: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '每日签到',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 13.sp,
                    ),
                  ),
                  Text(
                    signInfo.lastDate != null
                        ? '上次签到 ${signInfo.lastDate}'
                        : '',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 11.sp,
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _signCards(signInfo, controller.cardKey),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                signInfo.throttle - signInfo.hasSeries > 0
                    ? '再签${signInfo.throttle - signInfo.hasSeries}天将获得积分大奖'
                    : '恭喜您获得大额积分奖励',
                style: TextStyle(
                  color: signInfo.throttle - signInfo.hasSeries > 0
                      ? Colors.black38
                      : const Color(0xFFFF0045),
                  fontSize: 12.sp,
                ),
              ),
            ),
            _buildSignBtn(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildSignBtn(UserSignController controller) {
    return GestureDetector(
      onTap: () {
        if (controller.signInfo.hasSigned == 0) {
          controller.signAction(success: () {
            controller.cardKey.currentState!.toggleCard();
          });
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 12.w),
        alignment: Alignment.center,
        child: Container(
          height: 36.w,
          width: 200.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFFD4A68),
            borderRadius: BorderRadius.circular(20.w),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFD4A68).withValues(alpha: 0.4),
                offset: const Offset(4, 4),
                blurRadius: 8,
                spreadRadius: 0.0,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                controller.signInfo.hasSigned == 0
                    ? (controller.signing ? '正在签到' : '立即签到')
                    : '今日已签到',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                ),
              ),
              if (controller.signing)
                Padding(
                  padding: EdgeInsets.only(left: 6.w),
                  child: SpinKitRing(
                    color: Colors.white,
                    lineWidth: 1.2.w,
                    size: 16.w,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _signCards(SignInfo signInfo, GlobalKey<FlipCardState> cardKey) {
    List<Widget> cards = [];
    for (int i = 1; i <= signInfo.throttle; i++) {
      cards.add(
        FlipCard(
          key: i == signInfo.series + 1 ? cardKey : null,
          flipOnTouch: false,
          direction: FlipDirection.horizontal,
          front: SignCard(
            title: '$i天',
            hasSigned: i <= signInfo.series,
            index: i,
            throttle: signInfo.throttle,
          ),
          back: SignCard(
            title: '$i天',
            hasSigned: i > signInfo.series,
            index: i,
            throttle: signInfo.throttle,
          ),
        ),
      );
    }
    return cards;
  }

  ///
  /// 积分账户
  Widget _buildCouponBalance(UserSignController controller) {
    SignInfo signInfo = controller.signInfo;
    UserBalance? balance = BalanceInstance().balance;
    return Container(
      height: 90.w,
      margin: EdgeInsets.only(top: 20.w, bottom: 8.w, left: 24.w, right: 24.w),
      decoration: ShapeDecoration(
        color: const Color(0xFFFFEEE7),
        shape: HoleShapeBorder(size: 12.w),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimateNumber(
                        number: balance!.coupon,
                        start: balance.coupon - 9 < 0 ? 0 : balance.coupon - 9,
                        duration: 1000,
                        style: TextStyle(
                          fontSize: 24.sp,
                          color: Colors.black87,
                          fontFamily: 'bebas',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2.w),
                        child: Text(
                          '积分',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        controller.exchangeCoupon();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.w,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFd4A68),
                          borderRadius: BorderRadius.circular(20.w),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0xFFFd4A68)
                                    .withValues(alpha: 0.4),
                                offset: const Offset(4, 4),
                                blurRadius: 8,
                                spreadRadius: 0.0)
                          ],
                        ),
                        child: Text(
                          '兑换金币',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 10.w, bottom: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    const IconData(0xe63d, fontFamily: 'iconfont'),
                    size: 12.sp,
                    color: const Color(0xFFD2B48C),
                  ),
                  Text(
                    '${signInfo.rule.ratio}积分兑换1金币，超过${signInfo.rule.throttle}积分可兑换',
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _signLogViews(UserSignController controller) {
    List<SignLog> logs = controller.logs;
    if (logs.isEmpty) {
      return [
        Padding(
          padding: EdgeInsets.only(top: 16.w, bottom: 16.w),
          child: EmptyView(
            size: 82.w,
            message: '没有签到记录',
          ),
        )
      ];
    }
    List<Widget> views = logs
        .map((e) => Container(
              margin: EdgeInsets.only(left: 24.w, right: 24.w),
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 10.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: const Color(0xFFF2F2F2),
                    width: 0.5.w,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            e.type.description,
                            style: TextStyle(
                              color: e.type.value == 1
                                  ? Colors.black87
                                  : const Color(0xFFFF0033),
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            e.signTime,
                            style: TextStyle(
                              color: Colors.black26,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '+${e.award}',
                            style: TextStyle(
                              color: const Color(0xFFFF0033),
                              fontSize: 16.sp,
                              fontFamily: 'bebas',
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 1.w),
                            child: Text(
                              '积分',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.black26,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ))
        .toList();
    views.add(
      Container(
        padding: EdgeInsets.only(top: 14.w, bottom: 14.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 2.w),
              child: Icon(
                const IconData(0xe63d, fontFamily: 'iconfont'),
                size: 12.sp,
                color: const Color(0xFFD2B48C),
              ),
            ),
            Text(
              '最多显示${controller.limit}条签到记录',
              style: TextStyle(
                color: Colors.black26,
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
      ),
    );
    return views;
  }

  void showSignRule(SignInfo signInfo) {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 230.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.w),
                ),
                padding: EdgeInsets.only(bottom: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 16.w, bottom: 10.w),
                      child: Text(
                        '签到规则',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        '1、每日签到，用户每天签到都将会获得${signInfo.ecoupon}个奖励积分。',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 2.w, 16.w, 0),
                      child: Text(
                        '2、连续签到，用户连续签到${signInfo.throttle}天，将会获得${signInfo.scoupon}个大额奖励积分。',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 2.w, 16.w, 0),
                      child: Text(
                        '3、签到周期，系统将签到周期设置为${signInfo.throttle}天，当用户每完成${signInfo.throttle}天签到，会自动开启新的签到周期。',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 2.w, 16.w, 0),
                      child: Text(
                        '4、积分用途，当用户的积分达到一定额度后，用户可以在【我的积分】中将积分兑换成金币，然后在平台中使用。',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1.w,
                height: 58.h,
                color: Colors.white,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  transform: Matrix4.translationValues(0, -1.w, 0),
                  child: Icon(
                    const IconData(0xe621, fontFamily: 'iconfont'),
                    size: 28.w,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
