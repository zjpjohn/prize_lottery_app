import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/model/request_state.dart';
import 'package:prize_lottery_app/views/battle/controller/battle_controller.dart';
import 'package:prize_lottery_app/widgets/empty_widget.dart';
import 'package:prize_lottery_app/widgets/error_widget.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:prize_lottery_app/widgets/loading_widget.dart';

typedef BattleViewBuilder<T, Controller extends AbsBattleController<T>> = Widget
    Function(Controller);

class BattleRequestWidget<T, Controller extends AbsBattleController<T>>
    extends StatelessWidget {
  ///
  ///
  const BattleRequestWidget({
    super.key,
    required this.title,
    required this.init,
    required this.rankRoute,
    required this.builder,
    this.emptyText,
    this.duration = 250,
  });

  final String title;
  final String rankRoute;
  final Controller init;
  final String? emptyText;
  final int duration;
  final BattleViewBuilder<T, Controller> builder;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(
      init: init,
      builder: (controller) {
        return LayoutContainer(
          title: title,
          right: _buildHeaderRight(controller),
          content: _buildContent(controller),
        );
      },
    );
  }

  Widget? _buildHeaderRight(Controller controller) {
    if (controller.state == RequestState.error) {
      return null;
    }
    return GestureDetector(
      onTap: () {
        Get.toNamed(rankRoute);
      },
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 2.w),
            child: Icon(
              const IconData(0xe673, fontFamily: 'iconfont'),
              size: 20.sp,
              color: Colors.black87,
            ),
          ),
          Text(
            '添加',
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.black87,
            ),
          ),
        ],
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
          width: 184.w,
          height: 184.w,
          message: controller.errorMsg ?? "加载PK列表出错啦",
          callback: () {
            controller.loadBattles();
          },
        ),
      );
    }
    if (controller.state == RequestState.empty) {
      return Align(
        alignment: Alignment.center,
        child: EmptyView(
          size: 184.w,
          message: emptyText ?? '暂无PK数据哟',
          subtitle: '点击或右上角进入添加专家',
          callback: () {
            Get.toNamed(rankRoute);
          },
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
