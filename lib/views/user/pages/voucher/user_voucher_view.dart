import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/views/user/controller/user_voucher_controller.dart';
import 'package:prize_lottery_app/views/user/model/user_voucher.dart';
import 'package:prize_lottery_app/views/user/widgets/voucher_widget.dart';
import 'package:prize_lottery_app/widgets/empty_widget.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class UserVoucherView extends StatelessWidget {
  ///
  ///
  const UserVoucherView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '代金券',
      right: GestureDetector(
        onTap: () {
          _showVoucherRule();
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.only(right: 4.w),
          child: Text(
            '使用规则',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
      content: Container(
        color: const Color(0xFFF5F5FB),
        child: RefreshWidget<UserVoucherController>(
          header: MaterialHeader(),
          builder: (controller) {
            return CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverToBoxAdapter(
                  child: _buildVoucherAcct(controller.voucherAcct),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: VoucherPersistentHeader(
                    height: 60.w,
                    children: _buildQueryTabBar(controller),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    _buildVoucherContent(controller.records),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildVoucherAcct(UserVoucher acct) {
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.w),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18.w, horizontal: 10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.w),
        ),
        child: Row(
          children: [
            Expanded(
              child: _voucherAcctItem(
                amount: acct.allNum,
                name: '累计领取',
              ),
            ),
            Expanded(
              child: _voucherAcctItem(
                amount: acct.usedNum,
                name: '优惠抵扣',
              ),
            ),
            Expanded(
              child: _voucherAcctItem(
                amount: acct.expiredNum,
                name: '过期作废',
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.voucherDraw);
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 6.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.w),
                    border: Border.all(
                      color: Colors.deepOrangeAccent,
                      width: 0.6.w,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 4.w),
                        child: Image.asset(
                          R.voucherIcon,
                          height: 16.sp,
                        ),
                      ),
                      Text(
                        '领券',
                        style: TextStyle(
                          color: Colors.deepOrange.shade800,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQueryTabBar(UserVoucherController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.w),
      child: Row(
        children: [
          _tabBarItem(
            name: '全部',
            amount: controller.voucherAcct.total,
            selected: controller.all != null,
            onTap: () {
              controller.all = 1;
            },
          ),
          _tabBarItem(
            name: '使用',
            amount: controller.voucherAcct.used,
            selected: controller.used != null,
            onTap: () {
              controller.used = 1;
            },
          ),
          _tabBarItem(
            name: '过期',
            amount: controller.voucherAcct.expired,
            selected: controller.expired != null,
            onTap: () {
              controller.expired = 1;
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _buildVoucherContent(List<UserVoucherLog> records) {
    if (records.isEmpty) {
      return [
        Padding(
          padding: EdgeInsets.only(top: 36.w),
          child: const EmptyView(
            message: '暂无代金券记录',
          ),
        ),
      ];
    }
    List<Widget> views = [];
    for (int i = 0; i < records.length; i++) {
      views.add(VoucherRecordWidget(
        voucher: records[i],
        top: i == 0 ? 0 : 16.w,
      ));
    }
    views.add(SizedBox(height: 32.w));
    return views;
  }

  void _showVoucherRule() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 220.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.w),
                ),
                padding: EdgeInsets.only(bottom: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 16.w, bottom: 10.w),
                      child: Text(
                        '使用规则',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
                      child: Text(
                        '1、代金券作为账户余额的重要组成部分，代金券与账户的金币及奖励金等值。',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 3.w, 16.w, 0),
                      child: Text(
                        '2、消费账户余额而进行扣减操作时，将优先扣减账户领取的代金券抵扣部分账户金币。',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 3.w, 16.w, 0),
                      child: Text(
                        '3、账户领取的代金券存在过期时间，在有效期内可以进行消费抵扣，过期代金券将作废。',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 3.w, 16.w, 0),
                      child: Text(
                        '4、系统不定期会投放代金券，用户可以在【领券中心】单条领取或一键全部领取代金券。',
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

  Widget _voucherAcctItem({
    required int amount,
    required String name,
  }) {
    return Column(
      children: [
        Container(
          height: 30.w,
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$amount',
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.black,
                    fontFamily: 'bebas',
                  ),
                ),
                WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 2.w,
                      bottom: 2.w,
                    ),
                    child: Text(
                      '金币',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _tabBarItem({
    required String name,
    required int amount,
    required bool selected,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.only(right: 12.w),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 12.w),
          transform: Matrix4.skewX(-.2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.w),
          ),
          child: Container(
            transform: Matrix4.skewX(.2),
            child: Text(
              '$name($amount)',
              style: TextStyle(
                fontSize: 13.sp,
                color: selected ? Colors.deepOrange : Colors.black38,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class VoucherPersistentHeader extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget children;

  VoucherPersistentHeader({
    required this.height,
    required this.children,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: height,
      color: const Color(0xFFF5F5FB),
      alignment: Alignment.centerLeft,
      child: children,
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
