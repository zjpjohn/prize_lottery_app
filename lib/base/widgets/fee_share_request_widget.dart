import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:prize_lottery_app/base/controller/fee_request_controller.dart';
import 'package:prize_lottery_app/base/model/request_state.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/resources/styles.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';
import 'package:prize_lottery_app/widgets/empty_widget.dart';
import 'package:prize_lottery_app/widgets/error_widget.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:prize_lottery_app/widgets/loading_widget.dart';

typedef TitleBuilder<T extends AbsFeeRequestController> = String Function(
    T controller);
typedef RequestBuilder<T extends AbsFeeRequestController> = Widget Function(
    T controller);

typedef ShareHandle<T extends AbsFeeRequestController> = Function(T controller);
typedef BattleHandle<T extends AbsFeeRequestController> = Function(
    T controller);
typedef FeatureHandle<T extends AbsFeeRequestController> = Function(
    T controller);

class FeeShareRequestWidget<Controller extends AbsFeeRequestController>
    extends StatelessWidget {
  const FeeShareRequestWidget({
    super.key,
    this.init,
    this.tag,
    this.global = true,
    this.background = const Color(0xFFF6F6FB),
    required this.title,
    required this.adsBg,
    required this.adsTitle,
    required this.adsName,
    required this.builder,
    this.battle,
    this.share,
    this.featureTap,
  });

  final RequestBuilder<Controller> builder;
  final Color background;
  final bool global;
  final String title;
  final String? tag;
  final Controller? init;
  final String adsBg;
  final String adsTitle;
  final String adsName;
  final FeatureHandle<Controller>? featureTap;
  final ShareHandle<Controller>? share;
  final BattleHandle<Controller>? battle;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: UiStyle.dark,
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
                border: false,
                right: _buildHeaderRight(controller),
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

  ///
  /// 分享组件
  Widget? _buildHeaderRight(Controller controller) {
    if (!controller.success) {
      return const SizedBox.shrink();
    }
    return !controller.feeBrowse
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 4.w),
                child: GestureDetector(
                  onTap: () {
                    if (battle != null) {
                      battle!(controller);
                    }
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Stack(
                    children: [
                      Container(
                        width: 32.w,
                        height: 32.w,
                        alignment: Alignment.center,
                        child: ShaderMask(
                          shaderCallback: (bounds) {
                            return const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.black,
                                Color(0xBB000000),
                                Colors.black26,
                              ],
                              tileMode: TileMode.mirror,
                            ).createShader(bounds);
                          },
                          child: Icon(
                            const IconData(
                              0xe78e,
                              fontFamily: 'iconfont',
                            ),
                            size: 20.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 4.w,
                        right: 2.w,
                        child: Container(
                          width: 5.w,
                          height: 5.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF0033),
                            borderRadius: BorderRadius.circular(6.w),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(bottom: 1.5.w),
                child: GestureDetector(
                  onTap: () {
                    if (share != null) {
                      share!(controller);
                    }
                  },
                  behavior: HitTestBehavior.opaque,
                  child: SizedBox(
                    width: 36.w,
                    child: Lottie.asset(R.shareLottie, repeat: true),
                  ),
                ),
              ),
            ],
          )
        : GestureDetector(
            onTap: () {
              if (featureTap != null) {
                featureTap!(controller);
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 34.w,
              height: 32.w,
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 4.w),
              child: Icon(
                const IconData(0xe65e, fontFamily: 'iconfont'),
                size: 18.sp,
                color: Colors.black,
              ),
            ),
          );
  }

  ///
  /// 内容组件
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
    if (controller.feeBrowse) {
      return Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.member);
                },
                behavior: HitTestBehavior.opaque,
                child: CachedAvatar(
                  width: Get.width - 32.w,
                  height: 600.w,
                  radius: 6.w,
                  fit: BoxFit.cover,
                  url: adsBg,
                  color: Colors.white,
                  placeColor: const Color(0xFFFAFAFA),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.w),
                padding: EdgeInsets.symmetric(
                  vertical: 12.w,
                  horizontal: 16.w,
                ),
                child: Text(
                  '您还不是会员，开通会员服务享全场推荐服务',
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
  }
}
