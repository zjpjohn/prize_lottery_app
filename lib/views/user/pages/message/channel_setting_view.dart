import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/views/user/controller/message_center_controller.dart';
import 'package:prize_lottery_app/views/user/model/message_center.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class ChannelSettingView extends StatelessWidget {
  ///
  ///
  const ChannelSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '消息设置',
      content: Container(
        color: const Color(0xFFF6F6FB),
        child: GetBuilder<MessageCenterController>(
          builder: (controller) {
            return ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _textHeader(),
                    ..._settingItemList(controller),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _textHeader() {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        top: 12.w,
        bottom: 12.w,
      ),
      child: Text(
        '消息通知',
        style: TextStyle(
          color: Colors.black54,
          fontSize: 14.sp,
        ),
      ),
    );
  }

  List<Widget> _settingItemList(MessageCenterController controller) {
    List<Widget> items = [];
    List<ChannelMessage> channels = controller.channels;
    int size = channels.length;
    for (int i = 0; i < size; i++) {
      items.add(_settingItem(
        controller: controller,
        channel: channels[i],
        border: i < size - 1,
      ));
    }
    return items;
  }

  Widget _settingItem({
    required MessageCenterController controller,
    required ChannelMessage channel,
    required bool border,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: border
              ? BorderSide(color: const Color(0xFFECECEC), width: 0.3.w)
              : BorderSide.none,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
                  padding: EdgeInsets.only(top: 4.w),
                  child: Text(
                    channel.remark,
                    style: TextStyle(
                      fontSize: 13.sp,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black38,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 52.w,
            padding: EdgeInsets.only(left: 8.w),
            child: Transform.scale(
              scale: 0.65,
              child: CupertinoSwitch(
                value: channel.remind == 1 && channel.local == 1,
                inactiveTrackColor: const Color(0xFFF6F6F6),
                activeTrackColor: const Color(0xFF00C2C2),
                onChanged: channel.remind == 0
                    ? null
                    : (value) {
                        controller.setting(
                          channel: channel,
                          remind: value ? 1 : 0,
                        );
                      },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
