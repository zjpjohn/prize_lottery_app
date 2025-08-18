import 'package:flutter/material.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/census/controller/pl3/pl3_lotto_ana_controller.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class Pl3AnalyzeView extends StatelessWidget {
  ///
  const Pl3AnalyzeView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '预警分析',
      content: RequestWidget<Pl3AnalyzeController>(
        emptyText: '正在研发中，耐心等待',
        builder: (controller) {
          return Container();
        },
      ),
    );
  }
}
