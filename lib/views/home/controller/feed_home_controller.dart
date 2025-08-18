import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/base/model/request_state.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/views/home/controller/layer_state_controller.dart';
import 'package:prize_lottery_app/views/home/model/master_feeds.dart';
import 'package:prize_lottery_app/views/home/model/master_lotto_glad.dart';
import 'package:prize_lottery_app/views/home/repository/feed_home_repository.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';
import 'package:prize_lottery_app/views/rank/model/master_item_rank.dart';
import 'package:prize_lottery_app/views/rank/repository/master_rank_repository.dart';

class LotteryChannel {
  String icon;
  String name;
  String channel;
  String field;
  String fieldIdx;

  LotteryChannel({
    required this.icon,
    required this.name,
    required this.channel,
    required this.field,
    required this.fieldIdx,
  });

  Future<List<MasterItemRank>> get task async {
    switch (channel) {
      case 'fc3d':
        return MasterRankRepository.fc3dMasterRanks(
          type: fieldIdx,
          limit: 4,
        ).then((value) => value.records);
      case 'pl3':
        return MasterRankRepository.pl3MasterRanks(
          type: fieldIdx,
          limit: 4,
        ).then((value) => value.records);
      case 'ssq':
        return MasterRankRepository.ssqMasterRanks(
          type: fieldIdx,
          limit: 4,
        ).then((value) => value.records);
      case 'dlt':
        return MasterRankRepository.dltMasterRanks(
          type: fieldIdx,
          limit: 4,
        ).then((value) => value.records);
      default:
        return Future.error(Exception('未知彩种渠道.'));
    }
  }
}

///
/// 彩票频道集合
final List<LotteryChannel> channels = [
  LotteryChannel(
    icon: R.fc3dLottoIcon,
    name: '福彩3D',
    channel: 'fc3d',
    field: '杀码',
    fieldIdx: 'k1',
  ),
  LotteryChannel(
    icon: R.pl3LottoIcon,
    name: '排列三',
    channel: 'pl3',
    field: '杀码',
    fieldIdx: 'k1',
  ),
  LotteryChannel(
    icon: R.ssqLottoIcon,
    name: '双色球',
    channel: 'ssq',
    field: '杀码',
    fieldIdx: 'rk3',
  ),
  LotteryChannel(
    icon: R.dltLottoIcon,
    name: '大乐透',
    channel: 'dlt',
    field: '杀码',
    fieldIdx: 'rk3',
  ),
];

///
/// 开奖频道区块
///
class LotteryBlock {
  ///
  /// 开奖信息
  LotteryInfo lottery;

  ///
  /// 推荐专家
  List<MasterItemRank> recommends = [];

  LotteryBlock({
    required this.lottery,
    required this.recommends,
  });
}

class FeedHomeController extends AbsPageQueryController {
  ///
  /// 开奖频道
  LotteryBlock? lottery;

  ///
  /// 中奖专家集合
  List<MasterLottoGlad> glads = [];

  ///
  /// 信息流是否全部加载完成
  bool loadAll = false;

  ///分页参数
  int page = 1, limit = 8;

  ///
  /// 加载时间
  DateTime loadTime = DateTime.now();

  ///分层预警推荐状态
  LayerState layerState = LayerState.empty();

  ///
  /// 信息流
  List<MasterFeeds> feeds = [];

  ///
  /// 当前彩票频道
  LotteryChannel channel = channels[0];

