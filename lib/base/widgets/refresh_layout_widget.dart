import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/base/model/request_state.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/widgets/empty_widget.dart';
import 'package:prize_lottery_app/widgets/error_widget.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:prize_lottery_app/widgets/loading_widget.dart';

typedef HeaderTitleBuilder<T extends AbsPageQueryController> = Widget Function(
    T controller);
typedef HeaderRightBuilder<T extends AbsPageQueryController> = Widget Function(
    T controller);

class RefreshLayoutWidget<Controller extends AbsPageQueryController>
    extends StatelessWidget {
  ///
  ///
  RefreshLayoutWidget({
    super.key,
    this.init,
    this.global = true,
    this.title = '',
    this.header,
    this.footer,
    this.tag,
    this.empty,
    this.background = const Color(0xFFF6F6FB),
    this.showLoading = true,
    this.topBouncing = true,
    this.bottomBouncing = true,
    this.enableRefresh = true,
    this.enableLoad = true,
    this.titleBuilder,
    this.rightBuilder,
    required this.builder,
    this.widgetBuilder,
    this.scrollController,
  }) : assert((title.isEmpty && titleBuilder == null) ||
            (title.isEmpty && titleBuilder != null));

  ///
  ///
  final Controller? init;

  ///
  /// 内容背景颜色
  final Color background;

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
  ///
  final ScrollController? scrollController;

  ///
  /// 分页业务组件构造器
  final PageWidgetBuilder<Controller> builder;

  ///
  /// 非分页业务组件构造器
  final WidgetRequestBuilder<Controller>? widgetBuilder;

  ///
  /// header文字标题
  final String title;

  ///
  /// header标题组件构造器
  final HeaderTitleBuilder<Controller>? titleBuilder;

  ///
  /// header右部组件构造器
  final HeaderRightBuilder<Controller>? rightBuilder;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(
      tag: tag,
      init: init,
      global: global,
      builder: (controller) {
        return LayoutContainer(
          title: title,
          header: titleBuilder != null ? titleBuilder!(controller) : null,
          right: rightBuilder != null ? rightBuilder!(controller) : null,
          content: Container(
            color: background,
            child: _buildContentView(controller),
          ),
        );
      },
    );
  }

  Widget _buildContentView(Controller controller) {
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
            controller.onRefresh();
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
              header: null,
              footer: null,
              onRefresh: null,
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
          child: EasyRefresh(
            topBouncing: topBouncing,
            bottomBouncing: bottomBouncing,

            ///刷新控制器
            controller: controller.refreshController,

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
        ),
      ],
    );
  }
}
