import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_pian_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_omit.dart';
import 'package:prize_lottery_app/views/lottery/utils/trend_constants.dart';

class RectanglePosition {
  final int row;
  final int col;
  final double width;
  final double height;

  RectanglePosition({
    required this.row,
    required this.col,
    required this.width,
    required this.height,
  });

  Offset leftCenter() {
    return Offset(col * width + trendLeftWidth, (row + 0.5) * height);
  }

  Offset rightCenter() {
    return Offset((col + 1) * width + trendLeftWidth, (row + 0.5) * height);
  }
}

void matchPosition(
    int delta, int row, Omit omit, List<RectanglePosition> positions) {
  List<OmitValue> values = omit.values;
  for (int i = 0; i < values.length; i++) {
    OmitValue value = values[i];
    if (value.value == 0) {
      positions.add(RectanglePosition(
        row: row,
        col: delta + i,
        width: trendCellSize,
        height: trendCellSize,
      ));
    }
  }
}

void matchShapePosition(
    int delta, int row, Omit omit, List<RectanglePosition> positions) {
  List<OmitValue> values = omit.values;
  for (int i = 0; i < values.length; i++) {
    OmitValue value = values[i];
    if (value.value == 0) {
      positions.add(RectanglePosition(
        row: row,
        col: delta + i,
        width: shapeCellWidth,
        height: trendCellSize,
      ));
    }
  }
}

Map<int, List<RectanglePosition>> buildSumPositions(List<SumOmit> omits) {
  Map<int, List<RectanglePosition>> positions = {};
  List<RectanglePosition> base = [];
  List<RectanglePosition> tail = [];
  List<RectanglePosition> tailAmp = [];
  for (int i = 0; i < omits.length; i++) {
    SumOmit omit = omits[i];
    matchPosition(0, i, omit.baseOmit, base);
    matchPosition(28, i, omit.tailOmit, tail);
    matchPosition(38, i, omit.tailAmp, tailAmp);
  }
  positions[1] = base;
  positions[2] = tail;
  positions[3] = tailAmp;
  return positions;
}

Map<int, List<RectanglePosition>> buildTrendPositions(List<TrendOmit> omits) {
  Map<int, List<RectanglePosition>> positions = {};
  List<RectanglePosition> form = [];
  List<RectanglePosition> ott = [];
  List<RectanglePosition> mode = [];
  List<RectanglePosition> bs = [];
  List<RectanglePosition> oe = [];
  for (int i = 0; i < omits.length; i++) {
    TrendOmit omit = omits[i];
    matchShapePosition(0, i, omit.formOmit, form);
    matchShapePosition(5, i, omit.ottOmit, ott);
    matchShapePosition(12, i, omit.modeOmit, mode);
    matchShapePosition(17, i, omit.bsOmit, bs);
    matchShapePosition(21, i, omit.oeOmit, oe);
  }
  positions[1] = form;
  positions[2] = ott;
  positions[3] = mode;
  positions[4] = bs;
  positions[5] = oe;
  return positions;
}

Map<int, List<RectanglePosition>> buildItemPositions(List<CbItemOmit> omits) {
  Map<int, List<RectanglePosition>> positions = {};
  List<RectanglePosition> base = [];
  List<RectanglePosition> amp = [];
  List<RectanglePosition> aod = [];
  for (int i = 0; i < omits.length; i++) {
    CbItemOmit omit = omits[i];
    matchPosition(0, i, omit.cb, base);
    matchPosition(10, i, omit.cbAmp, amp);
    matchPosition(21, i, omit.cbAod, aod);
  }
  positions[1] = base;
  positions[2] = amp;
  positions[3] = aod;
  return positions;
}

