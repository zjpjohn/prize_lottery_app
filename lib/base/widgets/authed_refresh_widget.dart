import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/base/model/request_state.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/store/user.dart';

class AuthedRefreshWidget<Controller extends AbsPageQueryController>
    extends StatelessWidget {
  ///
  ///
  const AuthedRefreshWidget({
    super.key,
    required this.init,
    this.global = true,
    this.tag,
    this.header,
    this.footer,
    this.empty,
    this.topBouncing = true,
    this.bottomBouncing = true,
    this.enableRefresh = true,
    this.enableLoad = true,
    this.scrollController,
    this.emptyCallback,
    required this.builder,
    this.widgetBuilder,
  });

  ///
  ///
  final Controller init;

  ///
  final bool global;

  ///
  /// 空值描述文字
  final String? empty;

  ///
  ///
  final String? tag;

  ///
  /// 上拉刷新header
  ///
  final Header? header;

  ///
  /// 下拉加载footer
  ///
  final Footer? footer;

  ///
  /// 是否开启加载更多
  ///
  final bool enableLoad;

  ///
  /// 是否允许刷新
  final bool enableRefresh;

  ///
  /// 顶部是否有弹性
  final bool topBouncing;

  /// 底部是否有弹性
  final bool bottomBouncing;

  /// 滚动控制器
  final ScrollController? scrollController;

  ///
  /// 数据为空回调
  final EmptyCallback<Controller>? emptyCallback;

  /// 分页业务数据Widget,必须为ListView
  final PageWidgetBuilder<Controller> builder;

  /// 非分页数据Widget
  final WidgetRequestBuilder<Controller>? widgetBuilder;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserStore>(builder: (store) {
      if (store.authUser == null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              R.unLoginIllus,
              width: 180.w,
              height: 180.w,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.login);
              },
              behavior: HitTestBehavior.opaque,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '登录后查看，',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black26,
                    ),
                  ),
                  Text(
                    '去登录吧',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFFFFAC27),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }
      Controller controller = Get.put<Controller>(init, tag: tag);
      if (controller.state == RequestState.error) {
        controller.onInitial();
      }
      return RefreshWidget<Controller>(
        tag: tag,
        init: init,
        global: global,
        header: header,
        footer: footer,
        empty: empty,
        emptyCallback: emptyCallback,
        topBouncing: topBouncing,
        bottomBouncing: bottomBouncing,
        enableLoad: enableLoad,
        enableRefresh: enableRefresh,
        builder: builder,
        widgetBuilder: widgetBuilder,
        scrollController: scrollController,
      );
    });
  }
}
