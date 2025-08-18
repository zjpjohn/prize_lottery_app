import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/store/balance.dart';
import 'package:prize_lottery_app/views/user/controller/user_account_controller.dart';
import 'package:prize_lottery_app/views/user/model/user_balance.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class UserAccountView extends StatefulWidget {
  const UserAccountView({super.key});

  @override
  UserAccountViewState createState() => UserAccountViewState();
}

class UserAccountViewState extends State<UserAccountView> {
  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '我的账户',
      content: Container(
        color: const Color(0xFFF6F6FB),
        child: RequestWidget<UserAccountController>(
          init: UserAccountController(),
          builder: (controller) {
            return Column(
              children: [
                _buildBalancePanel(),
                _buildVoucherPanel(),
                _buildConsumePanel(),
                _buildAboutPanel(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBalancePanel() {
    return Container(
      margin: EdgeInsets.only(left: 12.w, right: 12.w, top: 24.w, bottom: 16.w),
      height: 144.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.w),
        image: const DecorationImage(
          image: AssetImage(R.accountBg),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 16.0,
            offset: const Offset(4.0, 4.0),
            color: Colors.grey.withValues(alpha: 0.25),
          ),
        ],
      ),
      child: GetBuilder<BalanceInstance>(builder: (store) {
        UserBalance? balance = store.balance;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Get.toNamed('/balance/0');
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 2.w),
                      child: Text(
                        '${balance != null ? balance.balance : 0}',
                        style: TextStyle(
                          fontSize: 22.sp,
                          color: Colors.white,
                          fontFamily: 'bebas',
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '奖励金',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white38,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 2.w),
                          child: Icon(
                            const IconData(0xe613, fontFamily: 'iconfont'),
                            size: 12.w,
                            color: Colors.white38,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Get.toNamed('/balance/1');
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 2.w),
                      child: Text(
                        '${balance != null ? balance.surplus : 0}',
                        style: TextStyle(
                          fontSize: 22.sp,
                          color: Colors.white,
                          fontFamily: 'bebas',
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '金币',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white38,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 2.w),
                          child: Icon(
                            const IconData(0xe613, fontFamily: 'iconfont'),
                            size: 12.w,
                            color: Colors.white38,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    if (balance == null) {
                      EasyLoading.showToast('账户无权提现');
                      return;
                    }

                    ///提现校验及跳转提现页面
                    balance.withdrawAction();
                  },
                  child: Container(
                    width: 58.w,
                    height: 32.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.w),
                        bottomLeft: Radius.circular(24.w),
                      ),
                    ),
                    child: Text(
                      '提现',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFFFF4800),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildVoucherPanel() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.w, left: 12.w, right: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Column(
        children: [
          _buildFunctionItem(
            icon: 0xe660,
            title: '代金券',
            handle: () {
              Get.toNamed(AppRoutes.voucher);
            },
          ),
          _buildFunctionItem(
            icon: 0xe600,
            title: '签到积分',
            bordered: false,
            handle: () {
              Get.toNamed(AppRoutes.sign);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildConsumePanel() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.w, left: 12.w, right: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Column(
        children: [
          _buildFunctionItem(
            icon: 0xe633,
            title: '兑换记录',
            handle: () {
              Get.toNamed(AppRoutes.exchange);
            },
          ),
          _buildFunctionItem(
            icon: 0xe72b,
            title: '消费记录',
            handle: () {
              Get.toNamed(AppRoutes.consume);
            },
          ),
          _buildFunctionItem(
            icon: 0xe651,
            title: '提现记录',
            bordered: false,
            handle: () {
              Get.toNamed(AppRoutes.withdraw);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAboutPanel() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.w, left: 12.w, right: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Column(
        children: [
          _buildFunctionItem(
            icon: 0xe641,
            title: '关于账户',
            bordered: false,
            handle: () {
              Get.toNamed(AppRoutes.aboutAcct);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFunctionItem({
    required int icon,
    bool bordered = true,
    required String title,
    required Function handle,
  }) {
    return GestureDetector(
      onTap: () {
        handle();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.w),
          decoration: BoxDecoration(
            border: Border(
              bottom: bordered
                  ? BorderSide(color: Colors.black12, width: 0.18.w)
                  : BorderSide.none,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    IconData(icon, fontFamily: 'iconfont'),
                    size: 24.w,
                    color: const Color(0xFFFd4A68),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12.w),
                    child: Text(
                      title,
                      style: TextStyle(color: Colors.black87, fontSize: 15.w),
                    ),
                  ),
                ],
              ),
              Icon(
                const IconData(0xe613, fontFamily: 'iconfont'),
                size: 12.w,
                color: Colors.black12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
