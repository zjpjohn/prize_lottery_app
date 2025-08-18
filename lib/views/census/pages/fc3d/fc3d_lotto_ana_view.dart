import 'package:flutter/material.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/census/controller/fc3d/fc3d_lotto_ana_controller.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class Fc3dAnalyzeView extends StatelessWidget {
  ///
  ///
  const Fc3dAnalyzeView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '预警分析',
      content: RequestWidget<Fc3dAnalyzeController>(
        emptyText: '正在研发中，请耐心等待',
        builder: (controller) {
          return Container();
        },
      ),
    );
  }
}
