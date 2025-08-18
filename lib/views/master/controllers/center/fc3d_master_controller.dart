import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/views/master/model/home_master.dart';
import 'package:prize_lottery_app/views/master/model/master_schema.dart';
import 'package:prize_lottery_app/views/master/model/renew_master.dart';
import 'package:prize_lottery_app/views/master/repository/lotto_master_repository.dart';
import 'package:prize_lottery_app/views/rank/model/fc3d_master_rank.dart';
import 'package:prize_lottery_app/views/rank/repository/master_rank_repository.dart';
import 'package:prize_lottery_app/views/user/model/browse_record.dart';
import 'package:prize_lottery_app/views/user/repository/user_repository.dart';
import 'package:prize_lottery_app/widgets/tab_filter_view.dart';

class Fc3dMasterController extends AbsPageQueryController {
  ///
  ///方案更新专家信息
  List<RenewMaster> renewMasters = [];

  ///
  /// 最近浏览记录
  RecentBrowseRecord browseRecord = RecentBrowseRecord();

  ///推荐方案
  List<Fc3dSchema> schemas = [];

  ///综合排名
  List<Fc3dMasterMulRank> ranks = [];

  ///上首页专家
  Map<String, List<HomeMaster>> homeMasters = {};

  ///
  List<TabEntry> dropEntries = fc3dChannels.entries
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

  List<Future<void>> getRequestFutures() {
    Future<void> renewMasterAsync = LottoMasterRepository.fc3dRenewMaster()
        .then((value) => renewMasters = value);
    Future<void> recentBrowseFuture = UserInfoRepository.recentBrowse('fc3d')
        .then((value) => browseRecord = value);
    Future<void> schemaAsync =
        LottoMasterRepository.fc3dSchemaMasters().then((value) => schemas
          ..clear()
          ..addAll(value));
    Future<void> rankAsync =
        MasterRankRepository.mulFc3dMasterRanks(page: 1, limit: 5)
            .then((value) => ranks
              ..clear()
              ..addAll(value.records));
    Future<void> homeAsync =
        LottoMasterRepository.homeMasters('fsd').then((value) => homeMasters
          ..clear()
          ..addAll(value));
    return [
      renewMasterAsync,
      recentBrowseFuture,
      schemaAsync,
      rankAsync,
      homeAsync
    ];
  }

  @override
  Future<void> onLoadMore() async {}
}
