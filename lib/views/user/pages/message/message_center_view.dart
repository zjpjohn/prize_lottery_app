import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/model/request_state.dart';
import 'package:prize_lottery_app/base/widgets/refresh_layout_widget.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/views/user/controller/message_center_controller.dart';
import 'package:prize_lottery_app/views/user/model/message_center.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';
import 'package:prize_lottery_app/widgets/common_widgets.dart';

class MessageCenterView extends StatelessWidget {
  ///
  ///
  const MessageCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshLayoutWidget<MessageCenterController>(
      empty: '暂无消息通知',
      enableLoad: false,
      bottomBouncing: false,
      background: Colors.white,
      titleBuilder: (controller) {
        return _buildTitleView(controller);
      },
      rightBuilder: (controller) {
        return _buildRightView(controller);
      },
      builder: (controller) {
        return Column(
          children: [
            ...controller.remindChannels().map((e) => _buildChannelItem(
                  channel: e,
                  border: true,
                  color: const Color(0xFF00C2C2),
                )),
            Container(
              height: 10.w,
              color: const Color(0xFFF6F7FB),
            ),
            ...controller.announceChannels().map((e) => _buildChannelItem(
                  channel: e,
                  border: true,
                  color: const Color(0xFF2A2C3B),
                )),
          ],
        );
      },
    );
  }

  Widget _buildTitleView(MessageCenterController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '消息中心',
          style: TextStyle(
            fontSize: 17.sp,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: () {
            if (controller.state == RequestState.success) {
              controller.clearMessageRemind();
            }
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            margin: EdgeInsets.only(left: 2.w),
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(20.w),
            ),
            child: Icon(
              const IconData(
                0xe66d,
                fontFamily: 'iconfont',
              ),
              size: 19.sp,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRightView(MessageCenterController controller) {
    return GestureDetector(
      onTap: () {
        if (controller.state == RequestState.success) {
          Get.toNamed(AppRoutes.channelSetting);
        }
      },
      child: Container(
        padding: EdgeInsets.only(right: 4.w),
        child: Icon(
          const IconData(
            0xe7eb,
            fontFamily: 'iconfont',
          ),
          size: 23.sp,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildChannelItem({
    required ChannelMessage channel,
    required bool border,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/channel/message'
            '?channel=${channel.channel}'
            '&type=${channel.type == 0 ? 'announce' : 'remind'}'
            '&name=${channel.name}');
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(vertical: 14.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: border
                ? BorderSide(color: const Color(0xFFECECEC), width: 0.3.w)
                : BorderSide.none,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              margin: EdgeInsets.only(right: 8.w),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(25.w),
              ),
              child: CachedAvatar(
                radius: 0,
                width: 24.w,
                height: 24.w,
                url: channel.cover,
                color: Colors.transparent,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    channel.name,
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: Colors.black87,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6.w),
                    child: Text(
                      channel.subtitle(),
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black38,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 36.w,
              width: 46.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    channel.timeText ?? '',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black45,
                    ),
                  ),
                  if (channel.remind == 0 || channel.local == 0)
                    Icon(
                      const IconData(0xe670, fontFamily: 'iconfont'),
                      size: 14.sp,
                      color: Colors.black45,
                    ),
                  if (channel.remind == 1 && channel.read == 0)
                    CommonWidgets.dotted(
                      size: 6.w,
                      color: const Color(0xFFFF0045),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
