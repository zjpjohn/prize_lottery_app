import 'dart:math';

import 'package:flutter/material.dart';

/// 贝塞尔曲线的各个点
class BezierCurveSection {
  /// 贝塞尔曲线起点
  Offset start;

  /// 贝塞尔曲线顶部
  Offset top;

  /// 贝塞尔曲线终点
  Offset end;

  /// 贝塞尔曲线顶点所在比例
  double proportion;

  BezierCurveSection({
    required this.start,
    required this.top,
    required this.end,
    this.proportion = 1 / 2,
  })  : assert(proportion > 0),
        assert(proportion < 1);
}

/// 三阶贝塞尔曲线的点集合
class ThirdOrderBezierCurveSection {
  /// 起始点
  Offset p1;

  /// 第二点
  Offset p2;

  /// 第三点
  Offset p3;

  /// 第四点
  Offset p4;

  /// 平滑度 0~1数值越大越平直 数值越小弧线越大
  double smooth;

  ThirdOrderBezierCurveSection({
    required this.p1,
    required this.p2,
    required this.p3,
    required this.p4,
    this.smooth = .5,
  })  : assert(smooth >= 0),
        assert(smooth <= 1);
}

/// 贝塞尔曲线的画线位置
class BezierCurveDots {
  /// 第一个点的x坐标
  double x1;

  /// 第一个点的y坐标
  double y1;

  /// 第二个点的x坐标
  double x2;

  /// 第二个点的y坐标
  double y2;

  BezierCurveDots(
    this.x1,
    this.y1,
    this.x2,
    this.y2,
  );

  /// 返回数组对象
  List<double> getList() {
    return [x1, y1, x2, y2];
  }

  Map<String, double> getMap() {
    return {
      'x1': x1,
      'y1': y1,
      'x2': x2,
      'y2': y2,
    };
  }
}

/// 三阶贝塞尔的画线位置
class ThirdOrderBezierCurveDots {
  /// 第一个点的x坐标
  double x1;

  /// 第一个点的y坐标
  double y1;

  /// 第二个点的x坐标
  double x2;

  /// 第二个点的y坐标
  double y2;

  /// 第三个点的x坐标
  double x3;

  /// 第三个点的y坐标
  double y3;

  ThirdOrderBezierCurveDots(
    this.x1,
    this.y1,
    this.x2,
    this.y2,
    this.x3,
    this.y3,
  );

  List<double> getList() {
    return [x1, y1, x2, y2, x3, y3];
  }

  Map<String, double> getMap() {
    return {
      'x1': x1,
      'y1': y1,
      'x2': x2,
      'y2': y2,
      'x3': x3,
      'y3': y3,
    };
  }
}

/// 确定贝塞尔曲线位置
enum ClipPosition {
  /// 绘制在元素左侧
  left,

  /// 绘制在元素底部
  bottom,

  /// 绘制在元素右侧
  right,

  /// 绘制在元素顶部
  top,
}

/// 创建并返回贝塞尔曲线切割路径
class BezierCurveClipper extends CustomClipper<Path> {
  /// 是否重绘clip对象
  bool reclip;

  /// 绘制贝塞尔曲线数据
  List<BezierCurveSection> list;

  /// 贝塞尔曲线绘制位置
  ClipPosition position;

  BezierCurveClipper({
    required this.list,
    this.reclip = true,
    this.position = ClipPosition.left,
  }) : assert(list.isNotEmpty);

  /// 计算贝塞尔曲线的画点数据
  static BezierCurveDots calcCurveDots(BezierCurveSection param) {
    double x = (param.top.dx -
            (param.start.dx * pow((1 - param.proportion), 2) +
                pow(param.proportion, 2) * param.end.dx)) /
        (2 * param.proportion * (1 - param.proportion));
    double y = (param.top.dy -
            (param.start.dy * pow((1 - param.proportion), 2) +
                pow(param.proportion, 2) * param.end.dy)) /
        (2 * param.proportion * (1 - param.proportion));

    return BezierCurveDots(x, y, param.end.dx, param.end.dy);
  }

  /// 遍历绘画贝塞尔曲线
  void _eachPath(List<BezierCurveSection> list, Path path) {
    for (var element in list) {
      BezierCurveDots item = calcCurveDots(element);
      path.quadraticBezierTo(item.x1, item.y1, item.x2, item.y2);
    }
  }

