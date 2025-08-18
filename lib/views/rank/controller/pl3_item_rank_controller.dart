import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/views/glad/model/pl3_master_glad.dart';
import 'package:prize_lottery_app/views/glad/repository/master_glad_repository.dart';
import 'package:prize_lottery_app/views/rank/model/pl3_master_rank.dart';
import 'package:prize_lottery_app/views/rank/repository/master_rank_repository.dart';

class Pl3ItemRankController extends AbsPageQueryController {
  ///
  List<Pl3MasterGlad> glads = [];
  List<Pl3MasterRank> ranks = [];

  int total = 0, page = 1, limit = 8;

  ///tab面板是否展开
  bool _expanded = false;

  ///
  late String _type;

  bool get expanded => _expanded;

  set expanded(bool expanded) {
    _expanded = expanded;
    update();
  }

  String get type => _type;

  set type(String type) {
    ///
    _type = type;

    ///
    update();
    EasyLoading.show(status: '加载中');

    ///
    page = 1;
    MasterRankRepository.pl3MasterRanks(
      type: _type,
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      ranks
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(ranks);
      });
    }).catchError((error) {
      showError(error);
    }).whenComplete(() => EasyLoading.dismiss());
  }

  @override
  Future<void> onInitial() async {
    ///
    showLoading();

    ///
    page = 1;

    ///
    Future<void> rankAsync = MasterRankRepository.pl3MasterRanks(
      type: type,
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      ranks
        ..clear()
        ..addAll(value.records);
    });

    ///
    Future<void> gladAsync = MasterGladRepository.pl3GladList(
      limit: 6,
    ).then(
      (value) => glads
        ..clear()
        ..addAll(value.records),
    );

    ///
    await Future.wait([rankAsync, gladAsync]).then((value) {
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(ranks);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {
    ///
    page++;

    ///
    await MasterRankRepository.pl3MasterRanks(
      type: type,
      page: page,
      limit: limit,
    ).then((value) {
      ranks.addAll(value.records);
      update();
    }).catchError((error) {
      page--;
    });
  }

  @override
  Future<void> onRefresh() async {
    ///
    page = 1;

    ///
    await MasterRankRepository.pl3MasterRanks(
      type: type,
      page: page,
      limit: limit,
    ).then((value) {
      total = value.total;
      ranks
        ..clear()
        ..addAll(value.records);
      showSuccess(ranks);
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  void initialBefore() {
    _type = Get.parameters['type']!;
  }
}
