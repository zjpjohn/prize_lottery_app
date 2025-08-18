import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_pl5_omit_controller.dart';
import 'package:prize_lottery_app/views/lottery/utils/trend_constants.dart';
import 'package:prize_lottery_app/views/lottery/widgets/item_omit_widget.dart';
import 'package:prize_lottery_app/views/lottery/widgets/page_query_widget.dart';

class Pl5ItemView extends StatefulWidget {
  const Pl5ItemView({
    super.key,
    required this.type,
    required this.rows,
  });

  final int type;
  final int rows;

  @override
  State<Pl5ItemView> createState() => _Pl5ItemViewState();
}

class _Pl5ItemViewState extends State<Pl5ItemView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Get.put(tag: '${widget.type}', LotteryPl5ItemController(widget.type));
    return SizedBox(
      height: widget.rows * trendCellSize + 0.5.w,
      child: Column(
        children: [
          SizedBox(
            height: widget.rows * trendCellSize,
            child: RequestWidget<LotteryPl5ItemController>(
              tag: '${widget.type}',
              builder: (controller) {
                return ItemOmitView(
                  rows: widget.rows,
                  omits: controller.omits,
                  census: controller.census,
                );
              },
            ),
          ),
          GetBuilder<LotteryPl5ItemController>(
            tag: '${widget.type}',
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
