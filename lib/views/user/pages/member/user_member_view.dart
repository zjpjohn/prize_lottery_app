import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/resources/styles.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/store/member.dart';
import 'package:prize_lottery_app/store/user.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/pay/widget/pay_launch_panel.dart';
import 'package:prize_lottery_app/views/user/controller/user_member_controller.dart';
import 'package:prize_lottery_app/views/user/model/user_member.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/nav_app_bar.dart';

class UserMemberView extends StatefulWidget {
  const UserMemberView({super.key});

  @override
  State<UserMemberView> createState() => _UserMemberViewState();
}

class _UserMemberViewState extends State<UserMemberView> {
  ///
  ///
  final ScrollController _scrollController = ScrollController();

  ///
  final StreamController<double> _streamController =
      StreamController<double>.broadcast();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: UiStyle.dark,
      child: SafeArea(
        top: false,
        child: Container(
          color: const Color(0xFFF7F9F9),
          child: Stack(
            children: [
              RequestWidget<UserMemberController>(
                builder: (controller) {
                  return Stack(
                    children: [
                      Positioned(
                        width: Get.width,
                        height: Get.height,
                        child: ScrollConfiguration(
                          behavior: CustomScrollBehavior(),
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: Column(
                              children: [
                                _buildMemberView(),
                                _buildPrivilegeView(controller),
                                _buildPackageView(controller),
                                _buildMemberHint(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: _buildBuyView(controller),
                      )
                    ],
                  );
                },
              ),
              StreamBuilder(
                stream: _streamController.stream,
                initialData: 0.0,
                builder: (_, snapshot) {
                  return MemberTopHeader(
                    top: MediaQuery.of(context).padding.top,
                    shrinkOffset: snapshot.data!,
                    onTap: () {
                      showDialog(
                        context: Get.context!,
                        barrierDismissible: false,
                        builder: (context) {
                          return _buildHeaderDialog();
                        },
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMemberView() {
    return Container(
      padding: EdgeInsets.only(
        bottom: 4.w,
        top: MediaQuery.of(context).padding.top + 50.w,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFEEE1BF).withValues(alpha: 0.6),
            const Color(0xFFEEE1BF).withValues(alpha: 0.05),
          ],
        ),
      ),
      child: GetBuilder<MemberStore>(builder: (store) {
        return Padding(
          padding: EdgeInsets.all(16.w),
          child: Container(
            height: 160.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.w),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(R.vipBackground),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 16.w, bottom: 4.w),
                        child: Text(
                          '会员服务特权',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.brown,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'shuhei',
                          ),
                        ),
                      ),
                      !store.hasMember()
                          ? Text(
                              '非常抱歉，您暂未开通会员特权',
                              style: TextStyle(
                                color: Colors.brown,
                                fontSize: 13.sp,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.memberLog);
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Row(
                                children: [
                                  Text(
                                    store.memberText(),
                                    style: TextStyle(
                                      color: Colors.brown,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 4.w),
                                    child: Icon(
                                      const IconData(
                                        0xe8b3,
                                        fontFamily: 'iconfont',
                                      ),
                                      size: 12.sp,
                                      color: Colors.brown,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: 76.w,
                      padding: EdgeInsets.only(top: 22.w),
                      child: Container(
                        color: Colors.white30,
                        padding: EdgeInsets.only(left: 16.w),
                        child: Row(
                          children: [
                            Image.asset(R.avatar, width: 22.w, height: 22.w),
                            Padding(
                              padding: EdgeInsets.only(left: 4.w),
                              child: Text(
                                Tools.encodeTel(UserStore().authUser!.phone),
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  color: Colors.brown,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (MemberStore().hasMember())
                      Positioned(
                        right: 16.w,
                        top: 0,
                        child: Image.asset(
                          R.vipMedal,
                          width: 58.w,
                          height: 58.w,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPackageView(UserMemberController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.w),
      child: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 16.w),
              ...controller.packList
                  .map((e) => _buildPackageItem(e, controller)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPackageItem(
      MemberPackage pack, UserMemberController controller) {
    return GestureDetector(
      onTap: () {
        controller.memberPack = pack;
      },
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(right: 16.w),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(6.w),
              border: controller.memberPack!.seqNo == pack.seqNo
                  ? Border.all(color: const Color(0xFFFFC136), width: 1.w)
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pack.name,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.brown,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 2.w, right: 2.w),
                        child: Text(
                          '¥',
                          style: TextStyle(
                            color: Colors.brown,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                      Text(
                        (pack.discount / 100).toStringAsFixed(0),
                        style: TextStyle(
                          fontSize: 22.sp,
                          color: Colors.brown,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4.w, bottom: 2.w),
                        child: Text(
                          (pack.price ~/ 100).toStringAsFixed(0),
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.brown.shade400,
                            decorationThickness: 2.w,
                            decoration: TextDecoration.lineThrough,
                            decorationStyle: TextDecorationStyle.solid,
                            decorationColor: Colors.brown.shade400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  pack.remark,
                  style: TextStyle(
                    color: Colors.brown.shade300,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          if (pack.priority == 1)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFA015).withValues(alpha: 0.15),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6.w),
                  bottomRight: Radius.circular(6.w),
                ),
              ),
              child: Text(
                '推荐',
                style: TextStyle(
                  color: const Color(0xFFFF0045),
                  fontSize: 11.sp,
                ),
              ),
            ),
          if (pack.priority == 0 && pack.onTrial == 1)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFA015).withValues(alpha: 0.15),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6.w),
                  bottomRight: Radius.circular(6.w),
                ),
              ),
              child: Text(
                '体验',
                style: TextStyle(
                  color: const Color(0xFFFF0045),
                  fontSize: 11.sp,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPrivilegeView(UserMemberController controller) {
    if (controller.privileges.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: EdgeInsets.only(top: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16.w),
            child: Text(
              '会员特权',
              style: TextStyle(
                fontSize: 17.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GridView.count(
            padding: EdgeInsets.zero,
            crossAxisCount: 4,
            childAspectRatio: 1,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: controller.privileges
                .map(
                  (e) => Column(
                    children: [
                      Container(
                        width: 44.w,
                        height: 44.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(25.w),
                        ),
                        child: CachedAvatar(
                          width: 24.w,
                          height: 24.w,
                          url: e.icon,
                          color: const Color(0xFFF2F2F2),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12.w),
                        child: Text(
                          e.name,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }

  Widget _buildMemberHint() {
    return Container(
      margin: EdgeInsets.only(bottom: 140.w, top: 4.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(
        '温馨提示：会员服务一旦付费开通后，系统不支持退订退款，请您谨慎选择购买。',
        style: TextStyle(
          color: Colors.black45,
          fontSize: 13.sp,
          height: 1.25,
        ),
      ),
    );
  }

  Widget _buildBuyView(UserMemberController controller) {
    return Container(
      width: Get.width,
      color: Colors.white,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 16.w),
      child: Column(
        children: [
          _buildBuyPackBtn(controller),
          _buildMemberProtocol(controller),
        ],
      ),
    );
  }

  Widget _buildBuyPackBtn(UserMemberController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 6.w),
      padding: EdgeInsets.symmetric(vertical: 7.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.w),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFFF965F),
            Color(0xFFFA6E2D),
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () {
          controller.showPayChannel(showDialog: () {
            Constants.bottomSheet(
              PayContactPanel(
                title: '哇彩推荐${controller.memberPack!.name}服务',
                amount: controller.memberPack!.discount,
              ),
              isDismissible: false,
              enableDrag: false,
            );
          });
        },
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${(controller.memberPack!.discount / 100).toStringAsFixed(0)}元',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.w),
                  child: Text(
                    '立即开通',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                )
              ],
            ),
            Text(
              '开通即可享受全场推荐资料，去开通吧',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberProtocol(UserMemberController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            controller.agree = !controller.agree;
          },
          child: Container(
            width: 32.w,
            height: 22.w,
            alignment: Alignment.centerRight,
            child: Image.asset(
              controller.agree ? R.checkedIcon : R.uncheckedIcon,
              width: 16.w,
              height: 16.w,
            ),
          ),
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.black54,
              fontSize: 13.sp,
            ),
            children: [
              const TextSpan(
                text: '已阅读并同意',
              ),
              WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.usage);
                    },
                    child: Text(
                      '会员服务协议',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black45,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                    ),
                  ),
                ),
              ),
              const TextSpan(
                text: '和',
              ),
              WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.usage);
                    },
                    child: Text(
                      '使用协议',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black45,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildHeaderDialog() {
    return Center(
      child: Container(
        width: 280.w,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '会员特权说明',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.w),
              child: Text(
                '1.由于系统提供的推荐资料为付费查阅，需要开通系统提供的会员服务才能查看推荐资料。'
                '\n2.开通会员服务暂不支持在线支付开通，请添加系统管理员微信，联系管理员手动开通会员服务。',
                style: TextStyle(
                  color: const Color(0xFF666666),
                  fontSize: 14.sp,
                  height: 1.5,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 200.w,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 8.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2254F4).withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                  child: Text(
                    '我知道啦',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _streamController.sink.add(_scrollController.offset);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class MemberTopHeader extends StatelessWidget {
  MemberTopHeader({
    super.key,
    required this.top,
    required this.shrinkOffset,
    required this.onTap,
  });

  ///
  /// 垂直偏移量
  final double verticalOffset = 50.h;

  ///收缩高度
  final double height = 50.h;

  ///
  final double shrinkOffset;

  ///
  final double top;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: top + height,
      color: shrinkColor(shrinkOffset),
      child: Column(
        children: [
          SizedBox(
            height: top,
            width: Get.width,
          ),
          Container(
            width: Get.width,
            alignment: Alignment.center,
            child: NavAppBar(
              border: false,
              color: Colors.transparent,
              center: Text(
                '系统会员',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18.sp,
                ),
              ),
              left: Container(
                width: 40.w,
                height: 32.w,
                alignment: Alignment.centerLeft,
                child: Icon(
                  const IconData(0xe669, fontFamily: 'iconfont'),
                  size: 20.w,
                  color: Colors.black87,
                ),
              ),
              right: GestureDetector(
                onTap: () {
                  onTap();
                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Icon(
                    const IconData(0xe607, fontFamily: 'iconfont'),
                    size: 20.sp,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color shrinkColor(double shrinkOffset) {
    if (shrinkOffset == 0) {
      return Colors.transparent;
    }
    if (shrinkOffset <= verticalOffset) {
      int alpha = (shrinkOffset / verticalOffset * 255).clamp(0, 255).toInt();
      return Color.fromARGB(alpha, 255, 255, 255);
    }
    return Colors.white;
  }
}
