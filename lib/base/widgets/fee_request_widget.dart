import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/fee_request_controller.dart';
import 'package:prize_lottery_app/base/model/request_state.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/views/census/widgets/fee_mock_widget.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/empty_widget.dart';
import 'package:prize_lottery_app/widgets/error_widget.dart';
import 'package:prize_lottery_app/widgets/loading_widget.dart';

typedef RequestBuilder<T extends AbsFeeRequestController> = Widget Function(
    T controller);

class FeeRequestWidget<Controller extends AbsFeeRequestController>
    extends StatelessWidget {
  ///
  const FeeRequestWidget({
    super.key,
    this.init,
    this.global = true,
    this.bgImg,
    this.background,
    required this.title,
    required this.adsName,
    required this.builder,
  }) : assert(background != null || bgImg != null);

  ///
  final RequestBuilder<Controller> builder;

  final bool global;
  final Controller? init;
  final String? bgImg;
  final Widget? background;
  final String title;
  final String adsName;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(
        init: init,
        global: global,
        builder: (controller) {
          if (controller.state == RequestState.loading) {
            return const Align(
              alignment: Alignment.center,
              child: LoadingView(),
            );
          }
          if (controller.state == RequestState.error) {
            return Align(
              alignment: Alignment.center,
              child: ErrorView(
                message: controller.message,
                callback: () {
                  controller.request();
                },
              ),
            );
          }
          if (controller.feeBrowse) {
            Widget bgWidget;
            if (background != null) {
              bgWidget = background!;
            } else {
              bgWidget = CachedAvatar(
                width: MediaQuery.of(context).size.width - 32.w,
                height: 600.w,
                radius: 6.w,
                fit: BoxFit.cover,
                url: bgImg!,
                color: Colors.white,
                placeColor: const Color(0xFFFAFAFA),
              );
            }
            return Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    bgWidget,
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.w,
                        horizontal: 16.w,
                      ),
                      child: Text(
                        '账户余额不足，看激励视频广告获取奖励金！查看需消耗${controller.expend.expend}奖励金'
                        '+金币本次对多抵扣${controller.expend.bounty}奖励金。',
                        style: TextStyle(
                          color: Colors.brown.withValues(alpha: 0.75),
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (controller.state == RequestState.empty) {
            return Align(
              alignment: Alignment.center,
              child: EmptyView(
                message: '暂无数据哟',
                callback: () {
                  controller.request();
                },
              ),
            );
          }
          return builder(controller);
        });
  }
}

class FeeCensusRequestWidget<Controller extends AbsFeeRequestController>
    extends StatelessWidget {
  const FeeCensusRequestWidget({
    super.key,
    this.init,
    this.global = true,
    required this.title,
    required this.adsName,
    required this.header,
    required this.description,
    required this.content,
    required this.notice,
  });

  final bool global;
  final Controller? init;
  final String title;
  final String adsName;
  final RequestBuilder<Controller> header;
  final RequestBuilder<Controller> description;
  final RequestBuilder<Controller> content;
  final RequestBuilder<Controller> notice;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(builder: (controller) {
      if (controller.state == RequestState.loading) {
        return const Align(
          alignment: Alignment.center,
          child: LoadingView(),
        );
      }
      if (controller.state == RequestState.error) {
        return Align(
          alignment: Alignment.center,
          child: ErrorView(
            message: controller.message,
            callback: () {
              controller.request();
            },
          ),
        );
      }
      if (controller.state == RequestState.empty) {
        return Align(
          alignment: Alignment.center,
          child: EmptyView(
            message: '暂无趋势统计数据',
            callback: () {
              controller.request();
            },
          ),
        );
      }
      return ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              header(controller),
              description(controller),
              controller.feeBrowse
                  ? _buildFeedHintWidget(controller)
                  : content(controller),
              notice(controller),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildFeedHintWidget(Controller controller) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.member);
      },
      behavior: HitTestBehavior.opaque,
      child: const FeeMockWidget(),
    );
  }
}
