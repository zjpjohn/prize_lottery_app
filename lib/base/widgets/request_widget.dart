import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/base/model/request_state.dart';
import 'package:prize_lottery_app/widgets/empty_widget.dart';
import 'package:prize_lottery_app/widgets/error_widget.dart';
import 'package:prize_lottery_app/widgets/loading_widget.dart';

typedef RequestViewBuilder<T extends AbsRequestController> = Widget Function(
    T controller);

class RequestWidget<Controller extends AbsRequestController>
    extends StatelessWidget {
  const RequestWidget({
    super.key,
    this.tag,
    this.init,
    this.emptyText,
    this.global = true,
    this.duration = 350,
    this.showLoading = true,
    required this.builder,
  });

  final bool global;
  final String? tag;
  final int duration;
  final Controller? init;
  final bool showLoading;
  final String? emptyText;
  final RequestViewBuilder<Controller> builder;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(
        tag: tag,
        init: init,
        global: global,
        dispose: (state) {
          init?.onClose();
        },
        builder: (controller) {
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
                  message: emptyText ?? '暂无数据哟',
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
        });
  }
}
