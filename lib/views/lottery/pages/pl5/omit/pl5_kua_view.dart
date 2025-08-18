import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_kua_omit_controller.dart';
import 'package:prize_lottery_app/views/lottery/pages/fc3d/trend/num3_kua_view.dart';
import 'package:prize_lottery_app/views/lottery/utils/trend_constants.dart';
import 'package:prize_lottery_app/views/lottery/widgets/page_query_widget.dart';

class Pl5KuaView extends StatefulWidget {
  const Pl5KuaView({
    super.key,
    required this.rows,
  });

  final int rows;

  @override
  State<Pl5KuaView> createState() => _Pl5KuaViewState();
}

class _Pl5KuaViewState extends State<Pl5KuaView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Get.put(LotteryKuaOmitController('pl5'));
    return Column(
      children: [
        SizedBox(
          height: widget.rows * trendCellSize + 0.5.w,
          child: RequestWidget<LotteryKuaOmitController>(
            builder: (controller) {
              return KuaOmitView(
                rows: widget.rows,
                lotteries: controller.lotteries,
                census: controller.census,
                omits: controller.omits,
              );
            },
          ),
        ),
        GetBuilder<LotteryKuaOmitController>(
          builder: (controller) {
            return PageQueryWidget(
              page: controller.size,
              toMaster: 'pl3/mul_rank',
              onTap: (size) {
                controller.size = size;
              },
            );
          },
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
