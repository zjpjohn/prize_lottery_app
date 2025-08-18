import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/base/model/request_state.dart';
import 'package:prize_lottery_app/widgets/empty_widget.dart';
import 'package:prize_lottery_app/widgets/error_widget.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:prize_lottery_app/widgets/loading_widget.dart';

typedef RequestViewBuilder<T extends AbsRequestController> = Widget Function(
    T controller);
typedef HeaderTitleBuilder<T extends AbsRequestController> = Widget Function(
    T controller);
typedef HeaderRightBuilder<T extends AbsRequestController> = Widget Function(
    T controller);

class RequestLayoutWidget<Controller extends AbsRequestController>
    extends StatelessWidget {
  ///
  ///
  RequestLayoutWidget({
    super.key,
    this.tag,
    this.init,
    this.background = const Color(0xFFF6F6FB),
    this.global = true,
    this.showLoading = true,
    this.duration = 250,
    this.empty,
    this.title = '',
    this.titleBuilder,
    this.rightBuilder,
    required this.builder,
  }) : assert((title.isEmpty && titleBuilder == null) ||
            (title.isEmpty && titleBuilder != null));
  final String? empty;
  final String title;
  final Color background;
  final bool global;
  final String? tag;
  final int duration;
  final Controller? init;
  final bool showLoading;
  final RequestViewBuilder<Controller> builder;
  final HeaderTitleBuilder<Controller>? titleBuilder;
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
            child: _buildContent(controller),
          ),
        );
      },
    );
  }

  Widget _buildContent(Controller controller) {
    if (showLoading && controller.state == RequestState.loading) {
      return const Align(
        alignment: Alignment.center,
        child: LoadingView(),
      );
    }
    if (controller.state == RequestState.error) {
      return AnimatedOpacity(
        opacity: controller.opacity,
        duration: Duration(milliseconds: duration),
        child: Align(
          alignment: Alignment.center,
          child: ErrorView(
            width: 168.w,
            height: 168.w,
            message: controller.message,
            callback: () {
              controller.reload();
            },
          ),
        ),
      );
    }
    if (controller.state == RequestState.empty) {
      return AnimatedOpacity(
        opacity: controller.opacity,
        duration: Duration(milliseconds: duration),
        child: Align(
          alignment: Alignment.center,
          child: EmptyView(
            size: 168.w,
            message: empty ?? '暂无数据哟',
            callback: () {
              controller.reload();
            },
          ),
        ),
      );
    }
    return AnimatedOpacity(
      opacity: controller.opacity,
      duration: Duration(milliseconds: duration),
      child: builder(controller),
    );
  }
}
