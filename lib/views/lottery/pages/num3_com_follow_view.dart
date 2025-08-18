import 'package:flutter/material.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/lottery/controller/num3_com_follow_controller.dart';
import 'package:prize_lottery_app/views/lottery/widgets/follow_widget.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class Num3ComFollowView extends StatelessWidget {
  const Num3ComFollowView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '历史跟随',
      border: false,
      content: Container(
        color: Colors.white,
        child: RequestWidget<Num3ComFollowController>(
          builder: (controller) {
            return ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: SingleChildScrollView(
                child: FollowWidget(follows: controller.data),
              ),
            );
          },
        ),
      ),
    );
  }
}
