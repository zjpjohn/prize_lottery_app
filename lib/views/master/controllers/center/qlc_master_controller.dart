import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/views/master/model/home_master.dart';
import 'package:prize_lottery_app/views/master/model/master_schema.dart';
import 'package:prize_lottery_app/views/master/model/renew_master.dart';
import 'package:prize_lottery_app/views/master/repository/lotto_master_repository.dart';
import 'package:prize_lottery_app/views/rank/model/qlc_master_rank.dart';
import 'package:prize_lottery_app/views/rank/repository/master_rank_repository.dart';
import 'package:prize_lottery_app/views/user/model/browse_record.dart';
import 'package:prize_lottery_app/views/user/repository/user_repository.dart';
import 'package:prize_lottery_app/widgets/tab_filter_view.dart';

class QlcMasterController extends AbsPageQueryController {
  ///
  ///方案更新专家信息
  List<RenewMaster> renewMasters = [];

  ///
  /// 最近浏览记录
  RecentBrowseRecord browseRecord = RecentBrowseRecord();

  ///方案专家集合
  List<QlcSchema> schemas = [];

  ///综合排名
  List<QlcMasterMulRank> ranks = [];

  ///上首页专家
  Map<String, List<HomeMaster>> homeMasters = {};

  ///
  List<TabEntry> dropEntries = qlcChannels.entries
      .map((entry) => TabEntry(key: entry.key, value: entry.value))
      .toList();

  ///初始选项下标
  int initialIndex = 6;

  ///当前选项
  int _currentIndex = 0;

  ///选中值
  List<HomeMaster> picked = [];

  String get channel => dropEntries[currentIndex].key;

  set currentIndex(int index) {
    _currentIndex = index;
    picked = homeMasters[dropEntries[_currentIndex].key]??[];
    update();
  }

  int get currentIndex => _currentIndex;

  List<Future<void>> getRequestFutures() {
    Future<void> renewAsync = LottoMasterRepository.qlcRenewMaster()
        .then((value) => renewMasters = value);
    Future<void> recentBrowseAsync = UserInfoRepository.recentBrowse('qlc')
        .then((value) => browseRecord = value);
    Future<void> schemaAsync =
        LottoMasterRepository.qlcSchemaMasters().then((value) => schemas
          ..clear()
          ..addAll(value));
    Future<void> rankAsync =
        MasterRankRepository.mulQlcMasterRanks(page: 1, limit: 5)
            .then((value) => ranks
              ..clear()
              ..addAll(value.records));
    Future<void> homeAsync =
        LottoMasterRepository.homeMasters('qlc').then((value) => homeMasters
          ..clear()
          ..addAll(value));
    return [
      renewAsync,
      recentBrowseAsync,
      schemaAsync,
      rankAsync,
      homeAsync,
    ];
  }

  @override
  Future<void> onInitial() async {
    showLoading();
    await Future.wait(getRequestFutures()).then((value) {
      showSuccess(ranks);
      currentIndex = initialIndex;
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onRefresh() async {
    await Future.wait(getRequestFutures()).then((value) {
      showSuccess(ranks);
      currentIndex = _currentIndex;
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {}
}
