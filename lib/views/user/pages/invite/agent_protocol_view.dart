import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/model/enum_value.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/resources/styles.dart';
import 'package:prize_lottery_app/store/store.dart';
import 'package:prize_lottery_app/views/lottery/controller/agent_protocol_controller.dart';
import 'package:prize_lottery_app/views/user/controller/user_invite_controller.dart';
import 'package:prize_lottery_app/views/user/model/user_invite.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';

class AgentProtocolView extends StatelessWidget {
  const AgentProtocolView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: UiStyle.dark,
      child: Scaffold(
        body: Stack(
          children: [
            CachedAvatar(
              width: Get.width,
              height: Get.height,
              url: ResourceStore().resource(R.agentProtocolBg),
            ),
            RequestWidget<AgentProtocolController>(
              builder: (controller) {
                UserInviteController inviteController =
                    Get.find<UserInviteController>();
                return ScrollConfiguration(
                  behavior: CustomScrollBehavior(),
                  child: SingleChildScrollView(
                    child: Container(
                      height: controller.contentHeight,
                      margin: EdgeInsets.only(
                        top: 44.h + MediaQuery.of(context).padding.top,
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CachedAvatar(
                              color: Colors.transparent,
                              width: Get.width,
                              height: 290.w,
                              url: ResourceStore()
                                  .resource(R.agentProtocolIllustration),
                            ),
                            Positioned(
                              top: 200.w,
                              left: 0,
                              width: Get.width,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(4.w),
                                    margin: EdgeInsets.only(
                                        left: 16.w, right: 16.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.w),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.orange.withValues(alpha: 0.5),
                                          Colors.orange,
                                        ],
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(4.w),
                                      ),
                                      child: Column(
                                        children: [
                                          _buildTitleView(),
                                          _buildProtocolContent(
                                            controller,
                                            inviteController.invite.agent,
                                          ),
                                          _buildAgentApply(
                                            controller,
                                            inviteController.invite,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  _buildProtocolFooter(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            _buildProtocolHeader(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProtocolHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: MediaQuery.of(context).padding.top,
      ),
      child: PreferredSize(
        preferredSize: Size.fromHeight(44.h),
        child: SizedBox(
          height: 44.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 26.w,
                      height: 26.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.circular(20.w)),
                      child: Icon(
                        const IconData(0xe669, fontFamily: 'iconfont'),
                        size: 18.w,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(child: Container()),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleView() {
    return Container(
      margin: EdgeInsets.only(top: 12.w, bottom: 16.w),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 39.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.w),
                      bottomLeft: Radius.circular(5.w),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Colors.orange,
                        Colors.orange.withValues(alpha: 0.05),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 39.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5.w),
                      bottomRight: Radius.circular(5.w),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.orange,
                        Colors.orange.withValues(alpha: 0.05),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 2.w),
            child: Text(
              '流量主权益',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProtocolContent(
      AgentProtocolController controller, EnumValue level) {
    return Column(
      children: controller.rules.map((e) {
        if (e.agent.value == 0) {
          return _buildRuleItemView(
            current: level.value,
            index: e.agent.value + 1,
            agent: e.agent.description,
            content: '邀请1人可获得${e.reward}金币，金币可抵扣查看非免费推荐方案。用户注册时系统自动开通此渠道。',
          );
        }
        return _buildRuleItemView(
          current: level.value,
          index: e.agent.value + 1,
          agent: e.agent.description,
          content:
              '邀请1人可获得该用户后续产生收益的${(e.ratio * 100).toInt()}%，且收益可以结算提现。用户需要提交申请，系统审核通过方可开通。',
        );
      }).toList(),
    );
  }

  Widget _buildRuleItemView({
    required int index,
    required String agent,
    required int current,
    required String content,
  }) {
    return Container(
      margin: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 16.w),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 12.w,
              right: 12.w,
              top: 18.w,
              bottom: 12.w,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8EE),
              borderRadius: BorderRadius.circular(4.w),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 4.w),
                      child: Icon(
                        IconData(
                          index == current + 1 ? 0xe66f : 0xe7f7,
                          fontFamily: 'iconfont',
                        ),
                        size: 14.sp,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    Text(
                      agent,
                      style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.w),
                  child: Text(
                    content,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0.5.w,
            left: 0.5.w,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 1.w, horizontal: 6.w),
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent.withValues(alpha: 0.08),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.w),
                  bottomRight: Radius.circular(4.w),
                ),
              ),
              child: Text(
                '0$index',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.deepOrangeAccent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgentApply(
      AgentProtocolController controller, UserInvite invite) {
    if (invite.applying == 1 || invite.agent.value == 3) {
      return const SizedBox.shrink();
    }
    return GestureDetector(
      onTap: () {
        controller.agentApply();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.only(top: 8.w, bottom: 16.w),
        child: Text(
          '立即申请',
          style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 20.sp,
            fontFamily: "zhengdao",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildProtocolFooter() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '温馨提示',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13.sp,
            ),
          ),
          Text(
            '1、提交申请后，平台会在2-3个工作日内审核完成，审核通过后用户为一级代理，二级和三级代理需在一级代理基础上进行申请。',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13.sp,
            ),
          ),
          Text(
            '2、如果流量主存在作弊和违法行为，系统有权取消该流量主的代理资格，将其降级为普通分享。',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13.sp,
            ),
          ),
          Text(
            '3、本规则解释权归系统平台所有，后续在市场反馈情况下和系统运营过程中，平台有权根据实际情况对规则进行调整。',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}
