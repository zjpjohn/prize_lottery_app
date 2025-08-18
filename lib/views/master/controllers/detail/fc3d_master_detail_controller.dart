import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/forecast/repository/forecast_info_repository.dart';
import 'package:prize_lottery_app/views/master/model/fc3d_history.dart';
import 'package:prize_lottery_app/views/master/model/fc3d_master.dart';
import 'package:prize_lottery_app/views/master/model/history_record.dart';
import 'package:prize_lottery_app/views/master/repository/lotto_master_repository.dart';
import 'package:prize_lottery_app/views/master/widgets/trace_master_sheet.dart';
import 'package:prize_lottery_app/views/rank/model/fc3d_master_rank.dart';
import 'package:prize_lottery_app/views/rank/repository/master_rank_repository.dart';
import 'package:prize_lottery_app/widgets/tab_filter_view.dart';

final double defaultExpandedHeight = 282.w;

class Fc3dMasterDetailController extends AbsRequestController {
  ///
  /// 专家标识
  late String masterId;

  ///
  /// 专家详情
  late Fc3dMasterDetail master;

  ///
  /// 是否展示推荐排名
  bool showRecommend = false;
  bool recommendLoading = false;

  ///
  /// 推荐专家信息
  List<Fc3dMasterMulRank> masters = [];

  ///
  /// 历史预测成绩
  List<Fc3dHistory> histories = [];

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
    MasterRankRepository.mulFc3dMasterRanks(page: 1, limit: 7).then((value) {
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

  ///
  /// 订阅专家
  void followMaster({String? trace, String? traceZh, Function()? success}) {
    if (master.subscribed == 1) {
      EasyLoading.showToast('专家已订阅');
      return;
    }
    EasyLoading.show(status: '订阅中');
    LottoMasterRepository.followMaster(
      masterId: master.master.masterId,
      trace: trace,
      type: 'fc3d',
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
      type: 'fc3d',
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
      type: 'fc3d',
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
      type: 'fc3d',
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
      if (master.kill1 != null)
        TraceStatHit(
          trace: 'k1',
          traceZh: '杀一',
          hit: master.kill1!,
        ),
      if (master.kill2 != null)
        TraceStatHit(
          trace: 'k2',
          traceZh: '杀二',
          hit: master.kill2!,
        ),
      if (master.com7 != null)
        TraceStatHit(
          trace: 'c7',
          traceZh: '组选七码',
          hit: master.com7!,
        ),
      if (master.com6 != null)
        TraceStatHit(
          trace: 'c6',
          traceZh: '组选六码',
          hit: master.com6!,
        ),
      if (master.dan3 != null)
        TraceStatHit(
          trace: 'd3',
          traceZh: '三胆',
          hit: master.dan3!,
        ),
    ];
  }

  set currentIndex(int index) {
    _currentIndex = index;
    current = record.getRecords(tabEntries[_currentIndex].key);
    update();
  }

  int get currentIndex => _currentIndex;

  ///
  ///tab选项
  List<TabEntry> tabEntries = [
    TabEntry(key: 'd1', value: '独 胆'),
    TabEntry(key: 'd2', value: '双 胆'),
    TabEntry(key: 'd3', value: '三 胆'),
    TabEntry(key: 'c5', value: '组选五'),
    TabEntry(key: 'c6', value: '组选六'),
    TabEntry(key: 'c7', value: '组选七'),
    TabEntry(key: 'k1', value: '杀一码'),
    TabEntry(key: 'k2', value: '杀二码'),
    TabEntry(key: 'cb3', value: '定位三'),
    TabEntry(key: 'cb4', value: '定位四'),
    TabEntry(key: 'cb5', value: '定位五'),
  ];

  void calcHistory(List<Fc3dHistory> datas) {
    record = HistoryRecord()
      ..addRecord(
          'd1',
          datas
              .map((e) => HitItem.parseItem(e.period, true, e.dan1, e.reds, []))
              .toList())
      ..addRecord(
          'd2',
          datas
              .map(
                  (e) => HitItem.parseItem(e.period, false, e.dan2, e.reds, []))
              .toList())
      ..addRecord(
          'd3',
          datas
              .map(
                  (e) => HitItem.parseItem(e.period, false, e.dan3, e.reds, []))
              .toList())
      ..addRecord(
          'c5',
          datas
              .map(
                  (e) => HitItem.parseItem(e.period, false, e.com5, e.reds, []))
              .toList())
      ..addRecord(
          'c6',
          datas
              .map(
                  (e) => HitItem.parseItem(e.period, false, e.com6, e.reds, []))
              .toList())
      ..addRecord(
          'c7',
          datas
              .map(
                  (e) => HitItem.parseItem(e.period, false, e.com7, e.reds, []))
              .toList())
      ..addRecord(
          'k1',
          datas
              .map(
                  (e) => HitItem.parseItem(e.period, true, e.kill1, e.reds, []))
              .toList())
      ..addRecord(
          'k2',
          datas
              .map(
                  (e) => HitItem.parseItem(e.period, true, e.kill2, e.reds, []))
              .toList())
      ..addRecord(
          'cb3',
          datas
              .map(
                  (e) => HitItem.parseItem(e.period, true, e.comb3, e.reds, []))
              .toList())
      ..addRecord(
          'cb4',
          datas
              .map(
                  (e) => HitItem.parseItem(e.period, true, e.comb4, e.reds, []))
              .toList())
      ..addRecord(
          'cb5',
          datas
              .map(
                  (e) => HitItem.parseItem(e.period, true, e.comb5, e.reds, []))
              .toList());
  }

  @override
  Future<void> request() async {
    ///
    showLoading();

    ///
    Future<void> masterAsync = LottoMasterRepository.fc3dMasterDetail(masterId)
        .then((value) => master = value);

    ///
    Future<void> historyAsync =
        ForecastInfoRepository.fc3dHistories(masterId).then((value) {
      histories
        ..clear()
        ..addAll(value);
      calcHistory(histories);
    });

    ///
    Future.wait([masterAsync, historyAsync]).then((values) {
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(master);
        currentIndex = initialIndex;
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  void initialBefore() {
    masterId = Get.parameters['masterId']!;
    String channel = Get.parameters['channel'] ?? 'c7';
    initialIndex = tabEntries.lastIndexWhere((e) => e.key == channel);
  }
}
