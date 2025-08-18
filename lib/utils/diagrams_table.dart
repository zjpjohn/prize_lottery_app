import 'package:flutter/material.dart';
import 'package:prize_lottery_app/utils/quick_table.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';

class DiagramsTable {
  late LotteryInfo last;
  late LotteryInfo current;
  late LotteryInfo before;
  late LotteryInfo lastBefore;
  late List<List<RenderCell>> diagramsTable;

  DiagramsTable.fromJson(Map<String, dynamic> json) {
    ///本期开奖信息
    current = LotteryInfo.fromJson(json['current']);

    ///上一期开奖信息
    last = LotteryInfo.fromJson(json['last']);

    ///上上一期开奖号
    before = LotteryInfo.fromJson(json['before']);

    ///
    lastBefore = LotteryInfo.fromJson(json['lastBefore']);

    ///八卦图信息
    diagramsTable = EightDiagrams.table(
      last: last.redBalls(),
      before: before.redBalls(),
      lastBefore: lastBefore.redBalls(),
      currentShi: current.shiBalls(),
      current: current.redBalls(),
    );
  }
}

class EightDiagrams {
  ///
  ///
  static List<List<String>> matrixTable = [
    ['1', '9', '7', '5', '1', '9', '7', '5', '3'],
    ['2', '0', '6', '8', '4', '2', '8', '6', '4'],
    ['3', '1', '9', '7', '5', '1', '9', '7', '5'],
    ['4', '2', '0', '8', '4', '2', '0', '8', '6'],
    ['5', '3', '1', '9', '5', '3', '1', '9', '7'],
    ['6', '4', '2', '0', '6', '4', '2', '0', '8'],
    ['7', '5', '3', '1', '7', '5', '3', '1', '9'],
    ['8', '6', '4', '2', '8', '6', '4', '2', '8'],
    ['7', '5', '1', '9', '7', '5', '1', '9', '7'],
    ['6', '2', '0', '8', '6', '2', '0', '8', '6'],
    ['3', '1', '9', '7', '3', '1', '9', '7', '3'],
    ['2', '0', '8', '4', '2', '0', '8', '4', '2'],
    ['1', '9', '5', '3', '1', '9', '5', '3', '1'],
    ['0', '6', '4', '2', '0', '6', '4', '2', '0']
  ];

  static List<List<RenderCell>> table({
    required List<String> last,
    required List<String> before,
    required List<String> lastBefore,
    required List<String> currentShi,
    required List<String> current,
  }) {
    return _renderTable(
      _chkBall(last),
      _chkBall(before),
      _chkBall(lastBefore),
      _chkBall(currentShi),
      _chkBall(current),
    );
  }

  ///
  /// 生成速查表
  static List<List<bool>> _chkBall(List<String> ball) {
    List<List<bool>> chkResult = [];
    for (int i = 0; i < matrixTable.length; i++) {
      List<bool> chk = [];
      for (int j = 0; j < matrixTable[i].length; j++) {
        chk.add(false);
      }
      chkResult.add(chk);
    }
    if (ball.isNotEmpty && ball.length == 3) {
      for (int i = 0; i < matrixTable.length; i++) {
        List<String> row = matrixTable[i];
        for (int j = 0; j < matrixTable[i].length; j++) {
          String element = row[j];
          _position(ball, element, i, j, chkResult);
        }
      }
    }
    return chkResult;
  }

