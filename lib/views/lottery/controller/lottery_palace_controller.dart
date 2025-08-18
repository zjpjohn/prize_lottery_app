import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/env/log_profile.dart';
import 'package:prize_lottery_app/utils/screen_protect.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

List<List<int>> _tables = [
  [3, 0, 8, 4, 0, 2, 1, 2, 3, 1, 4, 5, 0, 2, 0],
  [5, 2, 5, 3, 7, 1, 6, 3, 7, 7, 5, 5, 6, 0, 3, 3],
  [1, 4, 2, 7, 9, 8, 3, 0, 6, 2, 3, 6, 7, 5, 6],
  [0, 6, 3, 8, 4, 4, 1, 3, 5, 8, 9, 3, 0, 3, 9, 5],
  [4, 9, 9, 6, 2, 7, 8, 4, 6, 0, 7, 2, 2, 8, 1],
  [9, 2, 1, 7, 3, 8, 1, 2, 4, 5, 3, 5, 4, 8, 9, 3],
  [7, 6, 4, 7, 4, 5, 2, 4, 2, 0, 7, 1, 7, 6, 2],
  [2, 5, 2, 2, 3, 1, 3, 2, 1, 9, 6, 8, 5, 6, 3, 8],
  [8, 1, 5, 7, 4, 7, 0, 1, 6, 8, 6, 2, 0, 6, 4],
  [2, 9, 6, 2, 8, 5, 7, 8, 1, 9, 8, 5, 1, 3, 7, 9],
  [4, 0, 3, 5, 6, 0, 6, 6, 7, 8, 5, 9, 6, 2, 7],
  [5, 3, 9, 7, 0, 2, 8, 5, 6, 7, 7, 3, 0, 1, 0, 6],
  [0, 2, 2, 3, 0, 9, 4, 7, 3, 3, 5, 6, 1, 8, 0],
  [8, 1, 9, 9, 0, 7, 2, 5, 1, 1, 8, 7, 9, 1, 4, 3],
  [3, 7, 1, 4, 4, 2, 0, 8, 4, 7, 0, 4, 9, 6, 8],
  [2, 4, 2, 2, 1, 8, 6, 9, 2, 3, 6, 5, 9, 1, 7, 5],
  [9, 2, 4, 9, 0, 3, 6, 2, 5, 1, 7, 8, 8, 4, 3]
];

List<Position> _neighbors(int row, int column) {
  List<Position> pos = [];
  pos.add(Position(row: row, column: column));
  if (column - 1 >= 0) {
    pos.add(Position(row: row, column: column - 1));
  }
  if (column + 1 < _tables[row].length) {
    pos.add(Position(row: row, column: column + 1));
  }
  if (row % 2 == 0) {
    if (row - 1 >= 0) {
      pos.add(Position(row: row - 1, column: column));
      if (column + 1 < _tables[row - 1].length) {
        pos.add(Position(row: row - 1, column: column + 1));
      }
    }
    if (row + 1 < _tables.length) {
      pos.add(Position(row: row + 1, column: column));
      if (column + 1 < _tables[row + 1].length) {
        pos.add(Position(row: row + 1, column: column + 1));
      }
    }
  } else {
    if (row - 1 >= 0) {
      if (column < _tables[row - 1].length) {
        pos.add(Position(row: row - 1, column: column));
      }
      if (column - 1 > 0) {
        pos.add(Position(row: row - 1, column: column - 1));
      }
    }
    if (row + 1 < _tables.length) {
      if (column < _tables[row + 1].length) {
        pos.add(Position(row: row + 1, column: column));
      }
      if (column - 1 >= 0) {
        pos.add(Position(row: row + 1, column: column - 1));
      }
    }
  }
  return pos;
}

List<Color> cellColors = [
  const Color(0xFF1E90FF).withValues(alpha: 0.08),
  const Color(0xFF32CD32).withValues(alpha: 0.08),
  Colors.pinkAccent.withValues(alpha: 0.08),
];

class Cell {
  int key;
  bool before;
  bool last;
  bool current;
  bool currentShi;

  Cell(
    this.key, {
    this.last = false,
    this.before = false,
    this.current = false,
    this.currentShi = false,
  });
}

class Position {
  final int row;
  final int column;
  final String idx;

  Position({required this.row, required this.column, this.idx = ''});

  Map<String, dynamic> toJson() {
    return {'x': row, 'y': column, 'idx': idx};
  }
}

class LotteryPalaceController extends AbsRequestController {
  ///彩票类型
  late String type;

  ///当前期号
  String? _period;
  int current = 0;
  List<String> periods = [];

  ///缓存指定期的数据
  Map<String, List<LotteryInfo>> cache = {};

  /// 开奖数据
  List<LotteryInfo> lotteries = [];

  /// 蜂巢表数据
  List<List<Cell>> cells = [];

  String? get period => _period;

  bool isFirst() {
    if (periods.isNotEmpty) {
      return current >= periods.length - 1;
    }
    return true;
  }

  bool isEnd() {
    return current <= 0;
  }

  void prevPeriod() {
    if (isFirst()) {
      return;
    }
    current = current + 1;
    period = periods[current];
  }

  void nextPeriod() {
    if (isEnd()) {
      return;
    }
    current = current - 1;
    period = periods[current];
  }

