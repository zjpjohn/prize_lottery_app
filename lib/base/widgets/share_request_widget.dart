import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/base/model/request_state.dart';
import 'package:prize_lottery_app/resources/styles.dart';
import 'package:prize_lottery_app/widgets/empty_widget.dart';
import 'package:prize_lottery_app/widgets/error_widget.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:prize_lottery_app/widgets/loading_widget.dart';

typedef RequestBuilder<T extends AbsRequestController> = Widget Function(
    T controller);
typedef ShareHandle<T extends AbsRequestController> = Function(T controller);

class ShareRequestWidget<Controller extends AbsRequestController>
    extends StatelessWidget {
  const ShareRequestWidget({
    super.key,
    this.init,
    this.tag,
    this.share,
    this.emptyText,
    this.global = true,
    this.style = UiStyle.dark,
    this.background = const Color(0xFFF6F6FB),
    required this.title,
    required this.builder,
  });

  final String? emptyText;
  final bool global;
  final String title;
  final String? tag;
  final Color background;
  final Controller? init;
  final SystemUiOverlayStyle style;
  final ShareHandle<Controller>? share;
  final RequestBuilder<Controller> builder;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: style,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: GetBuilder<Controller>(
            tag: tag,
            init: init,
            global: global,
            builder: (controller) {
              return LayoutWithoutAnnotatedRegion(
                title: title,
                right: controller.state == RequestState.success
                    ? Container(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            if (share != null) {
                              share!(controller);
                            }
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: 46.w,
                            height: 32.w,
                            alignment: Alignment.centerRight,
                            child: Icon(
                              const IconData(0xe64b, fontFamily: 'iconfont'),
                              size: 20.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    : null,
                content: Container(
                  color: background,
                  child: _buildContent(controller),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(Controller controller) {
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
          message: emptyText ?? '暂无数据哟',
          callback: () {
            controller.request();
          },
        ),
      );
    }
    return builder(controller);
  }
}
