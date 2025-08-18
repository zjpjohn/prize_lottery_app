import 'package:flutter/material.dart';
import 'package:prize_lottery_app/utils/quick_table.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';

class HuntTable {
  ///
  /// 上期开奖号
  late LotteryInfo last;

  ///本期开奖号
  late LotteryInfo current;

  ///上上期开奖号
  late LotteryInfo before;

  ///
  late LotteryInfo lastBefore;

  ///速查表信息
  late List<List<RenderCell>> treasureTable;

  HuntTable.fromJson(Map<String, dynamic> json) {
    ///本期开奖信息
    current = LotteryInfo.fromJson(json['current']);

    ///上一期开奖信息
    last = LotteryInfo.fromJson(json['last']);

    ///上上一期开奖信息
    before = LotteryInfo.fromJson(json['before']);

    ///
    lastBefore = LotteryInfo.fromJson(json['lastBefore']);

    ///速查表信息
    treasureTable = TreasureTable.huntTable(
      last: last.redBalls(),
      before: before.redBalls(),
      lastBefore: lastBefore.redBalls(),
      currentShi: current.shiBalls(),
      current: current.redBalls(),
    );
  }
}

class TreasureTable {
  ///
  ///
  static List<List<String>> matrixTable = [
    ['1', '4', '7', '2', '5', '8', '0', '3', '6', '9', '3'],
    ['0', '3', '6', '9', '1', '4', '7', '2', '8', '5', '0'],
    ['1', '4', '7', '0', '3', '6', '9', '1', '7', '4', '9'],
    ['2', '5', '8', '1', '0', '3', '6', '9', '2', '5', '8'],
    ['0', '3', '6', '9', '3', '2', '8', '8', '1', '4', '7'],
    ['0', '3', '6', '9', '2', '5', '8', '0', '3', '6', '9'],
    ['1', '4', '7', '0', '3', '6', '8', '9', '2', '5', '8'],
    ['2', '5', '8', '1', '0', '3', '6', '9', '1', '4', '7'],
    ['1', '4', '7', '2', '5', '8', '1', '4', '7', '0', '3'],
    ['0', '3', '6', '9', '0', '3', '6', '9', '2', '5', '8'],
    ['1', '3', '7', '1', '3', '5', '8', '9', '7', '5', '3']
  ];

  ///
  /// 渲染速查表
  static List<List<RenderCell>> huntTable({
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
        for (int j = 0; j < row.length; j++) {
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
      if (sColPlus <= 10) {
        shiPos.add(Position(x: sRowMinus, y: sColPlus, xie: true));
      }
    }
    if (sRowPlus <= 10) {
      shiPos.add(Position(x: sRowPlus, y: column));
      if (sColMinus >= 0) {
        shiPos.add(Position(x: sRowPlus, y: sColMinus, xie: true));
      }
      if (sColPlus <= 10) {
        shiPos.add(Position(x: sRowPlus, y: sColPlus, xie: true));
      }
    }
    if (sColMinus >= 0) {
      shiPos.add(Position(x: row, y: sColMinus));
    }
    if (sColPlus <= 10) {
      shiPos.add(Position(x: row, y: sColPlus));
    }
    List<Cell> shis = [];
    for (int i = 0; i < shiPos.length; i++) {
      Position position = shiPos[i];
      if (ball[1] == matrixTable[position.x][position.y]) {
        shis.add(
          Cell(
            v: matrixTable[position.x][position.y],
            row: position.x,
            column: position.y,
            xie: position.xie,
            idx: 'shi',
          ),
        );
      }
      if (ball[2] == matrixTable[position.x][position.y]) {
        shis.add(
          Cell(
            v: matrixTable[position.x][position.y],
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
            if (ball[2] == matrixTable[pos.x][pos.y]) {
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
            if (ball[1] == matrixTable[pos.x][pos.y]) {
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
        if (gColPlus <= 10) {
          gPos.add(Position(x: gRowMinus, y: gColPlus));
        }
      }
      if (gRowPlus <= 10) {
        gPos.add(Position(x: gRowPlus, y: shi.column));
        if (gColMinus >= 0) {
          gPos.add(Position(x: gRowPlus, y: gColMinus));
        }
        if (gColPlus <= 10) {
          gPos.add(Position(x: gRowPlus, y: gColPlus));
        }
      }
      if (gColMinus >= 0) {
        gPos.add(Position(x: shi.row, y: gColMinus));
      }
      if (gColPlus <= 10) {
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
