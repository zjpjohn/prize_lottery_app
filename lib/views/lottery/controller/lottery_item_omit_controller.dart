import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/lottery/model/lottery_omit.dart';
import 'package:prize_lottery_app/views/lottery/model/n3_omit_census.dart';
import 'package:prize_lottery_app/views/lottery/repository/lottery_info_repository.dart';

class LotteryItemOmitController extends AbsRequestController {
  ///
  late String type;
  int _size = 50;

  LotteryItemOmitController(this.type);

  ///遗漏数据
  List<LotteryItemOmit> omits = [];

  int get size => _size;

  set size(int value) {
    if (_size == value) {
      return;
    }
    _size = value;
    update();
    request();
  }

  MapEntry<ItemOmitCensus, List<CbItemOmit>> cbOmits(int type) {
    List<CbItemOmit> values =
        omits.map((e) => CbItemOmit.from(type, e)).toList();
    ItemOmitCensus census = ItemOmitCensus(values);
    return MapEntry(census, values);
  }

  @override
  Future<void> request() async {
    showLoading();
    LotteryInfoRepository.itemOmits(type, size).then((data) {
      omits = data;
      omits.sort((e1, e2) => e1.period.compareTo(e2.period));
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(omits);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