Map<int, List<RectanglePosition>> buildKuaPositions(List<KuaOmit> omits) {
  Map<int, List<RectanglePosition>> positions = {};
  List<RectanglePosition> base = [];
  List<RectanglePosition> amp = [];
  List<RectanglePosition> ampAmp = [];
  for (int i = 0; i < omits.length; i++) {
    KuaOmit omit = omits[i];
    matchPosition(0, i, omit.baseOmit, base);
    matchPosition(10, i, omit.ampOmit, amp);
    matchPosition(20, i, omit.ampAmp, ampAmp);
  }
  positions[1] = base;
  positions[2] = amp;
  positions[3] = ampAmp;
  return positions;
}

class PianPosition {
  final int row;
  final int col;
  final int value;

  PianPosition({
    required this.row,
    required this.col,
    required this.value,
  });

  Map<String, dynamic> toJson() {
    return {'row': row, 'col': col, 'value': value};
  }

  Offset topCenter() {
    return Offset(
      (col + 0.5) * trendCellSize + trendLeftWidth,
      row * trendCellSize + 4.h,
    );
  }

  Offset leftCenter() {
    return Offset(
      col * trendCellSize + 4.h + trendLeftWidth,
      (row + 0.5) * trendCellSize,
    );
  }

  Offset rightCenter() {
    return Offset(
      (col + 1) * trendCellSize - 4.h + trendLeftWidth,
      (row + 0.5) * trendCellSize,
    );
  }

  Offset bottomCenter() {
    return Offset(
      (col + 0.5) * trendCellSize + trendLeftWidth,
      (row + 1) * trendCellSize - 4.h,
    );
  }

  Offset topLeft() {
    return Offset(
      (col + 0.5) * trendCellSize - cellRadius * sin(pi / 4) + trendLeftWidth,
      (row + 0.5) * trendCellSize - cellRadius * sin(pi / 4),
    );
  }

  Offset topRight() {
    return Offset(
      (col + 0.5) * trendCellSize + cellRadius * sin(pi / 4) + trendLeftWidth,
      (row + 0.5) * trendCellSize - cellRadius * sin(pi / 4),
    );
  }

  Offset bottomLeft() {
    return Offset(
      (col + 0.5) * trendCellSize - cellRadius * sin(pi / 4) + trendLeftWidth,
      (row + 0.5) * trendCellSize + cellRadius * sin(pi / 4),
    );
  }

  Offset bottomRight() {
    return Offset(
      (col + 0.5) * trendCellSize + cellRadius * sin(pi / 4) + trendLeftWidth,
      (row + 0.5) * trendCellSize + cellRadius * sin(pi / 4),
    );
  }
}

class OmitPosition {
  final int row;
  final int col;
  final int value;

  OmitPosition({
    required this.row,
    required this.col,
    required this.value,
  });

  Offset topCenter() {
    return Offset((col + 0.5) * trendCellSize, row * trendCellSize + 4.h);
  }

  Offset leftCenter() {
    return Offset(col * trendCellSize + 4.h, (row + 0.5) * trendCellSize);
  }

  Offset rightCenter() {
    return Offset((col + 1) * trendCellSize - 4.h, (row + 0.5) * trendCellSize);
  }

  Offset bottomCenter() {
    return Offset((col + 0.5) * trendCellSize, (row + 1) * trendCellSize - 4.h);
  }

  Offset topLeft() {
    return Offset((col + 0.5) * trendCellSize - cellRadius * sin(pi / 4),
        (row + 0.5) * trendCellSize - cellRadius * sin(pi / 4));
  }

  Offset topRight() {
    return Offset((col + 0.5) * trendCellSize + cellRadius * sin(pi / 4),
        (row + 0.5) * trendCellSize - cellRadius * sin(pi / 4));
  }

  Offset bottomLeft() {
    return Offset((col + 0.5) * trendCellSize - cellRadius * sin(pi / 4),
        (row + 0.5) * trendCellSize + cellRadius * sin(pi / 4));
  }

  Offset bottomRight() {
    return Offset((col + 0.5) * trendCellSize + cellRadius * sin(pi / 4),
        (row + 0.5) * trendCellSize + cellRadius * sin(pi / 4));
  }
}

