import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/resources/styles.dart';
import 'package:prize_lottery_app/views/user/controller/draw_voucher_controller.dart';
import 'package:prize_lottery_app/views/user/model/user_voucher.dart';
import 'package:prize_lottery_app/views/user/widgets/voucher_widget.dart';
import 'package:prize_lottery_app/widgets/clipper_views.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/empty_widget.dart';
import 'package:prize_lottery_app/widgets/nav_app_bar.dart';

class DrawVoucherView extends StatelessWidget {
  ///
  ///
  const DrawVoucherView({super.key});

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return AnnotatedRegion(
      value: UiStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFFF1F0F5),
        body: Stack(
          children: [
            ClipPath(
              clipper: SignClipper(),
              child: Container(
                height: 240.w,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xFFFE8C00),
                    Color(0xFFF83600),
                  ]),
                ),
              ),
            ),
            Column(
              children: [
                _buildAppBar(statusBarHeight),
                Expanded(
                  child: RequestWidget<DrawVoucherController>(
                    builder: (controller) {
                      return ScrollConfiguration(
                        behavior: CustomScrollBehavior(),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildHeaderView(),
                              _buildDrawResult(controller),
                              _buildVoucherList(controller),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(double statusBarHeight) {
    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      child: NavAppBar(
        gradients: const [
          Color(0xFFFE8C00),
          Color(0xFFF83600),
        ],
        left: Container(
          width: 32.w,
          height: 32.w,
          alignment: Alignment.centerLeft,
          child: Icon(
            const IconData(0xe669, fontFamily: 'iconfont'),
            size: 18.w,
            color: Colors.white,
          ),
        ),
        center: Text(
          '领券中心',
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderView() {
    return Container(
      padding: EdgeInsets.only(top: 12.w),
      child: Column(
        children: [
          Text(
            '惊喜不断',
            style: TextStyle(
              fontSize: 32.sp,
              color: Colors.white70,
              fontFamily: 'shuhei',
            ),
          ),
          Text(
            '多重奖励等您领',
            style: TextStyle(
              fontSize: 32.sp,
              color: Colors.white70,
              fontFamily: 'shuhei',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawResult(DrawVoucherController controller) {
    return Container(
      height: 80.w,
      padding: EdgeInsets.only(top: 16.w),
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 24.w,
        width: Get.width,
        child: controller.vouchers.isEmpty
            ? const SizedBox.shrink()
            : VoucherBarrage(
                draws: controller.drawList,
                height: 24.w,
                builder: (draw) {
                  return _drawItemView(draw);
                },
              ),
      ),
    );
  }

  Widget _drawItemView(UserDraw draw) {
    return Container(
      height: 24.w,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      margin: EdgeInsets.only(right: 36.w),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(20.w),
      ),
      child: Text(
        '${draw.nameMark()}领取${draw.voucher}金币',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 12.sp,
        ),
      ),
    );
  }

  Widget _buildVoucherList(DrawVoucherController controller) {
    if (controller.vouchers.isEmpty) {
      return Column(
        children: [
          EmptyView(
            message: '暂无代金券奖励',
            callback: () {
              controller.request();
            },
          ),
        ],
      );
    }
    return Column(
      children: [
        ...controller.vouchers.map((e) => DrawVoucherWidget(
              voucher: e,
              onDraw: (voucher) {
                controller.drawVoucher(voucher);
              },
            )),
        _batchDrawButton(controller),
      ],
    );
  }

  Widget _batchDrawButton(DrawVoucherController controller) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24.w),
      child: GestureDetector(
        onTap: () {
          controller.drawBatchVoucher();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 38.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.w),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 4.w),
                child: Icon(
                  const IconData(0xe66b, fontFamily: 'iconfont'),
                  size: 14.sp,
                  color: controller.isCanBatch()
                      ? const Color(0xFF00C2C2)
                      : Colors.black26,
                ),
              ),
              Text(
                '快捷领取',
                style: TextStyle(
                  color: controller.isCanBatch()
                      ? const Color(0xFF00C2C2)
                      : Colors.black26,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
