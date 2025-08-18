import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/base/model/request_state.dart';
import 'package:prize_lottery_app/store/member.dart';
import 'package:prize_lottery_app/store/store.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/views/rank/model/master_item_rank.dart';
import 'package:prize_lottery_app/views/rank/repository/master_rank_repository.dart';

class UserCenterController extends AbsPageQueryController {
  ///
  List<MasterRankRecommend> ranks = [];

  ///彩票种类
  List<String> lotteries = ['ssq', 'fc3d', 'dlt'];

  ///
  Map<String, Future<List<MasterItemRank>>> getRankFutures() {
    ///
    Map<String, Future<List<MasterItemRank>>> futures = {};

    ///
    futures['fc3d'] = MasterRankRepository.fc3dMasterRanks(type: 'k1', limit: 8)
        .then((value) => value.records);
    futures['ssq'] = MasterRankRepository.ssqMasterRanks(type: 'rk3', limit: 8)
        .then((value) => value.records);
    futures['dlt'] = MasterRankRepository.dltMasterRanks(type: 'rk3', limit: 8)
        .then((value) => value.records);

    ///
    return futures;
  }

  Future<void> queryRankRecommends() async {
    ///
    Map<String, Future<List<MasterItemRank>>> rankFutures = getRankFutures();

    ///
    List<Future<List<MasterItemRank>>> futures =
        lotteries.map((e) => rankFutures[e]!).toList();

    ///
    await Future.wait(futures).then((values) {
      ranks.clear();
      for (int i = 0; i < lotteries.length; i++) {
        ranks.add(
          MasterRankRecommend(
            lotteryZhCns[lotteries[i]]!,
            lotteries[i],
            values[i],
          ),
        );
      }
    }).whenComplete(() {
      state = RequestState.success;
      update();
    });
  }

  List<MasterRankRecommend> get notEmptyRanks {
    return ranks.where((e) => e.ranks.isNotEmpty).toList();
  }

  bool get success {
    return state == RequestState.success;
  }

  @override
  Future<void> onInitial() async {
    ///
    showLoading();

    ///加载用户账户信息
    if (UserStore().authToken != '') {
      ///刷新账户信息
      BalanceInstance().refreshBalance();

      ///刷新会员信息
      MemberStore().refreshIfNull();
    }

    ///
    await queryRankRecommends();
  }

  @override
  Future<void> onRefresh() async {
    ///刷新账户信息
    BalanceInstance().refreshBalance();

    ///刷新会员信息
    MemberStore().refreshMember();

    ///刷新排名推荐信息
    await queryRankRecommends();
  }

  @override
  Future<void> onLoadMore() async {}
}

class MasterRankRecommend {
  ///
  late String name;

  ///
  late String type;

  ///
  late List<MasterItemRank> ranks;

  MasterRankRecommend(this.name, this.type, this.ranks);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'ranks': ranks,
    };
  }
}
