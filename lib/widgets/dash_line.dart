import 'dart:math';

import 'package:flutter/material.dart';

class VoucherShapeBorder extends ShapeBorder {
  /// 圆半径
  final double radius;

  ///虚线数量
  final int dashCount;

  ///虚线间隔
  final double dashGap;

  ///虚线高度
  final double dash;

  ///虚线颜色
  final Color color;

  const VoucherShapeBorder({
    this.radius = 10,
    this.dashCount = 12,
    this.dashGap = 3,
    this.dash = 1,
    this.color = const Color(0xFFF6F6F6),
  });

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    double width = rect.width, height = rect.height;
    Path path = Path();
    path.addRect(rect);
    path.fillType = PathFillType.evenOdd;

    ///1.绘制顶部右半圆
    path.addArc(
        Rect.fromCenter(
          center: Offset(width - radius - 5, 0),
          width: 2 * radius,
          height: 2 * radius,
        ),
        0,
        pi);

    ///2.绘制底部右半圆
    path.addArc(
        Rect.fromCenter(
          center: Offset(width - radius - 5, height),
          width: 2 * radius,
          height: 2 * radius,
        ),
        pi,
        pi);
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    double width = rect.width, height = rect.height;
    var paint = Paint()
      ..color = color
      ..strokeWidth = dash
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    ///绘制虚线
    _drawDashLine(
      Offset(width - radius - 5, radius),
      Offset(width - radius - 5, height - radius),
      canvas,
      paint,
    );
  }

  ///
  /// 绘制虚线
  void _drawDashLine(Offset start, Offset end, Canvas canvas, Paint paint) {
    double dashHeight = (end.dy - start.dy) / dashCount - dashGap;
    for (int i = 0; i < dashCount; i++) {
      double dy = dashGap / 2 + i * (dashHeight + dashGap);
      Offset offset = start + Offset(0, dy);
      canvas.drawLine(offset, offset + Offset(0, dashHeight), paint);
    }
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    throw UnimplementedError();
  }

  @override
  ShapeBorder scale(double t) => this;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;
}

class VoucherRightShapeBorder extends ShapeBorder {
  ///圆弧个数
  final int count;

  ///圆弧间隔
  final double gap;

  const VoucherRightShapeBorder({this.count = 10, this.gap = 3});

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path path = Path();
    path.addRect(rect);

    ///绘制右部锯齿
    double width = rect.width, height = rect.height;
    double radius = height / (2 * count) - gap;
    for (int i = 0; i < count; i++) {
      double dy = radius + gap + 2 * i * (radius + gap);
      path.addArc(
          Rect.fromCenter(
            center: Offset(width, dy),
            width: 2 * radius,
            height: 2 * radius,
          ),
          pi / 2,
          pi);
    }
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    throw UnimplementedError();
  }

  @override
  ShapeBorder scale(double t) => this;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;
}

class InviteShapeBorder extends ShapeBorder {
  ///
  ///
  final double radius;

  ///虚线宽度
  final int dashCount;

  ///虚线间隔
  final double dashGap;

  ///虚线高度
  final double dash;

  ///虚线颜色
  final Color color;

  const InviteShapeBorder({
    this.radius = 10,
    this.dash = 1,
    this.dashGap = 3,
    this.dashCount = 10,
    this.color = const Color(0xFFF6F6F6),
  });

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    double width = rect.width, height = rect.height;
    Path path = Path();
    path.addRect(rect);

    ///绘制顶部左右半圆以
    ///1.左边的缺口
    path.addArc(
        Rect.fromCenter(
          center: Offset(0, radius + 5),
          width: 2 * radius,
          height: 2 * radius,
        ),
        -pi / 2,
        pi);

    ///2.右边缺口
    path.addArc(
        Rect.fromCenter(
          center: Offset(width, radius + 5),
          width: 2 * radius,
          height: 2 * radius,
        ),
        pi / 2,
        pi);

    ///绘制底部左右半圆
    ///3.左边的缺口
    path.addArc(
        Rect.fromCenter(
          center: Offset(0, height - radius - 5),
          width: 2 * radius,
          height: 2 * radius,
        ),
        -pi / 2,
        pi);

