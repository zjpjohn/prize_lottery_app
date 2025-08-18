import 'package:flutter/material.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/census/controller/dlt/dlt_lotto_ana_controller.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class DltLottoAnaView extends StatelessWidget {
  ///
  const DltLottoAnaView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '预警分析',
      content: RequestWidget<DltAnalyzeController>(
        emptyText: '暂未开通，请耐心等待',
        builder: (controller) {
          return Container();
        },
      ),
    );
  }
}
