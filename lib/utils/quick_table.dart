import 'package:flutter/material.dart';

class Position {
  late int x;
  late int y;
  late bool xie;

  Position({required this.x, required this.y, this.xie = false});

  Map<String, dynamic> toJson() {
    return {'x': x, 'y': y, 'xie': xie};
  }
}

class QuickTable {
  //速查表信息
  static List<List<String>> fastMatrix = [
    ["8", "3", "7", "3", "6", "1", "7", "7", "4", "4", "2", "2", "8"],
    ["5", "1", "2", "2", "0", "6", "1", "9", "7", "6", "4", "0", "5"],
    ["2", "5", "4", "7", "2", "3", "8", "4", "9", "7", "3", "4", "2"],
    ["2", "4", "1", "6", "5", "9", "3", "4", "5", "1", "9", "3", "2"],
    ["1", "2", "0", "5", "8", "8", "6", "7", "4", "8", "8", "6", "1"],
    ["4", "3", "7", "4", "0", "9", "3", "0", "3", "4", "0", "5", "4"],
    ["8", "5", "9", "2", "4", "5", "7", "8", "4", "2", "0", "7", "8"],
    ["7", "0", "0", "6", "9", "6", "4", "9", "9", "8", "9", "7", "7"],
    ["0", "6", "4", "0", "7", "5", "8", "3", "8", "6", "2", "3", "0"],
    ["8", "3", "0", "7", "1", "7", "2", "6", "0", "9", "4", "6", "8"],
    ["2", "1", "1", "1", "8", "0", "6", "5", "5", "6", "1", "4", "2"],
    ["6", "4", "0", "4", "2", "1", "1", "6", "3", "5", "1", "3", "6"],
    ["8", "9", "0", "0", "0", "2", "7", "3", "5", "3", "4", "3", "8"],
    ["8", "5", "0", "2", "8", "3", "0", "1", "8", "9", "7", "5", "8"],
    ["1", "7", "4", "4", "2", "7", "8", "4", "8", "6", "0", "7", "1"],
    ["6", "8", "9", "2", "8", "1", "5", "4", "2", "7", "9", "1", "6"],
    ["8", "3", "7", "3", "6", "1", "7", "7", "4", "4", "2", "2", "8"]
  ];

