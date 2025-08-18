import 'dart:async';

import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_info.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

class LotteryCenterController extends AbsPageQueryController {
  ///
  ///
  List<LotteryInfo> lotteries = [];

  List<LotteryInfo> get channelLotteries {
    return lotteries.where((e) => channelEntries[e.type] != null).toList();
  }

  @override
  Future<void> onInitial() async {
    showLoading();
    await LotteryInfoRepository.groupLatest().then((value) {
      lotteries = value;
      _lotterySort();
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(lotteries);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  void _lotterySort() {
    lotteries.sort((l1, l2) =>
        Constants.lotterySort(l1.type) - Constants.lotterySort(l2.type));
  }

  @override
  Future<void> onLoadMore() async {
    throw UnimplementedError();
  }

  @override
  Future<void> onRefresh() async {
    await LotteryInfoRepository.groupLatest().then((value) {
      lotteries = value;
      _lotterySort();
      Future.delayed(const Duration(milliseconds: 300), () {
        showSuccess(lotteries);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}

typedef RouteFunction = Function();

class ChannelEntry {
  ///渠道名称
  String name;

  ///渠道路由
  RouteFunction route;

  ///是否是热门：0-否,1-是
  int hot;

  ChannelEntry({
    required this.name,
    required this.route,
    this.hot = 0,
  });
}

Map<String, List<ChannelEntry>> channelEntries = {
  'fc3d': [
    ChannelEntry(
      name: '历史开奖',
      route: () {
        Get.toNamed('/lotto/history/fc3d');
      },
    ),
    ChannelEntry(
      name: '号码走势',
      route: () {
        Get.toNamed('/fc3d/trend/0');
      },
    ),
    ChannelEntry(
      name: '出号统计',
      route: () {
        Get.toNamed('/num3/com/count/fc3d');
      },
    ),
    ChannelEntry(
      name: '历史前后',
      route: () {
        Get.toNamed('/num3/follow/list/fc3d');
      },
    ),
    ChannelEntry(
      name: '快速查表',
      route: () {
        Get.toNamed('/qtable/fc3d');
      },
    ),
    ChannelEntry(
      name: '五行选号',
      route: () {
        Get.toNamed('/wtable/fc3d');
      },
    ),
    ChannelEntry(
      name: '寻宝选号',
      route: () {
        Get.toNamed('/htable/fc3d');
      },
    ),
    ChannelEntry(
      name: '八卦选号',
      route: () {
        Get.toNamed('/dtable/fc3d');
      },
    ),
    ChannelEntry(
      name: '蜂巢码表',
      route: () {
        Get.toNamed('/palace/new/fc3d');
      },
    ),
    ChannelEntry(
      name: '万能选号',
      route: () {
        Get.toNamed('/universal/code/fc3d');
      },
    ),
    ChannelEntry(
      name: '定胆选号',
      route: () {
        Get.toNamed('/lotto/dan/fc3d');
      },
    ),
    ChannelEntry(
      name: '缩水过滤',
      route: () {
        Get.toNamed('/wens/filter/fc3d');
      },
    ),
  ],
  'ssq': [
    ChannelEntry(
      name: '历史开奖',
      route: () {
        Get.toNamed('/lotto/history/ssq');
      },
    ),
    ChannelEntry(
      name: '号码走势',
      route: () {
        Get.toNamed('/ssq/trend/0');
      },
    ),
    ChannelEntry(
      name: '专家推荐',
      route: () {
        Get.toNamed('/ssq/item_rank/rk3');
      },
    ),
    ChannelEntry(
      name: '趋势分布',
      route: () {
        Get.toNamed('/ssq/trend/2');
      },
    ),
    ChannelEntry(
      name: '实时热点',
      route: () {
        Get.toNamed(AppRoutes.ssqRealTime);
      },
    ),
    ChannelEntry(
      name: '缩水过滤',
      route: () {
        Get.toNamed(AppRoutes.ssqShrink);
      },
    ),
    ChannelEntry(
      name: '奖金计算',
      route: () {
        Get.toNamed(AppRoutes.ssqCalculator);
      },
    ),
    ChannelEntry(
      name: '选号技巧',
      route: () {
        Get.toNamed(AppRoutes.skillList, arguments: {'type': 'ssq'});
      },
    ),
  ],
  'pl3': [
    ChannelEntry(
      name: '历史开奖',
      route: () {
        Get.toNamed('/lotto/history/pl3');
      },
    ),
    ChannelEntry(
      name: '号码走势',
      route: () {
        Get.toNamed('/pl3/trend/0');
      },
    ),
    ChannelEntry(
      name: '出号统计',
      route: () {
        Get.toNamed('/num3/com/count/pl3');
      },
    ),
    ChannelEntry(
      name: '历史前后',
      route: () {
        Get.toNamed('/num3/follow/list/pl3');
      },
    ),
    ChannelEntry(
      name: '快速查表',
      route: () {
        Get.toNamed('/qtable/pl3');
      },
    ),
    ChannelEntry(
      name: '五行选号',
      route: () {
        Get.toNamed('/wtable/pl3');
      },
    ),
    ChannelEntry(
      name: '寻宝选号',
      route: () {
        Get.toNamed('/htable/pl3');
      },
    ),
    ChannelEntry(
      name: '八卦选号',
      route: () {
        Get.toNamed('/dtable/pl3');
      },
    ),
    ChannelEntry(
      name: '蜂巢码表',
      route: () {
        Get.toNamed('/palace/new/pl3');
      },
    ),
    ChannelEntry(
      name: '万能选号',
      route: () {
        Get.toNamed('/universal/code/pl3');
      },
    ),
    ChannelEntry(
      name: '定胆选号',
      route: () {
        Get.toNamed('/lotto/dan/pl3');
      },
    ),
    ChannelEntry(
      name: '缩水过滤',
      route: () {
        Get.toNamed('/wens/filter/pl3');
      },
    ),
  ],
  'pl5': [
    ChannelEntry(
      name: '历史开奖',
      route: () {
        Get.toNamed('/lotto/history/pl5');
      },
    ),
    ChannelEntry(
      name: '基础遗漏',
      route: () {
        Get.toNamed('/pl5/omit/0');
      },
    ),
    ChannelEntry(
      name: '号码形态',
      route: () {
        Get.toNamed('/pl5/omit/1');
      },
    ),
    ChannelEntry(
      name: '和值遗漏',
      route: () {
        Get.toNamed('/pl5/omit/2');
      },
    ),
    ChannelEntry(
      name: '跨度遗漏',
      route: () {
        Get.toNamed('/pl5/omit/3');
      },
    ),
    ChannelEntry(
      name: '分位遗漏',
      route: () {
        Get.toNamed('/pl5/item/1');
      },
    ),
    ChannelEntry(
      name: '十位遗漏',
      route: () {
        Get.toNamed('/pl5/item/4');
      },
    ),
    ChannelEntry(
      name: '个位遗漏',
      route: () {
        Get.toNamed('/pl5/item/5');
      },
    ),
  ],
  'dlt': [
    ChannelEntry(
      name: '历史开奖',
      route: () {
        Get.toNamed('/lotto/history/dlt');
      },
    ),
    ChannelEntry(
      name: '号码走势',
      route: () {
        Get.toNamed('/dlt/trend/0');
      },
    ),
    ChannelEntry(
      name: '专家推荐',
      route: () {
        Get.toNamed('/dlt/item_rank/rk3');
      },
    ),
    ChannelEntry(
      name: '趋势分布',
      route: () {
        Get.toNamed('/dlt/trend/2');
      },
    ),
    ChannelEntry(
      name: '实时热点',
      route: () {
        Get.toNamed(AppRoutes.dltRealTime);
      },
    ),
    ChannelEntry(
      name: '缩水过滤',
      route: () {
        Get.toNamed(AppRoutes.dltShrink);
      },
    ),
    ChannelEntry(
      name: '奖金计算',
      route: () {
        Get.toNamed(AppRoutes.dltCalculator);
      },
    ),
    ChannelEntry(
      name: '选号技巧',
      route: () {
        Get.toNamed(AppRoutes.skillList, arguments: {'type': 'dlt'});
      },
    ),
  ],
  'qlc': [
    ChannelEntry(
      name: '历史开奖',
      route: () {
        Get.toNamed('/lotto/history/qlc');
      },
    ),
    ChannelEntry(
        name: '号码走势',
        route: () {
          Get.toNamed('/qlc/trend/0');
        }),
    ChannelEntry(
        name: '专家推荐',
        route: () {
          Get.toNamed('/qlc/item_rank/r22');
        }),
    ChannelEntry(
      name: '趋势分布',
      route: () {
        Get.toNamed('/qlc/trend/1');
      },
    ),
    ChannelEntry(
      name: '实时热点',
      route: () {
        Get.toNamed(AppRoutes.qlcRealTime);
      },
    ),
    ChannelEntry(
      name: '缩水过滤',
      route: () {
        Get.toNamed(AppRoutes.qlcShrink);
      },
    ),
    ChannelEntry(
      name: '奖金计算',
      route: () {
        Get.toNamed(AppRoutes.qlcCalculator);
      },
    ),
  ],
  'kl8': [
    ChannelEntry(
      name: '历史开奖',
      route: () {
        Get.toNamed('/lotto/history/kl8');
      },
    ),
    ChannelEntry(
      name: '号码热度',
      route: () {
        Get.toNamed(AppRoutes.kl8RealTime);
      },
    ),
    ChannelEntry(
      name: '奖金计算',
      route: () {
        Get.toNamed(AppRoutes.kl8Calculator);
      },
    ),
    ChannelEntry(
      name: '选号技巧',
      route: () {
        Get.toNamed(AppRoutes.skillList, arguments: {'type': 'kl8'});
      },
    ),
    ChannelEntry(
      name: '号码走势',
      route: () {
        Get.toNamed('/kl8/trend/0');
      },
    ),
    ChannelEntry(
      name: '和值走势',
      route: () {
        Get.toNamed('/kl8/trend/1');
      },
    ),
    ChannelEntry(
      name: '跨度分布',
      route: () {
        Get.toNamed('/kl8/trend/2');
      },
    ),
    ChannelEntry(
      name: '尾数矩阵',
      route: () {
        Get.toNamed('/kl8/matrix');
      },
    ),
  ],
};
