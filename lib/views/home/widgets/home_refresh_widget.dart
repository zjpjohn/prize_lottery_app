import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/base/model/request_state.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/widgets/top_widget.dart';

class HomeRefreshWidget<Controller extends AbsPageQueryController>
    extends StatelessWidget {
  const HomeRefreshWidget({
    super.key,
    this.init,
    this.global = true,
    this.tag,
    this.header,
    this.footer,
    this.topConfig,
    this.scrollController,
    this.topBouncing = true,
    this.bottomBouncing = true,
    this.enableRefresh = true,
    this.enableLoad = true,
    required this.builder,
    this.headBuilder,
  });

  ///
  ///
  final Controller? init;

  ///
  /// 是否为全局controller:配合init一起使用
  final bool global;

  ///
  ///
  final String? tag;

  ///
  /// 上拉刷新header
  final Header? header;

  ///
  /// 下拉加载footer
  final Footer? footer;

  ///
  /// 是否开启加载更多
  final bool enableLoad;

  ///
  /// 是否允许刷新
  final bool enableRefresh;

  ///
  /// 顶部是否有弹性
  final bool topBouncing;

  ///
  /// 底部是否有弹性
  final bool bottomBouncing;

  ///
  ///
  final ScrollTopConfig? topConfig;

  ///
  /// 滚动控制器
  final ScrollController? scrollController;

  ///
  /// 分页业务数据Widget,必须为ListView
  final PageWidgetBuilder<Controller> builder;

  ///
  /// 非分页数据头部widget
  final WidgetRequestBuilder<Controller>? headBuilder;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(
        init: init,
        tag: tag,
        global: global,
        builder: (controller) {
          if (topConfig != null && scrollController != null) {
            controller.scrollListener(
              scrollController!,
              topConfig!.throttle,
              topConfig!.vertical,
            );
          }
          if (headBuilder != null) {
            return Column(
              children: [
                headBuilder!(controller),
                Expanded(
                  child: refreshView(controller),
                ),
              ],
            );
          }
          return refreshView(controller);
        });
  }

  Widget refreshView(Controller controller) {
    if (controller.state == RequestState.loading ||
        controller.state == RequestState.error) {
      return EasyRefresh(
        topBouncing: false,
        bottomBouncing: false,
        header: null,
        footer: null,
        onRefresh: null,
        onLoad: null,
        scrollController: scrollController,
        child: builder(controller),
      );
    }
    return Stack(
      children: [
        EasyRefresh(
          ///
          controller: controller.refreshController,

          /// 顶部回弹
          topBouncing: topBouncing,

          /// 底部回弹
          bottomBouncing: bottomBouncing,

          ///滚动控制器
          scrollController: scrollController,

          ///默认开启刷新
          header: enableRefresh ? (header ?? DeliveryHeader()) : null,

          ///上拉加载需开启才会起作用(默认开启)
          footer: enableLoad && !controller.loadedAll()
              ? (footer ?? PhoenixFooter())
              : null,

          ///下拉刷新回调
          onRefresh: enableRefresh ? controller.refreshing : null,

          ///上拉加载数据(上拉加载需开启)
          onLoad: enableLoad && !controller.loadedAll()
              ? controller.loadMore
              : null,

          ///业务数据组件
          child: builder(controller),
        ),
        if (topConfig != null && controller.showTop)
          AnimatedPositioned(
            bottom: controller.topOffset,
            left: topConfig!.align == TopAlign.left
                ? topConfig!.horizontal
                : null,
            right: topConfig!.align == TopAlign.right
                ? topConfig!.horizontal
                : null,
            duration: Duration(milliseconds: topConfig!.duration),
            onEnd: () {
              if (controller.topOffset == 0) {
                controller.showTop = false;
              }
            },
            child: GestureDetector(
              onTap: () {
                scrollController!.animateTo(
                  0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear,
                );
              },
              behavior: HitTestBehavior.opaque,
              child: const TopWidget(),
            ),
          )
      ],
    );
  }
}
