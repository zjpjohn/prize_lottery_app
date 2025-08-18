import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/utils/date_util.dart';
import 'package:prize_lottery_app/views/user/model/browse_record.dart';
import 'package:prize_lottery_app/views/user/repository/user_repository.dart';

String todayKey = "今天";
String weekKey = "本周内";
String lastWeek = "上一周";
String earlyKey = "更早时间";

class UserBrowseController extends AbsPageQueryController {
  /// 集合条目
  List<RecordListItem> items = [];

  ///分组数量
  Map<String, int> groupCounts = {};

  ///分页查询条件
  int total = 0, page = 1, limit = 10, currentSize = 0;

  /// 当前查询时间
  late DateTime current;

  ///
  /// 清空分组记录
  void clearRecords() {
    currentSize = 0;
    items.clear();
    groupCounts.clear();
  }

  ///
  /// 时间分组计算浏览记录
  ///
  void timeGroupedRecords(List<BrowseRecord> records) {
    if (records.isEmpty) {
      return;
    }
    currentSize = currentSize + records.length;
    int current = DateUtil.getDayOfYear(DateTime.now());
    for (var value in records) {
      int createDay = DateUtil.getDayOfYear(value.createTime);
      int delta = current - createDay;
      if (delta == 0) {
        ///今日浏览数量
        int count = groupCounts[todayKey] ?? 0;

        ///追加第一条记录
        if (count == 0) {
          items.add(RecordListItem(type: 0, name: todayKey));
          count = count + 1;
        }
        items.add(RecordListItem(type: 1, record: value));
        groupCounts[todayKey] = count + 1;
      } else if (delta >= 1 && delta <= 7) {
        ///一周内浏览数量
        int count = groupCounts[weekKey] ?? 0;

        ///追加第一条记录
        if (count == 0) {
          items.add(RecordListItem(type: 0, name: weekKey));
          count = count + 1;
        }
        items.add(RecordListItem(type: 1, record: value));
        groupCounts[weekKey] = count + 1;
      } else if (delta > 7 && delta <= 14) {
        ///半个月内浏览数量
        int count = groupCounts[lastWeek] ?? 0;

        ///追加第一条记录
        if (count == 0) {
          items.add(RecordListItem(type: 0, name: lastWeek));
          count = count + 1;
        }
        items.add(RecordListItem(type: 1, record: value));
        groupCounts[lastWeek] = count + 1;
      } else if (delta > 14) {
        ///更早时间浏览数量
        int count = groupCounts[earlyKey] ?? 0;

        ///追加第一条记录
        if (count == 0) {
          items.add(RecordListItem(type: 0, name: earlyKey));
          count = count + 1;
        }
        items.add(RecordListItem(type: 1, record: value));
        groupCounts[earlyKey] = count + 1;
      }
    }
    update();
  }

  @override
  Future<void> onInitial() async {
    showLoading();
    current = DateTime.now();
    await UserInfoRepository.browseRecords(
      type: Get.parameters['type'],
      timestamp: current,
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      clearRecords();
      timeGroupedRecords(value.records);
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(items);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {
    if (currentSize == total) {
      EasyLoading.showToast('仅允许查询30天的记录');
      return;
    }
    page++;
    await UserInfoRepository.browseRecords(
      type: Get.parameters['type'],
      timestamp: current,
      page: page,
      limit: limit,
    ).then((value) {
      timeGroupedRecords(value.records);
      update();
    }).catchError((error) {
      page--;
    });
  }

  @override
  Future<void> onRefresh() async {
    page = 1;
    current = DateTime.now();
    await UserInfoRepository.browseRecords(
      type: Get.parameters['type'],
      timestamp: current,
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      clearRecords();
      timeGroupedRecords(value.records);
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(items);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}

class RecordListItem {
  ///条目类型
  int type;

  ///标题名称
  String? name;

  ///浏览记录
  BrowseRecord? record;

  RecordListItem({
    required this.type,
    this.name,
    this.record,
  });
}
