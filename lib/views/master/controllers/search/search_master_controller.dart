import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/base/model/master_value.dart';
import 'package:prize_lottery_app/store/config.dart';
import 'package:prize_lottery_app/views/master/repository/lotto_master_repository.dart';

class SearchMasterController extends AbsRequestController {
  ///
  final TextEditingController controller = TextEditingController();

  ///热门搜索专家
  List<MasterValue> hotMasters = [];

  ///搜索历史
  List<String> histories = [];

  ///搜索内容
  String _search = '';

  List<MasterValue> results = [];

  String get search => _search;

  ///
  /// 专家搜索
  set search(String value) {
    _search = value;
    update();

    ///clear search
    if (_search.isEmpty) {
      results.clear();
      update();
      return;
    }
    EasyLoading.show(status: '搜索中');
    LottoMasterRepository.matchMasters(_search)
        .then((value) {
          results
            ..clear()
            ..addAll(value);
          update();
        })
        .catchError((error) {})
        .whenComplete(() {
          Future.delayed(
            const Duration(milliseconds: 250),
            () => EasyLoading.dismiss(),
          );
        });
  }

  ///
  /// 清空历史搜索
  void clearHistory() {
    histories.clear();
    ConfigStore().clearSearchHistories();
    update();
  }

  ///
  ///进入专家搜索详情页
  void gotoMasterDetail(MasterValue master, {bool history = false}) {
    if (history && !histories.contains(master.name)) {
      histories = [master.name, ...histories];
      ConfigStore().saveSearchHistories(histories);
      update();
    }
    Get.toNamed('/search/detail/${master.masterId}');
  }

  void getHotMasterList() async {
    await LottoMasterRepository.hotMasters().then((value) {
      hotMasters
        ..clear()
        ..addAll(value);
      update();
    }).catchError((error) {});
  }

  @override
  Future<void> request() async {
    ///显示加载动画
    showLoading();

    ///加载本地搜索历史
    histories = ConfigStore().getSearchHistories();

    ///加载热门搜索专家
    getHotMasterList();

    ///延迟显示
    Future.delayed(const Duration(milliseconds: 350), () {
      showSuccess(true);
    });
  }
}