  static void _position(List<String> ball, String element, int row, int column,
      List<List<bool>> table) {
    //百位判断
    if (ball[0] != element) {
      return;
    }
    //十位查找
    int sRowMinus = row - 1;
    int sRowPlus = row + 1;
    int sColMinus = column - 1;
    int sColPlus = column + 1;
    List<DiagramsCell> shiPos = [];
    shiPos.add(DiagramsCell(x: row, y: column));
    if (sRowMinus >= 0) {
      shiPos.add(DiagramsCell(x: sRowMinus, y: column));
      if (sColMinus >= 0) {
        shiPos.add(DiagramsCell(x: sRowMinus, y: sColMinus));
      }
      if (sColPlus <= 8) {
        shiPos.add(DiagramsCell(x: sRowMinus, y: sColPlus));
      }
    }
    if (sRowPlus <= 13) {
      shiPos.add(DiagramsCell(x: sRowPlus, y: column));
      if (sColMinus >= 0) {
        shiPos.add(DiagramsCell(x: sRowPlus, y: sColMinus));
      }
      if (sColPlus <= 8) {
        shiPos.add(DiagramsCell(x: sRowPlus, y: sColPlus));
      }
    }
    if (sColMinus >= 0) {
      shiPos.add(DiagramsCell(x: row, y: sColMinus));
    }
    if (sColPlus <= 8) {
      shiPos.add(DiagramsCell(x: row, y: sColPlus));
    }
    List<DiagramsCell> shis = [];
    for (int i = 0; i < shiPos.length; i++) {
      DiagramsCell pos = shiPos[i];
      if (ball[1] == matrixTable[pos.x][pos.y]) {
        shis.add(DiagramsCell(x: pos.x, y: pos.y, idx: 'shi'));
      }
      if (ball[2] == matrixTable[pos.x][pos.y]) {
        shis.add(DiagramsCell(x: pos.x, y: pos.y, idx: 'ge'));
      }
    }
    if (shis.isEmpty) {
      return;
    }
    if (shis.where((e) => e.idx == 'shi').isNotEmpty &&
        shis.where((e) => e.idx == 'ge').isNotEmpty) {
      table[row][column] = true;
      for (int i = 0; i < shis.length; i++) {
        DiagramsCell shi = shis[i];
        table[shi.x][shi.y] = table[shi.x][shi.y] || shi.idx == 'shi';
        table[shi.x][shi.y] = table[shi.x][shi.y] || shi.idx == 'ge';
      }
    }
    //个位查找
    List<DiagramsCell> filter = shis.where((e) => e.idx == 'shi').toList();
    if (filter.isNotEmpty) {
      _calcPosition(
          shis: filter,
          callback: (pos, shi) {
            if (ball[2] == matrixTable[pos.x][pos.y]) {
              table[row][column] = true;
              table[shi.x][shi.y] = true;
              table[pos.x][pos.y] = true;
            }
          });
    }
    filter = shis.where((e) => e.idx == 'ge').toList();
    if (filter.isNotEmpty) {
      _calcPosition(
          shis: filter,
          callback: (pos, shi) {
            if (ball[1] == matrixTable[pos.x][pos.y]) {
              table[row][column] = true;
              table[shi.x][shi.y] = true;
              table[pos.x][pos.y] = true;
            }
          });
    }
  }

  static void _calcPosition(
      {required List<DiagramsCell> shis,
      required Function(Position, DiagramsCell) callback}) {
    for (int i = 0; i < shis.length; i++) {
      DiagramsCell shi = shis[i];
      int gRowMinus = shi.x - 1;
      int gRowPlus = shi.x + 1;
      int gColMinus = shi.y - 1;
      int gColPlus = shi.y + 1;
      List<Position> gPos = [];
      gPos.add(Position(x: shi.x, y: shi.y));
      if (gRowMinus >= 0) {
        gPos.add(Position(x: gRowMinus, y: shi.y));
        if (gColMinus >= 0) {
          gPos.add(Position(x: gRowMinus, y: gColMinus));
        }
        if (gColPlus <= 8) {
          gPos.add(Position(x: gRowMinus, y: gColPlus));
        }
      }
      if (gRowPlus <= 13) {
        gPos.add(Position(x: gRowPlus, y: shi.y));
        if (gColMinus >= 0) {
          gPos.add(Position(x: gRowPlus, y: gColMinus));
        }
        if (gColPlus <= 8) {
          gPos.add(Position(x: gRowPlus, y: gColPlus));
        }
      }
      if (gColMinus >= 0) {
        gPos.add(Position(x: shi.x, y: gColMinus));
      }
      if (gColPlus <= 8) {
        gPos.add(Position(x: shi.x, y: gColPlus));
      }
      for (int j = 0; j < gPos.length; j++) {
        Position pos = gPos[j];
        callback(pos, shi);
      }
    }
  }

  static List<List<RenderCell>> _renderTable(
    List<List<bool>> lastTable,
    List<List<bool>> beforeTable,
    List<List<bool>> lastBeforeTable,
    List<List<bool>> currShiTable,
    List<List<bool>> currentTable,
  ) {
    List<List<RenderCell>> renderTable = [];
    for (int i = 0; i < matrixTable.length; i++) {
      List<RenderCell> rows = [];
      for (int j = 0; j < matrixTable[i].length; j++) {
        bool last = lastTable[i][j];
        bool before = beforeTable[i][j];
        bool lastBefore = lastBeforeTable[i][j];
        bool currentShi = currShiTable[i][j];
        bool current = currentTable[i][j];
        RenderCell render = RenderCell(key: matrixTable[i][j]);
        if (current) {
          render.color = Colors.pinkAccent;
          render.font = Colors.white;
        } else if (last) {
          render.color = const Color(0xff168c8c);
          render.font = Colors.white;
        } else if (before) {
          render.color = const Color(0xff68ac7a);
          render.font = Colors.white;
        } else if (lastBefore) {
          render.color = const Color(0xffB1D9C4);
          render.font = const Color(0xff168c8c);
        } else if (currentShi) {
          render.color = const Color(0xFFC7EDCC);
          render.font = const Color(0xff168c8c);
        } else {
          render.color = Colors.white;
        }
        rows.add(render);
      }
      renderTable.add(rows);
    }
    return renderTable;
  }
}

class DiagramsCell {
  late int x;
  late int y;
  late String idx;

  DiagramsCell({required this.x, required this.y, this.idx = ''});

  Map<String, dynamic> toJson() {
    return {'x': x, 'y': y, 'idx': idx};
  }
}
