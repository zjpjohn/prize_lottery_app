import 'package:prize_lottery_app/base/controller/page_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/kl8_omit_census.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

class Kl8TailMatrixController extends AbsPageQueryController {
  ///
  ///遗漏数据
  List<Kl8BaseOmit> omits = [];
  int page = 1, limit = 4, total = 0;

  @override
  Future<void> onInitial() async {
    showLoading();
    page = 1;
    LotteryInfoRepository.kl8BaseOmits(page: page, limit: limit).then((value) {
      total = value.total;
      omits
        ..clear()
        ..addAll(value.records);
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(omits);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  Future<void> onLoadMore() async {
    page++;
    LotteryInfoRepository.kl8BaseOmits(page: page, limit: limit).then((value) {
      omits.addAll(value.records);
      Future.delayed(const Duration(milliseconds: 200), () {
        update();
      });
    }).catchError((error) {
      page--;
      showError(error);
    });
  }

  @override
  Future<void> onRefresh() async {
    page = 1;
    LotteryInfoRepository.kl8BaseOmits(page: page, limit: limit).then((value) {
      total = value.total;
      omits
        ..clear()
        ..addAll(value.records);
      showSuccess(omits);
    }).catchError((error) {
      showError(error);
    });
  }
}
