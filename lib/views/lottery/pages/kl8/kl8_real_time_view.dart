import 'package:flutter/material.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/lottery/controller/kl8_real_time_controller.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class Kl8RealTimeView extends StatelessWidget {
  ///
  ///
  const Kl8RealTimeView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '热点分析',
      content: RequestWidget<Kl8RealTimeController>(
        emptyText: '暂未开通，请耐心等待',
        builder: (controller) {
          return Container();
        },
      ),
    );
  }
}
