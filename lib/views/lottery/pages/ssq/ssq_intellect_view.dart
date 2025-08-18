import 'package:flutter/material.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/lottery/controller/ssq_intellect_controller.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class SsqIntellectView extends StatelessWidget {
  ///
  ///
  const SsqIntellectView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '智能选号',
      content: RequestWidget<SsqIntellectController>(
        emptyText: '暂未开通，请耐心等待',
        builder: (controller) {
          return Container();
        },
      ),
    );
  }
}
