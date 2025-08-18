import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabIndicator extends Decoration {
  final double ratio;
  final BorderSide borderSide;
  final EdgeInsetsGeometry insets;

  const CustomTabIndicator({
    this.ratio = 0.5,
    this.borderSide = const BorderSide(width: 2.0, color: Colors.white),
    this.insets = EdgeInsets.zero,
  });

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is CustomTabIndicator) {
      return CustomTabIndicator(
        ratio: ratio,
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is CustomTabIndicator) {
      return CustomTabIndicator(
        ratio: ratio,
        borderSide: BorderSide.lerp(borderSide, a.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(insets, a.insets, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _UnderlinePainter(this, onChanged);
  }
}

class _UnderlinePainter extends BoxPainter {
  _UnderlinePainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  final CustomTabIndicator decoration;

  BorderSide get borderSide => decoration.borderSide;

  EdgeInsetsGeometry get insets => decoration.insets;

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);
    double center = (indicator.left + indicator.right) / 2;
    double width = (indicator.right - indicator.left) * decoration.ratio;
    return Rect.fromLTWH(
      center - width / 2,
      indicator.bottom - borderSide.width,
      width,
      borderSide.width,
    );
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = offset & configuration.size!;
    final TextDirection textDirection = configuration.textDirection!;
    final Rect indicator =
        _indicatorRectFor(rect, textDirection).deflate(borderSide.width / 2.0);
    final Paint paint = borderSide.toPaint()..strokeCap = StrokeCap.round;
    canvas.drawLine(indicator.bottomLeft, indicator.bottomRight, paint);
  }
}

class CustomRRecTabIndicator extends Decoration {
  /// Create an underline style selected tab indicator.
  ///
  /// The [borderSide] and [insets] arguments must not be null.
  const CustomRRecTabIndicator({
    this.borderSide = const BorderSide(width: 2.0, color: Colors.white),
    this.insets = EdgeInsets.zero,
    required this.radius,
    required this.color,
  });

  /// The color and weight of the horizontal line drawn below the selected tab.
  final BorderSide borderSide;

  final double radius;

  final Color color;

  /// Locates the selected tab's underline relative to the tab's boundary.
  ///
  /// The [TabBar.indicatorSize] property can be used to define the
  /// tab indicator's bounds in terms of its (centered) tab widget with
  /// [TabIndicatorSize.label], or the entire tab with [TabIndicatorSize.tab].
  final EdgeInsetsGeometry insets;

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is CustomRRecTabIndicator) {
      return CustomRRecTabIndicator(
        color: a.color,
        radius: a.radius,
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t)!,
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is CustomRRecTabIndicator) {
      return CustomRRecTabIndicator(
        color: b.color,
        radius: b.radius,
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t)!,
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  RadiusIndicatorPainter createBoxPainter([VoidCallback? onChanged]) {
    return RadiusIndicatorPainter(this, onChanged);
  }
}

class RadiusIndicatorPainter extends BoxPainter {
  RadiusIndicatorPainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  final CustomRRecTabIndicator decoration;

  BorderSide get borderSide => decoration.borderSide;

  EdgeInsetsGeometry get insets => decoration.insets;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final RRect rRect =
        RRect.fromRectAndRadius(rect, Radius.circular(decoration.radius));
    canvas.drawRRect(
        rRect,
        Paint()
          ..style = PaintingStyle.fill
          ..color = decoration.color);
  }
}

class ArcUnderlineIndicator extends Decoration {
  final double width;
  final double height;
  final double angle;

  const ArcUnderlineIndicator(
      {required this.width, required this.height, required this.angle});

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is ArcUnderlineIndicator) {
      return ArcUnderlineIndicator(
        width: a.width,
        height: a.height,
        angle: a.angle,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is ArcUnderlineIndicator) {
      return ArcUnderlineIndicator(
        width: b.width,
        height: b.height,
        angle: b.angle,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return ArcUnderlinePainter(onChanged, this);
  }
}

class ArcUnderlinePainter extends BoxPainter {
  final ArcUnderlineIndicator decoration;

  ArcUnderlinePainter(super.onChanged, this.decoration);

  Rect _indicatorRectFor(Rect rect) {
    double width =
        rect.width <= decoration.width ? rect.width : decoration.width;
    double height =
        rect.height <= decoration.height ? rect.height : decoration.height;
    double centerH = (rect.left + rect.right) / 2;
    return Rect.fromLTWH(
      centerH - width / 2,
      rect.bottom - height + 1.w,
      width,
      height,
    );
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = offset & configuration.size!;
    Rect indicator = _indicatorRectFor(rect).deflate(2.6.w);
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.6.w;
    canvas.drawArc(
      indicator,
      0.5 * pi - 0.5 * decoration.angle,
      decoration.angle,
      false,
      paint,
    );
  }
}