  /// 获取贝塞尔曲线路径
  @override
  Path getClip(Size size) {
    Path path = Path();
    double firstStartX = list[0].start.dx;
    double firstStartY = list[0].start.dy;

    if (position == ClipPosition.left) {
      path.lineTo(max(0, firstStartX), 0);
      _eachPath(list, path);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
      path.lineTo(max(0, firstStartX), 0);
    } else {
      path.lineTo(0, 0);
      path.lineTo(
        0,
        position == ClipPosition.bottom
            ? min(size.height, firstStartY)
            : size.height,
      );
    }

    if (position == ClipPosition.bottom) {
      _eachPath(list, path);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
    } else {
      path.lineTo(
        position == ClipPosition.right
            ? min(size.width, firstStartX)
            : size.width,
        size.height,
      );
    }

    if (position == ClipPosition.right) {
      _eachPath(list, path);
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
    } else {
      path.lineTo(
          size.width, position == ClipPosition.top ? max(0, firstStartY) : 0);
    }

    if (position == ClipPosition.top) {
      _eachPath(list, path);
      path.lineTo(0, 0);
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => reclip;
}

/// 创建并返回三阶贝塞尔曲线切割路径
class ProsteThirdOrderBezierCurve extends CustomClipper<Path> {
  /// 是否重绘clip对象
  bool reclip;

  /// 绘制贝塞尔曲线数据
  List<ThirdOrderBezierCurveSection> list;

  /// 贝塞尔曲线绘制位置
  ClipPosition position;

  ProsteThirdOrderBezierCurve({
    required this.list,
    this.position = ClipPosition.left,
    this.reclip = true,
  }) : assert(list.isNotEmpty);

  /// 计算三阶贝塞尔曲线的画点数据
  static ThirdOrderBezierCurveDots calcCurveDots(
      ThirdOrderBezierCurveSection param) {
    double x0 = param.p1.dx,
        y0 = param.p1.dy,
        x1 = param.p2.dx,
        y1 = param.p2.dy,
        x2 = param.p3.dx,
        y2 = param.p3.dy,
        x3 = param.p4.dx,
        y3 = param.p4.dy;

    double xc1 = (x0 + x1) / 2.0;
    double yc1 = (y0 + y1) / 2.0;
    double xc2 = (x1 + x2) / 2.0;
    double yc2 = (y1 + y2) / 2.0;
    double xc3 = (x2 + x3) / 2.0;
    double yc3 = (y2 + y3) / 2.0;

    double len1 = sqrt((x1 - x0) * (x1 - x0) + (y1 - y0) * (y1 - y0));
    double len2 = sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
    double len3 = sqrt((x3 - x2) * (x3 - x2) + (y3 - y2) * (y3 - y2));

    double k1 = len1 / (len1 + len2);
    double k2 = len2 / (len2 + len3);

    double xm1 = xc1 + (xc2 - xc1) * k1;
    double ym1 = yc1 + (yc2 - yc1) * k1;
    double xm2 = xc2 + (xc3 - xc2) * k2;
    double ym2 = yc2 + (yc3 - yc2) * k2;

    double resultX1 = xm1 + (xc2 - xm1) * param.smooth + x1 - xm1;
    double resultY1 = ym1 + (yc2 - ym1) * param.smooth + y1 - ym1;
    double resultX2 = xm2 + (xc2 - xm2) * param.smooth + x2 - xm2;
    double resultY2 = ym2 + (yc2 - ym2) * param.smooth + y2 - ym2;

    return ThirdOrderBezierCurveDots(
        resultX1, resultY1, resultX2, resultY2, param.p4.dx, param.p4.dy);
  }

  /// 遍历绘制曲线
  void _eachPath(List<ThirdOrderBezierCurveSection> list, Path path) {
    for (var element in list) {
      ThirdOrderBezierCurveDots item = calcCurveDots(element);
      path.cubicTo(item.x1, item.y1, item.x2, item.y2, item.x3, item.y3);
    }
  }

  /// 获取三阶贝塞尔曲线路径
  @override
  Path getClip(Size size) {
    Path path = Path();

    double firstStartX = list[0].p1.dx;
    double firstStartY = list[0].p1.dy;

    if (position == ClipPosition.left) {
      path.lineTo(max(0, firstStartX), 0);
      _eachPath(list, path);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
      path.lineTo(max(0, firstStartX), 0);
    } else {
      path.lineTo(0, 0);
      path.lineTo(
        0,
        position == ClipPosition.bottom
            ? min(size.height, firstStartY)
            : size.height,
      );
    }

    if (position == ClipPosition.bottom) {
      _eachPath(list, path);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
    } else {
      path.lineTo(
        position == ClipPosition.right
            ? min(size.width, firstStartX)
            : size.width,
        size.height,
      );
    }

    if (position == ClipPosition.right) {
      _eachPath(list, path);
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
    } else {
      path.lineTo(
          size.width, position == ClipPosition.top ? max(0, firstStartY) : 0);
    }

    if (position == ClipPosition.top) {
      _eachPath(list, path);
      path.lineTo(0, 0);
    }

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => reclip;
}
