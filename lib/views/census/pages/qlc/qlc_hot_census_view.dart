import 'package:flutter/material.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/census/controller/qlc/qlc_hot_census_controller.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class QlcHotCensusView extends StatelessWidget {
  ///
  ///
  const QlcHotCensusView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '热点分析',
      content: RequestWidget<QlcHotCensusController>(
        emptyText: '正在研发中，请耐心等待',
        builder: (controller) {
          return Container();
        },
      ),
    );
  }
}
