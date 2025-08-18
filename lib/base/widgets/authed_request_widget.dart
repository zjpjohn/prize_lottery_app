import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/store/user.dart';

class AuthedRequestWidget<Controller extends AbsRequestController>
    extends StatelessWidget {
  ///
  ///
  const AuthedRequestWidget({
    super.key,
    this.tag,
    this.init,
    this.emptyText,
    this.global = true,
    required this.builder,
  });

  final bool global;
  final String? tag;
  final String? emptyText;
  final Controller? init;

  /// 业务数据子组件构造器
  final RequestViewBuilder<Controller> builder;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserStore>(
      builder: (store) {
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
        return RequestWidget<Controller>(
          init: init,
          tag: tag,
          global: global,
          emptyText: emptyText,
          builder: builder,
        );
      },
    );
  }
}
