import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher_string.dart';

const weixin = 'weixin://';

class WechatInfoView extends StatelessWidget {
  ///
  ///
  const WechatInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    ///
    /// 复制公众号到剪贴板
    Clipboard.setData(const ClipboardData(
      text: 'wacaiyingyong123',
    ));
    return Container(
      width: 320.w,
      height: 172.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '关注微信公众号',
            style: TextStyle(
              fontSize: 17.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.w),
            child: Text(
              'wacaiyingyong123',
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.black87,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.w, bottom: 16.w),
            child: Text(
              '微信公众号已经复制到剪贴板，是否现在打开微信关注吗？',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black54,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '稍后',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (await canLaunchUrlString(weixin)) {
                    await launchUrlString(weixin);
                  }
                },
                child: Text(
                  '打开微信',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.sp,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