  ///
  /// 金刚区信息
  List<List<KingKong>> kingkongs = [
    [
      KingKong(
        name: '专家对比',
        icon: R.masterBattle,
        route: AppRoutes.fc3dBattle,
        hot: true,
        order: 1,
        intro: '专家对比：批量选择专家推荐方案进行对比统计，为您提供多维度指导',
      ),
      KingKong(
        name: '整体分析',
        icon: R.synthAnalyze,
        route: AppRoutes.fc3dFullCensus,
      ),
      KingKong(
        name: '预警推荐',
        icon: R.recomMaster,
        route: '/fc3d/num3/layer',
        hot: true,
        layer: true,
        order: 2,
        intro: '预警推荐：给出本期选号参考大底、跨度、和值预警及重点号码推荐',
      ),
      KingKong(
        name: '牛人汇总',
        icon: R.hotAnalyze,
        route: AppRoutes.fc3dRateCensus,
      ),
      KingKong(
        name: '快速查表',
        icon: R.quickTable,
        route: '/qtable/fc3d',
      ),
    ],
    [
      KingKong(
        name: '智能选号',
        icon: R.lottoIntellect,
        route: AppRoutes.fc3dIntellect,
      ),
      KingKong(
        name: '蜂巢查表',
        icon: R.lottoWarning,
        route: '/palace/new/fc3d',
      ),
      KingKong(
        name: '号码走势',
        icon: R.basicTrend,
        route: '/fc3d/trend/0',
      ),
      KingKong(
        name: '今日指数',
        icon: R.lottoFormula,
        route: '/fc3d/num3/lotto/index',
        order: 3,
        intro: '智能选号：本期选号推荐可能性指数，给您选号提供一定助力指导',
      ),
      KingKong(
        name: '缩水过滤',
        icon: R.shrinkFilter,
        route: '/wens/filter/fc3d',
        hot: true,
        order: 4,
        intro: '缩水过滤：提供胆码、组合、跨度及和值等常用缩水过滤指标，便于您精准锁定号码',
      ),
    ],
  ];

  List<Future<void>> asyncTasks() {
    Future<void> lotteryAsync = Future.wait([
      LotteryInfoRepository.latestLottery(channel.channel),
      channel.task,
    ]).then((values) {
      lottery = LotteryBlock(
        lottery: values[0] as LotteryInfo,
        recommends: values[1] as List<MasterItemRank>,
      );
    });
    return [
      lotteryAsync,
      FeedHomeRepository.masterGlads().then((value) => glads = value),
      LayerStateController()
          .layerHomeState(2000)
          .then((value) => layerState = value),
      FeedHomeRepository.masterFeeds(time: loadTime, page: page, limit: limit)
          .then((value) {
        feeds
          ..clear()
          ..addAll(value);
      }),
    ];
  }

  ///
  ///
  /// 切换彩票频道
  void switchLotteryChannel() {
    var oldChannel = channel;
    int index = 0;
    for (var i = 0; i < channels.length; i++) {
      if (channels[i].channel == channel.channel) {
        index = i;
        break;
      }
    }
    index = index + 1;
    if (index >= channels.length) {
      index = 0;
    }
    EasyLoading.show(status: '正在切换');
    channel = channels[index];
    Future.wait([
      LotteryInfoRepository.latestLottery(channel.channel),
      channel.task,
    ]).then((values) {
      lottery = LotteryBlock(
        lottery: values[0] as LotteryInfo,
        recommends: values[1] as List<MasterItemRank>,
      );
      Future.delayed(const Duration(milliseconds: 200), () {
        update();
        EasyLoading.dismiss();
      });
    }).catchError((error) {
      channel = oldChannel;
      update();
      EasyLoading.showToast('切换失败');
    });
  }

  @override
  Future<void> onInitial() async {
    showLoading();
    Future.wait(asyncTasks()).then((value) {
      state = RequestState.success;
    }).catchError((error) {
      state = RequestState.error;
    }).whenComplete(() {
      Future.delayed(const Duration(milliseconds: 200), () {
        update();
      });
    });
  }

  @override
  Future<void> onLoadMore() async {
    if (loadAll) {
      return;
    }
    page = page + 1;
    await FeedHomeRepository.masterFeeds(
      time: loadTime,
      page: page,
      limit: limit,
    ).then((value) {
      if (value.isNotEmpty) {
        feeds.addAll(value);
        update();
        return;
      }
      loadAll = true;
    }).catchError((error) {
      page = page - 1;
    });
  }

  @override
  Future<void> onRefresh() async {
    page = 1;
    loadTime = DateTime.now();
    await Future.wait(asyncTasks()).whenComplete(() => update());
  }
}

class KingKong {
  ///
  /// 图标名称
  late String name;

  /// 图标图片
  late String icon;

  /// 页面路由地址
  late String route;

  /// 是否热门
  late bool hot;

  ///是否分层预警
  late bool layer;

  ///引导顺序
  late int? order;

  ///引导介绍
  late String? intro;

  KingKong({
    required this.name,
    required this.icon,
    required this.route,
    this.hot = false,
    this.layer = false,
    this.order,
    this.intro,
  });
}
