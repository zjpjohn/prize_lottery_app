import 'package:flutter/material.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/expert/controller/expert_center_controller.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class ExpertCenterView extends StatelessWidget {
  ///
  const ExpertCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '我要预测',
      content: RequestWidget<ExpertCenterController>(
        emptyText: '暂未开通，请耐心等待',
        builder: (controller) {
          return Container();
        },
      ),
    );
  }
}
