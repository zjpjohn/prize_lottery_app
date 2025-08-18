import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/utils/screen_protect.dart';
import 'package:prize_lottery_app/views/lottery/controller/lottery_palace_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

List<List<int>> _tables = [
  [4, 7, 3, 1, 0, 8, 5, 0, 9, 6, 3, 8],
  [8, 1, 2, 4, 9, 7, 8, 1, 5, 4, 2],
  [3, 9, 5, 8, 0, 3, 4, 8, 0, 4, 5, 9],
  [4, 0, 7, 6, 5, 1, 7, 2, 3, 6, 2],
  [5, 2, 3, 1, 2, 8, 9, 5, 9, 1, 8, 3],
  [1, 8, 9, 5, 6, 0, 8, 4, 7, 5, 0],
  [7, 2, 5, 4, 2, 3, 5, 9, 0, 6, 9, 7],
  [8, 9, 3, 8, 5, 6, 8, 4, 3, 1, 2],
  [9, 2, 4, 0, 4, 0, 5, 7, 9, 6, 8, 5],
  [3, 6, 1, 7, 1, 9, 2, 8, 4, 0, 7],
  [1, 8, 5, 9, 6, 3, 8, 3, 1, 5, 9, 5],
  [4, 0, 2, 7, 2, 4, 2, 6, 2, 4, 0],
  [7, 2, 4, 8, 2, 0, 3, 1, 9, 9, 1, 8],
  [1, 2, 0, 4, 1, 0, 8, 5, 7, 2, 3],
  [6, 8, 3, 5, 9, 6, 7, 4, 9, 5, 9, 1],
  [0, 4, 2, 7, 8, 1, 2, 3, 8, 4, 7],
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
  } else {
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
  }
  return pos;
}

class LotteryPalaceNewController extends AbsRequestController {
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
      callback(cells[row][column]);
      for (int i = 0; i < shis.length; i++) {
        Position shi = shis[i];
        if (shi.idx == 'shi') {
          callback(cells[shi.row][shi.column]);
        }
        if (shi.idx == 'ge') {
          callback(cells[shi.row][shi.column]);
        }
      }
    }

    ///个位查找
    List<Position> filter = shis.where((e) => e.idx == 'shi').toList();
    if (filter.isNotEmpty) {
      for (int i = 0; i < filter.length; i++) {
        Position shi = filter[i];
        List<Position> gPos = _neighbors(shi.row, shi.column);
        for (var p in gPos) {
          int r = p.row;
          int c = p.column;
          List<Cell> gCells = cells[r];
          if (balls[2] == '${gCells[c].key}') {
            callback(cells[row][column]);
            callback(cells[shi.row][shi.column]);
            callback(cells[r][c]);
          }
        }
      }
    }
    filter = shis.where((e) => e.idx == 'ge').toList();
    if (filter.isNotEmpty) {
      for (int i = 0; i < filter.length; i++) {
        Position shi = filter[i];
        List<Position> gPos = _neighbors(shi.row, shi.column);
        for (var p in gPos) {
          int r = p.row;
          int c = p.column;
          List<Cell> gCells = cells[r];
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