Map<int, List<RectanglePosition>> buildPl5SumPositions(List<SumOmit> omits) {
  Map<int, List<RectanglePosition>> positions = {};
  List<RectanglePosition> base = [];
  List<RectanglePosition> tail = [];
  List<RectanglePosition> tailAmp = [];
  for (int i = 0; i < omits.length; i++) {
    SumOmit omit = omits[i];
    matchPosition(0, i, omit.baseOmit, base);
    matchPosition(33, i, omit.tailOmit, tail);
    matchPosition(43, i, omit.tailAmp, tailAmp);
  }
  positions[1] = base;
  positions[2] = tail;
  positions[3] = tailAmp;
  return positions;
}

Map<int, List<OmitPosition>> buildPl5Positions(List<LotteryOmit> omits) {
  Map<int, List<OmitPosition>> omitMap = {};
  List<OmitPosition> cb1 = [];
  List<OmitPosition> cb2 = [];
  List<OmitPosition> cb3 = [];
  List<OmitPosition> cb4 = [];
  List<OmitPosition> cb5 = [];
  for (int row = 0; row < omits.length; row++) {
    LotteryOmit omit = omits[row];
    parseValue(10, row, omit.cb1, cb1);
    parseValue(20, row, omit.cb2, cb2);
    parseValue(30, row, omit.cb3, cb3);
    parseValue(40, row, omit.cb4, cb4);
    parseValue(50, row, omit.cb5, cb5);
  }
  omitMap[1] = cb1;
  omitMap[2] = cb2;
  omitMap[3] = cb3;
  omitMap[4] = cb4;
  omitMap[5] = cb5;
  return omitMap;
}

Map<int, List<OmitPosition>> buildPositions(List<LotteryOmit> omits) {
  Map<int, List<OmitPosition>> omitMap = {};
  List<OmitPosition> bai = [];
  List<OmitPosition> shi = [];
  List<OmitPosition> ge = [];
  for (int row = 0; row < omits.length; row++) {
    LotteryOmit omit = omits[row];
    parseValue(13, row, omit.cb1, bai);
    parseValue(23, row, omit.cb2, shi);
    parseValue(33, row, omit.cb3, ge);
  }
  omitMap[1] = bai;
  omitMap[2] = shi;
  omitMap[3] = ge;
  return omitMap;
}

void parsePianValue(
    int delta, int row, Omit? omit, List<PianPosition> positions) {
  if (omit == null) {
    return;
  }
  List<OmitValue> values = omit.values;
  for (int i = 0; i < values.length; i++) {
    OmitValue value = values[i];
    if (value.value == 0) {
      positions.add(PianPosition(
        row: row,
        col: delta + i,
        value: int.parse(value.key),
      ));
    }
  }
}

void parseValue(int delta, int row, Omit? omit, List<OmitPosition> positions) {
  if (omit != null) {
    List<OmitValue> values = omit.values;
    for (int i = 0; i < values.length; i++) {
      OmitValue value = values[i];
      if (value.value == 0) {
        positions.add(OmitPosition(
          row: row,
          col: delta + i,
          value: int.parse(value.key),
        ));
      }
    }
  }
}

Map<int, List<PianPosition>> buildPianPosition(List<PianValue> omits) {
  Map<int, List<PianPosition>> positions = {};
  Iterable<int> keys = omits[0].omits.keys;
  for (var key in keys) {
    positions[key] = [];
  }
  for (int i = 0; i < omits.length; i++) {
    PianValue omit = omits[i];
    for (var j in keys) {
      Omit value = omit.omits[j]!;
      parsePianValue(j * 10, i, value, positions[j]!);
    }
  }
  return positions;
}

class PianDrawLinePainter extends CustomPainter {
  ///
  late Map<int, List<PianPosition>> positions;

