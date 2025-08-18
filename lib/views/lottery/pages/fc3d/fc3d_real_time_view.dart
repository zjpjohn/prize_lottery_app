import 'package:flutter/material.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/lottery/controller/fc3d_real_time_controller.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class Fc3dRealTimeView extends StatelessWidget {
  ///
  ///
  const Fc3dRealTimeView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '实时热点',
      content: RequestWidget<Fc3dRealTimeController>(
        emptyText: '暂未开通，请耐心等待',
        builder: (controller) {
          return Container();
        },
      ),
    );
  }
}
