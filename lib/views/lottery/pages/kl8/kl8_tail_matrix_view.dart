import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/views/lottery/controller/kl8_tail_matrix_controller.dart';
import 'package:prize_lottery_app/views/lottery/widgets/kl8_matrix_view.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class Kl8TailMatrixView extends StatefulWidget {
  const Kl8TailMatrixView({super.key});

  @override
  State<Kl8TailMatrixView> createState() => _Kl8TailMatrixViewState();
}

class _Kl8TailMatrixViewState extends State<Kl8TailMatrixView> {
  ///
  ///
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '快乐8矩阵',
      content: Container(
        color: const Color(0xFFF8F8FB),
        child: RefreshWidget<Kl8TailMatrixController>(
          scrollController: _scrollController,
          topConfig: const ScrollTopConfig(align: TopAlign.right),
          builder: (controller) => ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 8.w),
            itemCount: controller.omits.length,
            itemBuilder: (context, index) =>
                Kl8MatrixView(omit: controller.omits[index]),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
