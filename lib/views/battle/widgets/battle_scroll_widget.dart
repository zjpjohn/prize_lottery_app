import 'package:flutter/material.dart';
import 'package:prize_lottery_app/views/battle/model/master_battle.dart';
import 'package:prize_lottery_app/views/lottery/model/slide_direction.dart';

typedef BattleSizeHandle = int Function();
typedef BattleDingHandle<T> = MasterBattle<T>? Function();

class BattleScrollWidget<T> extends StatelessWidget {
  ///
  BattleScrollWidget({
    super.key,
    required this.child,
    required this.leftWidth,
    required this.headerHeight,
    required this.battleSize,
    required this.battleDing,
    required this.topController,
    required this.dingController,
    required this.leftController,
    required this.bodyHController,
    required this.bodyVController,
    required this.bottomController,
  });

  ///左侧宽度
  final double leftWidth;

  ///顶部高度
  final double headerHeight;

  ///
  final BattleSizeHandle battleSize;

  ///
  final BattleDingHandle<T> battleDing;

  ///顶部左右滑动
  final ScrollController topController;

  ///钉在上侧的滑动
  final ScrollController dingController;

  ///左侧上下滑动
  final ScrollController leftController;

  ///body区域滑动(左右)
  final ScrollController bodyHController;

  ///body区域滑动(上下)
  final ScrollController bodyVController;

  ///底部左右滑动
  final ScrollController bottomController;

  ///组件
  final Widget child;

  ///滑动方向
  late SlideDirection _direction;

  ///上一次结束时滑动的位置
  late Offset _last;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: handleStart,
      onPanEnd: handleEnd,
      onPanUpdate: handleUpdate,
      child: child,
    );
  }

  void handleStart(DragStartDetails details) {
    _last = details.localPosition;
  }

  void handleEnd(DragEndDetails details) {}

  void handleUpdate(DragUpdateDetails details) {
    double dx = details.localPosition.dx;
    double dy = details.localPosition.dy;
    double distanceX = (dx - _last.dx).abs();
    double distanceY = (dy - _last.dy).abs();
    if (dx < leftWidth) {
      _direction = dy - _last.dy > 0 ? SlideDirection.down : SlideDirection.up;
    } else if (dy < headerHeight) {
      _direction =
          dx - _last.dx > 0 ? SlideDirection.right : SlideDirection.left;
    } else if (distanceX >= distanceY) {
      _direction =
          dx - _last.dx > 0 ? SlideDirection.right : SlideDirection.left;
    } else {
      _direction = dy - _last.dy > 0 ? SlideDirection.down : SlideDirection.up;
    }

    switch (_direction) {
      case SlideDirection.left:
        if (topController.offset < topController.position.maxScrollExtent) {
          bodyHController.jumpTo(topController.offset + distanceX);
          topController.jumpTo(topController.offset + distanceX);
          if (battleSize() >= 6) {
            bottomController.jumpTo(topController.offset + distanceX);
          }
          if (battleDing() != null) {
            dingController.jumpTo(topController.offset + distanceX);
          }
        }
        break;
      case SlideDirection.right:
        if (topController.offset > topController.position.minScrollExtent) {
          bodyHController.jumpTo(topController.offset - distanceX);
          topController.jumpTo(topController.offset - distanceX);
          if (battleSize() >= 6) {
            bottomController.jumpTo(topController.offset - distanceX);
          }
          if (battleDing() != null) {
            dingController.jumpTo(topController.offset - distanceX);
          }
        }
        break;
      case SlideDirection.up:
        if (leftController.offset < leftController.position.maxScrollExtent) {
          bodyVController.jumpTo(leftController.offset + distanceY);
          leftController.jumpTo(leftController.offset + distanceY);
        }
        break;
      case SlideDirection.down:
        if (leftController.offset > leftController.position.minScrollExtent) {
          bodyVController.jumpTo(leftController.offset - distanceY);
          leftController.jumpTo(leftController.offset - distanceY);
        }
        break;
      case SlideDirection.all:
        break;
    }
    _last = details.localPosition;
  }
}
