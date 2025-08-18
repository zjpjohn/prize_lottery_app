import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/forecast/repository/forecast_info_repository.dart';
import 'package:prize_lottery_app/views/master/model/dlt_history.dart';
import 'package:prize_lottery_app/views/master/model/dlt_master.dart';
import 'package:prize_lottery_app/views/master/model/history_record.dart';
import 'package:prize_lottery_app/views/master/repository/lotto_master_repository.dart';
import 'package:prize_lottery_app/views/master/widgets/trace_master_sheet.dart';
import 'package:prize_lottery_app/views/rank/model/dlt_master_rank.dart';
import 'package:prize_lottery_app/views/rank/repository/master_rank_repository.dart';
import 'package:prize_lottery_app/widgets/tab_filter_view.dart';

final double defaultExpandedHeight = 282.w;

class DltMasterDetailController extends AbsRequestController {
  ///专家标识
  late String masterId;

  ///专家详情
  late DltMasterDetail master;

  ///
  /// 是否展示推荐排名
  bool showRecommend = false;
  bool recommendLoading = false;

  ///
  /// 推荐专家信息
  List<DltMasterMulRank> masters = [];

  ///历史预测数据
  List<DltHistory> histories = [];

  ///初始渠道
  int initialIndex = 6;

  ///当前渠道
  int _currentIndex = 6;

  ///解析后历史预测数据
  late HistoryRecord record;

  ///当前类目下的预测历史
  late List<HitItem> current;

  ///header头部高度
  double _expandedHeight = defaultExpandedHeight;

  ///
  ///tab选项
  List<TabEntry> tabEntries = [
    TabEntry(key: 'r1', value: '红独胆'),
    TabEntry(key: 'r2', value: '红双胆'),
    TabEntry(key: 'r3', value: '红三胆'),
    TabEntry(key: 'r10', value: '红10码'),
    TabEntry(key: 'r20', value: '红20码'),
    TabEntry(key: 'rk3', value: '红杀三'),
    TabEntry(key: 'rk6', value: '红杀六'),
    TabEntry(key: 'b1', value: '蓝独胆'),
    TabEntry(key: 'b2', value: '蓝双胆'),
    TabEntry(key: 'b6', value: '蓝六码'),
    TabEntry(key: 'bk', value: '蓝杀码'),
  ];

  set expandedHeight(double value) {
    _expandedHeight = value;
    update();
  }

  double get expandedHeight => _expandedHeight;

  ///
  /// 展示推荐专家信息
  void showRecommendMasters(Function() callback) {
    if (showRecommend) {
      showRecommend = false;
      callback();
      update();
      return;
    }
    if (masters.isNotEmpty) {
      showRecommend = true;
      callback();
      update();
      return;
    }
    recommendLoading = true;
    update();
    MasterRankRepository.mulDltMasterRanks(page: 1, limit: 7).then((value) {
      masters.addAll(value.records.where((e) => e.master.masterId != masterId));
      showRecommend = true;
      update();
    }).whenComplete(() {
      Future.delayed(const Duration(milliseconds: 250), () {
        recommendLoading = false;
        update();
        if (showRecommend) {
          Future.delayed(const Duration(milliseconds: 60), () {
            callback();
          });
        }
      });
    });
  }

  void followMaster({String? trace, String? traceZh, Function()? success}) {
    if (master.subscribed == 1) {
      EasyLoading.showToast('已订阅专家');
      return;
    }
    EasyLoading.show(status: '订阅中');
    LottoMasterRepository.followMaster(
      masterId: master.master.masterId,
      trace: trace,
      type: 'dlt',
    ).then((value) {
      master.subscribed = 1;
      master.trace = trace ?? '';
      master.traceZh = traceZh ?? '';
      update();
      if (success != null) {
        success();
      }
    }).catchError((error) {
      EasyLoading.showError('订阅失败');
    }).whenComplete(() {
      Future.delayed(const Duration(milliseconds: 250), () {
        EasyLoading.dismiss();
      });
    });
  }

  ///
  /// 取消订阅专家
  void cancelFollow(Function() success) {
    EasyLoading.show(status: '正在取消');
    LottoMasterRepository.unFollowMaster(
      masterId: master.master.masterId,
      type: 'dlt',
    ).then((value) {
      master.subscribed = 0;
      master.special = 0;
      master.trace = '';
      master.traceZh = '';
      update();
      success();
    }).catchError((error) {
      EasyLoading.showError('取消失败');
    }).whenComplete(() {
      Future.delayed(const Duration(milliseconds: 250), () {
        EasyLoading.dismiss();
      });
    });
  }

