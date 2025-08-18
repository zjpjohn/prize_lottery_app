import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/views/user/model/message_center.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';

abstract class MessageWidget extends StatelessWidget {
  ///
  ///
  const MessageWidget({super.key, required this.message});

  final MessageInfo message;

  static Widget from(MessageInfo message) {
    switch (message.type.value) {
      case 1:
        return TextMessageWidget(message: message);
      case 2:
        return LinkMessageWidget(message: message);
      case 3:
        return CardMesageWidget(message: message);
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 16.w,
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(top: 16.w, bottom: 8.w),
          child: Text(
            message.timeText,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black45,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 16.w, right: 16.w),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.w),
          ),
          child: buildView(context, message),
        )
      ],
    );
  }

  Widget buildView(BuildContext context, MessageInfo message);
}

class TextMessageWidget extends MessageWidget {
  ///
  ///
  const TextMessageWidget({super.key, required super.message});

  @override
  Widget buildView(BuildContext context, MessageInfo message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 12.w),
          child: Text(
            message.title,
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 16.w),
          child: Text(
            message.content['text'] ?? '',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black45,
            ),
          ),
        ),
      ],
    );
  }
}

class LinkMessageWidget extends MessageWidget {
  ///
  ///
  const LinkMessageWidget({super.key, required super.message});

  @override
  Widget buildView(BuildContext context, MessageInfo message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 12.w),
          child: Text(
            message.title,
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 12.w),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: const Color(0xFFECECEC), width: 0.3.w),
            ),
          ),
          child: Text(
            message.content['text'] ?? '',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black45,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            String? link = message.content['link'];
            if (link != null && link.isNotEmpty) {
              Get.toNamed(link);
            }
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  message.content['link_text'] ?? '查看详情',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black45,
                  ),
                ),
                Icon(
                  const IconData(0xe8b3, fontFamily: 'iconfont'),
                  size: 12.sp,
                  color: Colors.black45,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CardMesageWidget extends MessageWidget {
  ///
  ///
  const CardMesageWidget({super.key, required super.message});

  @override
  Widget buildView(BuildContext context, MessageInfo message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12.w),
          child: CachedAvatar(
            height: 100.w,
            width: Get.width - 56.w,
            url: message.content['cover']!,
            color: Colors.transparent,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 12.w),
          child: Text(
            message.title,
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 12.w),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: const Color(0xFFECECEC), width: 0.3.w),
            ),
          ),
          child: Text(
            message.content['text'] ?? '',
            maxLines: 2,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black45,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            String? link = message.content['link'];
            if (link != null && link.isNotEmpty) {
              Get.toNamed(link);
            }
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  message.content['link_text'] ?? '查看详情',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black45,
                  ),
                ),
                Icon(
                  const IconData(0xe8b3, fontFamily: 'iconfont'),
                  size: 12.sp,
                  color: Colors.black45,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