  ///
  /// 渲染速查表
  static List<List<RenderCell>> fastTable({
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
    for (int i = 0; i < fastMatrix.length; i++) {
      List<bool> chk = [];
      for (int j = 0; j < fastMatrix[i].length; j++) {
        chk.add(false);
      }
      chkResult.add(chk);
    }
    if (ball.isNotEmpty && ball.length == 3) {
      for (int i = 0; i < fastMatrix.length; i++) {
        List<String> row = fastMatrix[i];
        for (int j = 0; j < fastMatrix[i].length; j++) {
          String element = row[j];
          _position(ball, element, i, j, chkResult);
        }
      }
    }
    return chkResult;
  }

  ///
  /// 标记定位
  static void _position(List<String> ball, String element, int row, int column,
      List<List<bool>> chkTable) {
    //百位判断
    if (ball[0] != element) {
      return;
    }

    ///十位查找
    List<Position> shiPos = [];
    int sRowMinus = row - 1;
    int sRowPlus = row + 1;
    int sColMinus = column - 1;
    int sColPlus = column + 1;
    shiPos.add(Position(x: row, y: column));
    if (sRowMinus >= 0) {
      shiPos.add(Position(x: sRowMinus, y: column));
      if (sColMinus >= 0) {
        shiPos.add(Position(x: sRowMinus, y: sColMinus, xie: true));
      }
      if (sColPlus <= 12) {
        shiPos.add(Position(x: sRowMinus, y: sColPlus, xie: true));
      }
    }
    if (sRowPlus <= 16) {
      shiPos.add(Position(x: sRowPlus, y: column));
      if (sColMinus >= 0) {
        shiPos.add(Position(x: sRowPlus, y: sColMinus, xie: true));
      }
      if (sColPlus <= 12) {
        shiPos.add(Position(x: sRowPlus, y: sColPlus, xie: true));
      }
    }
    if (sColMinus >= 0) {
      shiPos.add(Position(x: row, y: sColMinus));
    }
    if (sColPlus <= 12) {
      shiPos.add(Position(x: row, y: sColPlus));
    }
    List<Cell> shis = [];
    for (int i = 0; i < shiPos.length; i++) {
      Position position = shiPos[i];
      if (ball[1] == fastMatrix[position.x][position.y]) {
        shis.add(
          Cell(
            v: fastMatrix[position.x][position.y],
            row: position.x,
            column: position.y,
            xie: position.xie,
            idx: 'shi',
          ),
        );
      }
      if (ball[2] == fastMatrix[position.x][position.y]) {
        shis.add(
          Cell(
            v: fastMatrix[position.x][position.y],
            row: position.x,
            column: position.y,
            xie: position.xie,
            idx: 'ge',
          ),
        );
      }
    }
    if (shis.isEmpty) {
      return;
    }
    if (shis.where((e) => e.idx == 'shi').isNotEmpty &&
        shis.where((e) => e.idx == 'ge').isNotEmpty) {
      chkTable[row][column] = true;
      for (int i = 0; i < shis.length; i++) {
        Cell shi = shis[i];
        chkTable[shi.row][shi.column] =
            chkTable[shi.row][shi.column] || shi.idx == 'shi';
        chkTable[shi.row][shi.column] =
            chkTable[shi.row][shi.column] || shi.idx == 'ge';
      }
    }

    //个位查找
    List<Cell> filter = shis.where((e) => e.idx == 'shi').toList();
    if (filter.isNotEmpty) {
      _calcPosition(
          shis: filter,
          callback: (pos, shi) {
            if (ball[2] == fastMatrix[pos.x][pos.y]) {
              chkTable[row][column] = true;
              chkTable[shi.row][shi.column] = true;
              chkTable[pos.x][pos.y] = true;
            }
          });
    }
    filter = shis.where((e) => e.idx == 'ge').toList();
    if (filter.isNotEmpty) {
      _calcPosition(
          shis: filter,
          callback: (pos, shi) {
            if (ball[1] == fastMatrix[pos.x][pos.y]) {
              chkTable[row][column] = true;
              chkTable[shi.row][shi.column] = true;
              chkTable[pos.x][pos.y] = true;
            }
          });
    }
  }

  static void _calcPosition(
      {required List<Cell> shis, required Function(Position, Cell) callback}) {
    for (int i = 0; i < shis.length; i++) {
      Cell shi = shis[i];
      int gRowMinus = shi.row - 1;
      int gRowPlus = shi.row + 1;
      int gColMinus = shi.column - 1;
      int gColPlus = shi.column + 1;
      List<Position> gPos = [];
      gPos.add(Position(x: shi.row, y: shi.column));
      if (gRowMinus >= 0) {
        gPos.add(Position(x: gRowMinus, y: shi.column));
        if (gColMinus >= 0) {
          gPos.add(Position(x: gRowMinus, y: gColMinus));
        }
        if (gColPlus <= 12) {
          gPos.add(Position(x: gRowMinus, y: gColPlus));
        }
      }
      if (gRowPlus <= 16) {
        gPos.add(Position(x: gRowPlus, y: shi.column));
        if (gColMinus >= 0) {
          gPos.add(Position(x: gRowPlus, y: gColMinus));
        }
        if (gColPlus <= 12) {
          gPos.add(Position(x: gRowPlus, y: gColPlus));
        }
      }
      if (gColMinus >= 0) {
        gPos.add(Position(x: shi.row, y: gColMinus));
      }
      if (gColPlus <= 12) {
        gPos.add(Position(x: shi.row, y: gColPlus));
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
    for (int i = 0; i < fastMatrix.length; i++) {
      List<RenderCell> rows = [];
      for (int j = 0; j < fastMatrix[i].length; j++) {
        bool last = lastTable[i][j];
        bool before = beforeTable[i][j];
        bool lastBefore = lastBeforeTable[i][j];
        bool currentShi = currShiTable[i][j];
        bool current = currentTable[i][j];
        RenderCell render = RenderCell(key: fastMatrix[i][j]);
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

class Cell {
  ///
  String v;

  ///
  int row;

  ///
  int column;

  ///
  bool xie;

  ///
  String idx;

  Cell({
    required this.row,
    required this.column,
    required this.v,
    this.xie = false,
    this.idx = '',
  });
}

class RenderCell {
  ///
  String key;

  ///
  Color color;

  ///
  Color font;

  RenderCell({
    required this.key,
    this.color = Colors.white,
    this.font = Colors.black54,
  });
}
