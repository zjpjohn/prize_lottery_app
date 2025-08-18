import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/share_request_widget.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/store/store.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/utils/poster_util.dart';
import 'package:prize_lottery_app/views/user/controller/user_invite_controller.dart';
import 'package:prize_lottery_app/views/user/model/user_agent_rule.dart';
import 'package:prize_lottery_app/views/user/model/user_invite.dart';
import 'package:prize_lottery_app/views/user/widgets/invite_poster_widget.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:visibility_detector/visibility_detector.dart';

class UserInviteView extends StatefulWidget {
  const UserInviteView({super.key});

  @override
  State<UserInviteView> createState() => _UserInviteViewState();
}

class _UserInviteViewState extends State<UserInviteView> {
  ///
  ///
  bool _showNative = true;

  @override
  Widget build(BuildContext context) {
    return ShareRequestWidget<UserInviteController>(
      title: '邀请赚钱',
      share: (controller) {
        _showAgentPoster(controller);
      },
      builder: (controller) {
        return VisibilityDetector(
          key: const Key('user-invite-key'),
          onVisibilityChanged: (visibleInfo) {
            var fraction = visibleInfo.visibleFraction;
            if (mounted) {
              setState(() {
                _showNative = fraction != 0.0;
              });
            }
          },
          child: ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildInviteInfo(controller.invite, controller.rule),
                  _buildAgentApplying(controller, controller.invite),
                  _buildInviteRule(controller, controller.rule),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInviteInfo(UserInvite invite, UserAgentRule rule) {
    return Container(
      margin: EdgeInsets.only(left: 12.w, right: 12.w, top: 12.w),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 12.w,
              right: 16.w,
              top: 32.w,
              bottom: 20.w,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.w),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${invite.invites}',
                                    style: TextStyle(
                                      color: const Color(0xFFFF6005),
                                      fontFamily: 'bebas',
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  Text(
                                    '人数',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.black38,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${invite.rewards}',
                                    style: TextStyle(
                                      color: const Color(0xFFFF6005),
                                      fontFamily: 'bebas',
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  Text(
                                    '金币',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.black38,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            if (invite.agent.value == 0) {
                              Get.toNamed(AppRoutes.inviteHistory);
                              return;
                            }
                            Get.toNamed(AppRoutes.agentAccount);
                          },
                          child: Container(
                            width: 82.w,
                            height: 28.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF6005),
                              borderRadius: BorderRadius.circular(20.w),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFFF6005)
                                      .withValues(alpha: 0.4),
                                  offset: const Offset(4, 4),
                                  blurRadius: 8,
                                  spreadRadius: 0.0,
                                )
                              ],
                            ),
                            child: Text(
                              invite.agent.value == 0 ? '邀请历史' : '账户收益',
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
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 14.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 2.w, top: 2.5.w),
                        child: Icon(
                          const IconData(0xe63d, fontFamily: 'iconfont'),
                          size: 12.sp,
                          color: const Color(0xFFD2B48C).withValues(alpha: 0.5),
                        ),
                      ),
                      Text(
                        rule.agent.value == 0
                            ? '每邀请1个用户获得${rule.reward}金币，用于查看收费推荐方案'
                            : '获得被邀请用户收益的${(rule.ratio * 100).toInt()}%，且可结算提现',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11.5.sp,
                          color: Colors.black26,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0.5.w,
            left: 0.5.w,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 3.w, horizontal: 4.w),
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6.w),
                  bottomRight: Radius.circular(6.w),
                ),
              ),
              child: Text(
                invite.agent.description,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFFFF6005),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///正在申请中的申请记录
  Widget _buildAgentApplying(
      UserInviteController controller, UserInvite invite) {
    if (invite.applying == 1) {
      return Container(
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.only(left: 12.w, right: 12.w, top: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.w),
        ),
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAgentHeader(),
            Padding(
              padding: EdgeInsets.only(top: 16.w),
              child: RichText(
                text: TextSpan(
                  text: '流量合作伙伴申请系统正在',
                  style: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontSize: 13.sp,
                  ),
                  children: const [
                    TextSpan(
                      text: '审核中',
                      style: TextStyle(
                        color: Color(0xFFFF0033),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(text: '，请您耐心等待'),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 16.w, bottom: 4.w, right: 4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 32.w,
                    padding: EdgeInsets.only(left: 12.w, right: 10.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF8E14),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.w),
                        bottomLeft: Radius.circular(20.w),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF8E14).withValues(alpha: 0.4),
                          offset: const Offset(-4, 4),
                          blurRadius: 8,
                          spreadRadius: 0.0,
                        )
                      ],
                    ),
                    child: _buildShareQrcodeView(controller),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.agentApply);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      height: 32.w,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 10.w, right: 12.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6005),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.w),
                          bottomRight: Radius.circular(20.w),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color:
                                const Color(0xFFFF6005).withValues(alpha: 0.4),
                            offset: const Offset(4, 4),
                            blurRadius: 8,
                            spreadRadius: 0.0,
                          )
                        ],
                      ),
                      child: Text(
                        '正在审核中',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    if (invite.partner == 1) {
      return Container(
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.only(left: 12.w, right: 12.w, top: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAgentHeader(),
            Padding(
              padding: EdgeInsets.only(top: 16.w),
              child: Text(
                _agentProtocolText(invite),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.deepOrangeAccent,
                  fontSize: 13.sp,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 16.w, bottom: 4.w, right: 4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 32.w,
                    padding: EdgeInsets.only(left: 12.w, right: 10.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF8E14),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.w),
                        bottomLeft: Radius.circular(20.w),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF8E14).withValues(alpha: 0.4),
                          offset: const Offset(-4, 4),
                          blurRadius: 8,
                          spreadRadius: 0.0,
                        )
                      ],
                    ),
                    child: _buildShareQrcodeView(controller),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.agentApply);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      height: 32.w,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 10.w, right: 12.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6005),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.w),
                          bottomRight: Radius.circular(20.w),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color:
                                const Color(0xFFFF6005).withValues(alpha: 0.4),
                            offset: const Offset(4, 4),
                            blurRadius: 8,
                            spreadRadius: 0.0,
                          )
                        ],
                      ),
                      child: Text(
                        '申请流量主',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildShareQrcodeView(UserInviteController controller) {
    return GestureDetector(
      onTap: () {
        _showAgentPoster(controller);
      },
      behavior: HitTestBehavior.opaque,
      child: Icon(
        const IconData(0xe674, fontFamily: 'iconfont'),
        size: 16.sp,
        color: Colors.white,
      ),
    );
  }

  String _agentProtocolText(UserInvite invite) {
    if (invite.agent.value == 3) {
      return '查看各级流量合作伙伴流量变现规则，助力快速成长';
    }
    return invite.agent.value == 0
        ? '申请成为应用流量合作伙伴，让您的流量变现成为可能'
        : '申请升级您的流量合作伙伴等级，提高流量变现收益率';
  }

  Widget _buildAgentHeader() {
    return Stack(
      children: [
        Positioned(
          left: 2,
          bottom: 0.5,
          child: Container(
            width: 42.w,
            height: 4.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepOrange.withValues(alpha: 0.5),
                  Colors.deepOrange.withValues(alpha: 0.05),
                ],
              ),
            ),
          ),
        ),
        Text(
          '流量变现',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFFFF6005),
          ),
        ),
      ],
    );
  }

  Widget _buildInviteRule(UserInviteController controller, UserAgentRule rule) {
    return Container(
      margin: EdgeInsets.only(left: 12.w, right: 12.w, top: 12.w, bottom: 24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 16.w),
                padding: EdgeInsets.only(left: 16.w, top: 16.w),
                child: Text(
                  '邀请流程',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFFF6005),
                  ),
                ),
              ),
              SizedBox(
                height: 120.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: StepItem(
                        step: 1,
                        header: true,
                        content: GestureDetector(
                          onTap: () {
                            _showAgentPoster(controller);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                R.shareScan,
                                width: 78.w,
                                height: 78.w,
                              ),
                              Text(
                                '分享邀请码',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Colors.black54,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: StepItem(
                        step: 2,
                        content: Column(
                          children: <Widget>[
                            Image.asset(
                              R.inviteScan,
                              width: 78.w,
                              height: 78.w,
                            ),
                            Text(
                              '扫码下载应用',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.black54,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: StepItem(
                        step: 3,
                        tail: true,
                        content: Column(
                          children: <Widget>[
                            Image.asset(
                              R.shareRegister,
                              width: 78.w,
                              height: 78.w,
                            ),
                            Text(
                              '注册登录应用',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.black54,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 8.w, top: 16.w),
                  child: Text(
                    '邀请说明',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFFF6005),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 6.w),
                  child: RichText(
                    textDirection: TextDirection.ltr,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black87,
                      ),
                      children: [
                        TextSpan(
                            text: rule.agent.value == 0
                                ? '1、每成功邀请一位有效好友，您将获得'
                                : '1、每成功邀请一位有效好友，您将享受该用户后续产生收益的'),
                        TextSpan(
                          text: rule.agent.value == 0
                              ? '${rule.reward}金币'
                              : '${(rule.ratio * 100).toInt()}%',
                          style: const TextStyle(
                            color: Color(0xFFFF6005),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 6.w),
                  child: Text(
                    rule.agent.value == 0
                        ? '2、邀请好友获得的奖励金币发放至我的余额账户中，您可以在查看付费数据时抵扣使用。'
                        : '2、系统会定期(默认每个月)计算您获得的收益，并会有专属客服提前联系您提现结算',
                    style: TextStyle(fontSize: 13.sp, color: Colors.black87),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 6.w),
                  child: Text(
                    '3、点击“右上角分享按钮”生成邀请海报，您可以保存海报至本地相册，便于后续分发宣传。',
                    style: TextStyle(fontSize: 13.sp, color: Colors.black87),
                  ),
                ),
                Text(
                  '4、邀请奖励规则会根据系统运行实际情况进行一定的调整，调整解释权归系统本身所有。',
                  style: TextStyle(fontSize: 13.sp, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAgentPoster(UserInviteController controller) {
    Constants.shareBottomSheet(
      content: InvitePosterWidget(
        posterKey: controller.posterKey,
        userInfo: UserStore().authUser!,
        invite: controller.invite,
      ),
      save: () {
        PosterUtils.saveImage(controller.posterKey);
      },
      copyLink: () {
        Clipboard.setData(ClipboardData(text: controller.invite.invUri));
        EasyLoading.showToast('复制成功');
      },
    );
  }
}

class StepItem extends StatelessWidget {
  const StepItem({
    super.key,
    this.width = 0.5,
    this.size = 18.0,
    this.tail = false,
    this.header = false,
    required this.step,
    required this.content,
  });

  final double width;
  final double size;
  final int step;
  final Widget content;
  final bool tail;
  final bool header;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: IntrinsicWidth(
        child: Column(
          children: [
            SizedBox(
              height: size,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: width,
                      color: header ? Colors.white : const Color(0xFFECECEC),
                    ),
                  ),
                  Container(
                    width: size,
                    height: size,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size),
                      border: Border.all(
                        color: Colors.black12,
                        width: 0.5.w,
                      ),
                    ),
                    child: Text(
                      '$step',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: width,
                      color: tail ? Colors.white : const Color(0xFFECECEC),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: content,
            ),
          ],
        ),
      ),
    );
  }
}