  set period(String? period) {
    if (period == null || _period == period) {
      return;
    }
    _period = period;
    if (cache[_period] != null) {
      lotteries = cache[_period]!;
      _calcHoneyCell();
    }
    update();
    if (cache[_period] == null) {
      EasyLoading.show(status: '加载中');
      LotteryInfoRepository.num3BeforeLotteries(type: type, period: _period)
          .then((value) {
        lotteries = value;
        if (value.isNotEmpty && value.length == 3) {
          _period = lotteries[0].period;
          cache[_period!] = lotteries;
          _calcHoneyCell();
          update();
        }
      }).catchError((error) {
        showError(error);
      }).whenComplete(() {
        Future.delayed(const Duration(milliseconds: 200), () {
          EasyLoading.dismiss();
        });
      });
    }
  }

  @override
  void initialBefore() {
    type = Get.parameters['type']!;

    ///开启数据保护
    ScreenProtect.protectOn();
  }

  @override
  void onClose() {
    super.onClose();

    ///关闭数据保护
    ScreenProtect.protectOff();
  }

  List<Future<void>> asyncTasks() {
    return [
      LotteryInfoRepository.num3LotteryPeriods(type).then((value) {
        periods = value;
        if (periods.isNotEmpty) {
          _period = periods[0];
        }
      }),
      LotteryInfoRepository.num3BeforeLotteries(type: type, period: _period)
          .then((value) {
        lotteries = value;
        if (value.isNotEmpty && value.length == 3) {
          _period = lotteries[0].period;
          cache[_period!] = lotteries;
        }
      }),
    ];
  }

  @override
  Future<void> request() async {
    showLoading();

    ///初始化蜂巢图
    _initHoneCells();

    Future.wait(asyncTasks()).then((_) {
      ///开奖位置
      _calcHoneyCell();
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(lotteries);
      });
    }).catchError((error) {
      logger.e(error);
      showError(error);
    });
  }

  void _initHoneCells() {
    cells = _tables.map((e) => e.map((e) => Cell(e)).toList()).toList();
  }

  void _resetHoneyCell() {
    for (int i = 0; i < cells.length; i++) {
      for (int j = 0; j < cells[i].length; j++) {
        cells[i][j].current = false;
        cells[i][j].currentShi = false;
        cells[i][j].last = false;
        cells[i][j].before = false;
      }
    }
  }

  void _calcHoneyCell() {
    _resetHoneyCell();
    if (lotteries.isEmpty) {
      return;
    }
    _calcHoneyLotto(
      lotteries[0],
      (cell) => cell.current = true,
      (cell) => cell.currentShi = true,
    );
    _calcHoneyLotto(lotteries[1], (cell) => cell.last = true, null);
    _calcHoneyLotto(lotteries[2], (cell) => cell.before = true, null);
  }

  void _calcHoneyLotto(
      LotteryInfo lotto, Function(Cell) lottery, Function(Cell)? trial) {
    List<String> balls = lotto.redBalls();
    List<String> shiBalls = lotto.shiBalls();
    for (int i = 0; i < cells.length; i++) {
      List<Cell> rows = cells[i];
      for (int j = 0; j < rows.length; j++) {
        _position(balls, i, j, (cell) => lottery(cell));
        if (trial != null) {
          _position(shiBalls, i, j, (cell) => trial(cell));
        }
      }
    }
  }

  void _position(
      List<String> balls, int row, int column, Function(Cell) callback) {
    Cell cell = cells[row][column];
    if (balls.isEmpty) {
      return;
    }

    ///百位判断
    if (balls[0] != '${cell.key}') {
      return;
    }

    ///十位查找
    List<Position> shiPos = _neighbors(row, column);
    List<Position> shis = [];
    for (var p in shiPos) {
      int r = p.row;
      int c = p.column;
      List<Cell> sCells = cells[r];
      if (balls[1] == '${sCells[c].key}') {
        shis.add(Position(row: r, column: c, idx: 'shi'));
      }
      if (balls[2] == '${sCells[c].key}') {
        shis.add(Position(row: r, column: c, idx: 'ge'));
      }
    }
    if (shis.isEmpty) {
      ///十位未匹配返回
      return;
    }
    if (shis.where((e) => e.idx == 'shi').isNotEmpty &&
        shis.where((e) => e.idx == 'ge').isNotEmpty) {
      for (int i = 0; i < shis.length; i++) {
        Position shi = shis[i];
        callback(cells[row][column]);
        if (shi.idx == 'shi' || shi.idx == 'ge') {
          callback(cells[shi.row][shi.column]);
        }
      }
    }

    ///
    /// 十位号码
    List<Position> shiList = shis.where((e) => e.idx == 'shi').toList();
    if (shiList.isNotEmpty) {
      for (int i = 0; i < shiList.length; i++) {
        Position shi = shiList[i];
        List<Position> gPos = _neighbors(shi.row, shi.column);
        for (var p in gPos) {
          int r = p.row;
          int c = p.column;
          List<Cell> gCells = cells[r];

          ///查找个位
          if (balls[2] == '${gCells[c].key}') {
            callback(cells[row][column]);
            callback(cells[shi.row][shi.column]);
            callback(cells[r][c]);
          }
        }
      }
    }

    ///
    ///个位号码
    List<Position> geList = shis.where((e) => e.idx == 'ge').toList();
    if (geList.isNotEmpty) {
      for (int i = 0; i < geList.length; i++) {
        Position shi = geList[i];
        List<Position> gPos = _neighbors(shi.row, shi.column);
        for (var p in gPos) {
          int r = p.row;
          int c = p.column;
          List<Cell> gCells = cells[r];

          ///查找十位
          if (balls[1] == '${gCells[c].key}') {
            callback(cells[row][column]);
            callback(cells[shi.row][shi.column]);
            callback(cells[r][c]);
          }
        }
      }
    }
  }
}