    ///4.右边缺口
    path.addArc(
        Rect.fromCenter(
          center: Offset(width, height - radius - 5),
          width: 2 * radius,
          height: 2 * radius,
        ),
        pi / 2,
        pi);
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    double width = rect.width, height = rect.height;
    var paint = Paint()
      ..color = color
      ..strokeWidth = dash
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    ///顶部虚线
    _drawDashLine(
      Offset(radius, radius + 5),
      Offset(width - radius, radius + 5),
      canvas,
      paint,
    );

    ///底部虚线
    _drawDashLine(
      Offset(radius, height - radius - 5),
      Offset(width - radius, height - radius - 5),
      canvas,
      paint,
    );
  }

  ///
  /// 绘制虚线
  void _drawDashLine(Offset start, Offset end, Canvas canvas, Paint paint) {
    double dashWidth = (end.dx - start.dx) / dashCount - dashGap;
    for (int i = 0; i < dashCount; i++) {
      double dx = dashGap / 2 + i * (dashWidth + dashGap);
      Offset offset = start + Offset(dx, 0);
      canvas.drawLine(offset, offset + Offset(dashWidth, 0), paint);
    }
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    throw UnimplementedError();
  }

  @override
  ShapeBorder scale(double t) {
    return this;
  }
}

class InviteBottomShapeBorder extends ShapeBorder {
  ///圆弧个数
  final int count;

  ///圆弧间隔
  final double gap;

  const InviteBottomShapeBorder({this.count = 10, this.gap = 3});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path path = Path();
    path.addRect(rect);

    ///绘制底部锯齿
    double width = rect.width, height = rect.height;
    double radius = width / (2 * count) - gap;
    for (int i = 0; i < count; i++) {
      double dx = radius + gap + 2 * i * (radius + gap);
      path.addArc(
          Rect.fromCenter(
              center: Offset(dx, height),
              width: 2 * radius,
              height: 2 * radius),
          pi,
          pi);
    }
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    throw UnimplementedError();
  }

  @override
  ShapeBorder scale(double t) {
    return this;
  }
}

class DashShapeBorder extends ShapeBorder {
  final Color color;
  final double dashWidth;
  final double width;

  const DashShapeBorder({
    this.width = 1.0,
    this.dashWidth = 4.0,
    this.color = Colors.white,
  });

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    var width = rect.width, height = rect.height;
    var path = Path();
    path.addRect(rect);

    ///左边的缺口
    path.addArc(
        Rect.fromCenter(
          center: Offset(0, height / 2),
          width: height,
          height: height,
        ),
        -pi / 2,
        pi);

    ///右边缺口
    path.addArc(
        Rect.fromCenter(
          center: Offset(width, height / 2),
          width: height,
          height: height,
        ),
        pi / 2,
        pi);
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    final dashCount = ((rect.width - rect.height) / (2 * dashWidth)).floor();
    Offset start = Offset(rect.height / 2 + dashWidth, rect.height / 2);
    for (int i = 0; i < dashCount; i++) {
      var offset = start + Offset(i * 2 * dashWidth, 0);
      canvas.drawLine(offset, offset + Offset(dashWidth, 0), paint);
    }
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    throw UnimplementedError();
  }

  @override
  ShapeBorder scale(double t) {
    return this;
  }
}

class HoleShapeBorder extends ShapeBorder {
  final Offset offset;
  final double size;

  const HoleShapeBorder(
      {this.offset = const Offset(0.03, 0.1), this.size = 16});

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    var path = Path();
    path.addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(5)));
    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    var path = Path();
    path.addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(6)));
    var w = rect.width;
    var h = rect.height;
    var d = size;

    ///左侧打洞
    var offsetXY = Offset(
        rect.topLeft.dx + offset.dx * w, rect.topLeft.dy + offset.dy * h);
    _getHold(path, 1, d, offsetXY);

    ///右侧打洞
    var rightOffset = Offset(rect.topRight.dx - offset.dx * w - size,
        rect.topRight.dy + offset.dy * h);
    _getHold(path, 1, d, rightOffset);
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  _getHold(Path path, int count, double d, Offset offset) {
    var left = offset.dx;
    var top = offset.dy;
    var right = left + d;
    var bottom = top + d;
    path.addOval(Rect.fromLTRB(left, top, right, bottom));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  ShapeBorder scale(double t) {
    return this;
  }
}
