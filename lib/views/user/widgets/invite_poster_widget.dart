import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:prize_lottery_app/env/env_profile.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/views/user/model/user_auth.dart';
import 'package:prize_lottery_app/views/user/model/user_invite.dart';
import 'package:prize_lottery_app/widgets/dash_line.dart';

class InvitePosterWidget extends StatelessWidget {
  ///
  ///
  const InvitePosterWidget({
    super.key,
    required this.posterKey,
    required this.userInfo,
    required this.invite,
  });

  final GlobalKey posterKey;
  final AuthUser userInfo;
  final UserInvite invite;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: posterKey,
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(R.sharePosterBackground),
          ),
        ),
        child: Column(
          children: [
            Transform.translate(
              offset: const Offset(0, 3),
              child: Container(
                width: 280.w,
                color: Colors.white,
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 16.w, bottom: 8.w),
                child: Column(
                  children: [
                    Text(
                      userInfo.nickname,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 17.sp,
                        fontFamily: 'shuhei',
                      ),
                    ),
                    Text(
                      '欢迎使用凡彩推荐',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15.sp,
                        fontFamily: 'shuhei',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Material(
              shape: InviteShapeBorder(
                radius: 6.w,
                dashCount: 30,
                color: Colors.brown.shade200,
              ),
              color: Colors.white,
              child: Container(
                width: 280.w,
                padding: EdgeInsets.symmetric(vertical: 16.w),
                child: Stack(
                  children: [
                    SizedBox(
                      width: 280.w,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 16.w, top: 10.w),
                            child: Text(
                              '我的专属邀请码',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 15.sp,
                                fontFamily: 'shuhei',
                              ),
                            ),
                          ),
                          Container(
                            width: 120.w,
                            height: 120.w,
                            alignment: Alignment.center,
                            child: PrettyQrView.data(
                              data: '${invite.invUri}/${Profile.props.appNo}',
                              errorCorrectLevel: QrErrorCorrectLevel.H,
                              decoration: const PrettyQrDecoration(
                                shape: PrettyQrSmoothSymbol(
                                  roundFactor: 0.5,
                                ),
                                image: PrettyQrDecorationImage(
                                  image: AssetImage(R.logo),
                                  scale: 0.25,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12.w),
                            child: Text(
                              '凡彩推荐',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 20.sp,
                                fontFamily: 'shuhei',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.w),
                            child: Text(
                              '助力百万彩民成为中奖小福星',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 13.sp,
                                fontFamily: 'shuhei',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildWaterMark(invite.code),
                  ],
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -3),
              child: Material(
                shape: const InviteBottomShapeBorder(count: 18),
                color: Colors.white,
                child: Container(
                  width: 280.w,
                  padding: EdgeInsets.only(
                    bottom: 20.w,
                    left: 16.w,
                    right: 16.w,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 12.w,
                    ),
                    child: Column(
                      children: [
                        Transform.rotate(
                          angle: -pi / 45,
                          child: Container(
                            height: 26.w,
                            margin: EdgeInsets.only(bottom: 8.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F8F8),
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.w),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 30.w,
                                  height: 26.w,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(right: 16.w),
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.w),
                                    ),
                                  ),
                                  child: Icon(
                                    const IconData(0xe655,
                                        fontFamily: 'iconfont'),
                                    size: 13.w,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                Text(
                                  '手机扫一扫打开上述二维码链接',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(8, 0),
                          child: Container(
                            height: 26.w,
                            margin: EdgeInsets.only(bottom: 8.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F8F8),
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.w),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 30.w,
                                  height: 26.w,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(right: 16.w),
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.w),
                                    ),
                                  ),
                                  child: Icon(
                                    const IconData(0xe652,
                                        fontFamily: 'iconfont'),
                                    size: 12.w,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                Text(
                                  '下载凡彩推荐后安装到使用手机',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Transform.rotate(
                          angle: -pi / 75,
                          child: Container(
                            height: 26.w,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F8F8),
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.w),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 30.w,
                                  height: 26.w,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(right: 16.w),
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.w),
                                    ),
                                  ),
                                  child: Icon(
                                    const IconData(0xe6ba,
                                        fontFamily: 'iconfont'),
                                    size: 13.w,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                Text(
                                  '打开应用成功登录进行浏览使用',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildWaterMark(String code) {
    return Container(
      width: 280.w,
      height: 220.w,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        children: List.generate(
            3,
            (index) => Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      3,
                      (index) => Transform.rotate(
                        angle: -0.45,
                        child: Text(
                          index % 2 == 0 ? code : '',
                          style: TextStyle(
                            color: Colors.black.withValues(alpha: 0.05),
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'bebas',
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
      ),
    );
  }
}
