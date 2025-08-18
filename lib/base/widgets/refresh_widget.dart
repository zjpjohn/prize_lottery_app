import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/base/model/request_state.dart';
import 'package:prize_lottery_app/widgets/empty_widget.dart';
import 'package:prize_lottery_app/widgets/error_widget.dart';
import 'package:prize_lottery_app/widgets/loading_widget.dart';
import 'package:prize_lottery_app/widgets/top_widget.dart';

enum TopAlign { left, right }

///
/// 指定配置信息
class ScrollTopConfig {
  final double horizontal;
  final double vertical;
  final double throttle;
  final TopAlign align;
  final int duration;

  const ScrollTopConfig({
    this.horizontal = 26.0,
    this.vertical = 64.0,
    this.throttle = 220.0,
    this.duration = 500,
    this.align = TopAlign.left,
  });
}

typedef PageWidgetBuilder<T extends AbsPageQueryController> = Widget Function(
    T controller);

typedef WidgetRequestBuilder<T extends AbsPageQueryController> = Widget
    Function(T controller);

typedef EmptyCallback<T extends AbsPageQueryController> = Function(
    T controller);

class RefreshWidget<Controller extends AbsPageQueryController>
    extends StatelessWidget {
  ///
  ///
  final Controller? init;

  ///
  /// 是否为全局controller:配合init一起使用
  final bool global;

  ///
  /// 上拉刷新header
  final Header? header;

  ///
  /// 下拉加载footer
  final Footer? footer;

  ///
  ///
  final String? tag;

  ///
  ///
  final String? empty;

  ///
  /// 是否显示加载动画
  final bool showLoading;

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
  /// 数据为空回调
  final EmptyCallback<Controller>? emptyCallback;

  ///
  /// 指定配置
  final ScrollTopConfig? topConfig;

  ///
  ///
  final ScrollController? scrollController;

  ///
  /// 分页业务组件构造器
  final PageWidgetBuilder<Controller> builder;

  ///
  /// 非分页业务组件构造器
  final WidgetRequestBuilder<Controller>? widgetBuilder;

  const RefreshWidget({
    super.key,
    this.init,
    this.global = true,
    this.header,
    this.footer,
    this.tag,
    this.empty,
    this.topConfig,
    this.emptyCallback,
    this.showLoading = true,
    this.topBouncing = true,
    this.bottomBouncing = true,
    this.enableRefresh = true,
    this.enableLoad = true,
    required this.builder,
    this.widgetBuilder,
    this.scrollController,
  });

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
          if (controller.state == RequestState.error) {
            return Align(
              alignment: Alignment.center,
              child: ErrorView(
                width: 168.w,
                height: 168.w,
                message: controller.message,
                callback: () {
                  controller.onInitial();
                },
              ),
            );
          }
          if (controller.state == RequestState.empty) {
            return Align(
              alignment: Alignment.center,
              child: EmptyView(
                size: 168.w,
                message: empty ?? '暂无数据哟',
                callback: () {
                  if (emptyCallback != null) {
                    emptyCallback!(controller);
                    return;
                  }
                  controller.onInitial();
                },
              ),
            );
          }
          if (controller.state == RequestState.loading) {
            if (showLoading) {
              return const Align(
                alignment: Alignment.center,
                child: LoadingView(),
              );
            }
            return Column(
              children: [
                ///非分页组件
                if (widgetBuilder != null) widgetBuilder!(controller),
                Expanded(
                  child: EasyRefresh(
                    topBouncing: topBouncing,
                    bottomBouncing: bottomBouncing,
                    controller: controller.refreshController,
                    scrollController: scrollController,
                    header: enableRefresh ? (header ?? DeliveryHeader()) : null,
                    onRefresh: enableRefresh ? controller.refreshing : null,
                    footer: null,
                    onLoad: null,
                    child: builder(controller),
                  ),
                ),
              ],
            );
          }
          return Column(
            children: [
              ///非分页组件
              if (widgetBuilder != null) widgetBuilder!(controller),
              Expanded(
                child: Stack(
                  children: [
                    EasyRefresh(
                      ///顶部回弹
                      topBouncing: topBouncing,

                      ///底部回弹
                      bottomBouncing: bottomBouncing,

                      ///刷新控制器
                      controller: controller.refreshController,

                      ///滚动控制器
                      scrollController: scrollController,

                      ///默认开启刷新
                      header:
                          enableRefresh ? (header ?? DeliveryHeader()) : null,

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
                              duration: const Duration(milliseconds: 50),
                              curve: Curves.linear,
                            );
                          },
                          behavior: HitTestBehavior.opaque,
                          child: const TopWidget(),
                        ),
                      )
                  ],
                ),
              ),
            ],
          );
        });
  }
}