  ///
  /// 重点关注及取消
  void specialFollow() {
    EasyLoading.show(status: '正在操作');
    LottoMasterRepository.specialOrCancelMaster(
      masterId: master.master.masterId,
      type: 'dlt',
    ).then((value) {
      master.special = master.special == 1 ? 0 : 1;
      update();
    }).catchError((error) {
      EasyLoading.showError('操作失败');
    }).whenComplete(() {
      Future.delayed(const Duration(milliseconds: 250), () {
        EasyLoading.dismiss();
      });
    });
  }

  ///
  /// 追踪专家
  void traceMaster(String trace, String traceZh) {
    if (trace == master.trace) {
      EasyLoading.showToast('正在追踪$traceZh');
      return;
    }
    EasyLoading.show(status: '正在操作');
    LottoMasterRepository.traceMaster(
      masterId: master.master.masterId,
      type: 'dlt',
      trace: trace,
    ).then((value) {
      master.trace = trace;
      master.traceZh = traceZh;
    }).catchError((error) {
      EasyLoading.showError('操作失败');
    }).whenComplete(() {
      Future.delayed(const Duration(milliseconds: 250), () {
        EasyLoading.dismiss();
      });
    });
  }

  List<TraceStatHit> getTraceHits() {
    return [
      if (master.redKill != null)
        TraceStatHit(
          trace: 'rk3',
          traceZh: '红球杀三',
          hit: master.redKill!,
        ),
      if (master.red20 != null)
        TraceStatHit(
          trace: 'r20',
          traceZh: '红球20码',
          hit: master.red20!,
        ),
      if (master.red3 != null)
        TraceStatHit(
          trace: 'r3',
          traceZh: '红球三胆',
          hit: master.red3!,
        ),
      if (master.blueKill != null)
        TraceStatHit(
          trace: 'bk',
          traceZh: '蓝球杀三',
          hit: master.blueKill!,
        ),
      if (master.blue != null)
        TraceStatHit(
          trace: 'b6',
          traceZh: '蓝球定六',
          hit: master.blue!,
        ),
    ];
  }

  set currentIndex(int index) {
    _currentIndex = index;
    current = record.getRecords(tabEntries[_currentIndex].key);
    update();
  }

  int get currentIndex => _currentIndex;

  void calcHistory(List<DltHistory> datas) {
    record = HistoryRecord()
      ..addRecord(
          'r1',
          datas
              .map((e) =>
                  HitItem.parseItem(e.period, true, e.red1, e.reds, e.blues))
              .toList())
      ..addRecord(
          'r2',
          datas
              .map((e) =>
                  HitItem.parseItem(e.period, false, e.red2, e.reds, e.blues))
              .toList())
      ..addRecord(
          'r3',
          datas
              .map((e) =>
                  HitItem.parseItem(e.period, false, e.red3, e.reds, e.blues))
              .toList())
      ..addRecord(
          'r10',
          datas
              .map((e) =>
                  HitItem.parseItem(e.period, false, e.red10, e.reds, e.blues))
              .toList())
      ..addRecord(
          'r20',
          datas
              .map((e) =>
                  HitItem.parseItem(e.period, false, e.red20, e.reds, e.blues))
              .toList())
      ..addRecord(
          'rk3',
          datas
              .map((e) => HitItem.parseItem(
                  e.period, true, e.redKill3, e.reds, e.blues))
              .toList())
      ..addRecord(
          'rk6',
          datas
              .map((e) => HitItem.parseItem(
                  e.period, true, e.redKill6, e.reds, e.blues))
              .toList())
      ..addRecord(
          'b1',
          datas
              .map((e) =>
                  HitItem.parseItem(e.period, true, e.blue1, e.reds, e.blues))
              .toList())
      ..addRecord(
          'b2',
          datas
              .map((e) =>
                  HitItem.parseItem(e.period, false, e.blue2, e.reds, e.blues))
              .toList())
      ..addRecord(
          'b6',
          datas
              .map((e) =>
                  HitItem.parseItem(e.period, false, e.blue6, e.reds, e.blues))
              .toList())
      ..addRecord(
          'bk',
          datas
              .map((e) => HitItem.parseItem(
                  e.period, true, e.blueKill3, e.reds, e.blues))
              .toList());
  }

  @override
  void initialBefore() {
    masterId = Get.parameters['masterId']!;
    String channel = Get.parameters['channel'] ?? 'rk3';
    initialIndex = tabEntries.lastIndexWhere((e) => e.key == channel);
  }

  @override
  Future<void> request() async {
    ///
    showLoading();

    ///
    Future<void> masterAsync = LottoMasterRepository.dltMasterDetail(masterId)
        .then((value) => master = value);

    ///
    Future<void> historyAsync =
        ForecastInfoRepository.dltHistories(masterId).then((value) {
      histories
        ..clear()
        ..addAll(value);
      calcHistory(histories);
    });

    ///
    Future.wait([masterAsync, historyAsync]).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(master);
        currentIndex = initialIndex;
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