  PianDrawLinePainter(List<PianValue> omits) {
    positions = buildPianPosition(omits);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (positions.isEmpty) {
      return;
    }
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..color = redFont
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.5.w;
    positions.forEach((i, v) => drawPositions(positions[i]!, canvas, paint));
  }

  void drawPositions(List<PianPosition> positions, Canvas canvas, Paint paint) {
    if (positions.isEmpty || positions.length == 1) {
      return;
    }
    for (int i = 1; i < positions.length; i++) {
      linePosition(positions[i - 1], positions[i], canvas, paint);
    }
  }

  void linePosition(
      PianPosition start, PianPosition end, Canvas canvas, Paint paint) {
    if (start.col == end.col) {
      canvas.drawLine(start.bottomCenter(), end.topCenter(), paint);
      return;
    }
    if (start.col < end.col) {
      if (end.col - start.col <= 2) {
        canvas.drawLine(start.bottomRight(), end.topLeft(), paint);
      } else {
        canvas.drawLine(start.rightCenter(), end.leftCenter(), paint);
      }
      return;
    }
    if (start.col > end.col) {
      if (start.col - end.col <= 2) {
        canvas.drawLine(start.bottomLeft(), end.topRight(), paint);
      } else {
        canvas.drawLine(start.leftCenter(), end.rightCenter(), paint);
      }
      return;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DrawLinePainter extends CustomPainter {
  ///
  late Map<int, List<OmitPosition>> positions;

  DrawLinePainter(List<LotteryOmit> omits) {
    if (omits[0].type.value == 'pl5') {
      positions = buildPl5Positions(omits);
      return;
    }
    positions = buildPositions(omits);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (positions.isEmpty) {
      return;
    }
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..color = redFont
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.5.w;
    positions.forEach((k, v) => drawPositions(v, canvas, paint));
  }

  void drawPositions(List<OmitPosition> positions, Canvas canvas, Paint paint) {
    if (positions.isEmpty || positions.length == 1) {
      return;
    }
    for (int i = 1; i < positions.length; i++) {
      linePosition(positions[i - 1], positions[i], canvas, paint);
    }
  }

  void linePosition(
      OmitPosition start, OmitPosition end, Canvas canvas, Paint paint) {
    if (start.col == end.col) {
      canvas.drawLine(start.bottomCenter(), end.topCenter(), paint);
      return;
    }
    if (start.col < end.col) {
      if (end.col - start.col <= 2) {
        canvas.drawLine(start.bottomRight(), end.topLeft(), paint);
      } else {
        canvas.drawLine(start.rightCenter(), end.leftCenter(), paint);
      }
      return;
    }
    if (start.col > end.col) {
      if (start.col - end.col <= 2) {
        canvas.drawLine(start.bottomLeft(), end.topRight(), paint);
      } else {
        canvas.drawLine(start.leftCenter(), end.rightCenter(), paint);
      }
      return;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RecDrawLinePainter extends CustomPainter {
  ///
  final Map<int, List<RectanglePosition>> positions;

  RecDrawLinePainter(this.positions);

  @override
  void paint(Canvas canvas, Size size) {
    if (positions.isEmpty) {
      return;
    }
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..color = redFont
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.6.w;
    positions.forEach((_, position) {
      drawPositions(position, canvas, paint);
    });
  }

  void drawPositions(
      List<RectanglePosition> positions, Canvas canvas, Paint paint) {
    if (positions.isEmpty || positions.length == 1) {
      return;
    }
    for (int i = 1; i < positions.length; i++) {
      linePosition(positions[i - 1], positions[i], canvas, paint);
    }
  }

  void linePosition(RectanglePosition start, RectanglePosition end,
      Canvas canvas, Paint paint) {
    if ((start.col - end.col).abs() <= 1) {
      return;
    }
    if (start.col < end.col) {
      canvas.drawLine(start.rightCenter(), end.leftCenter(), paint);
      return;
    }
    if (start.col > end.col) {
      canvas.drawLine(start.leftCenter(), end.rightCenter(), paint);
      return;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
