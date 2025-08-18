import 'package:flutter/material.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/lottery/controller/pl3_real_time_controller.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class Pl3RealTimeView extends StatelessWidget {
  ///
  ///
  const Pl3RealTimeView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '实时热点',
      content: RequestWidget<Pl3RealTimeController>(
        emptyText: '暂未开通，请耐心等待',
        builder: (controller) {
          return Container();
        },
      ),
    );
  }
}
