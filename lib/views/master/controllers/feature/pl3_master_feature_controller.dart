import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/master/model/master_feature.dart';
import 'package:prize_lottery_app/views/master/repository/master_feature_repository.dart';

class Pl3MasterFeatureController extends AbsRequestController {
  ///
  ///
  late String masterId;

  ///
  late Pl3MasterRate rate;

  ///
  List<Pl3ICaiHit> hits = [];

  @override
  Future<void> request() async {
    ///
    showLoading();

    ///
    Future<void> rateAsync =
        MasterFeatureRepository.pl3MasterRate(masterId).then((value) {
      rate = value;
    });
    Future<void> hitAsync =
        MasterFeatureRepository.pl3MasterHits(masterId).then((value) {
      hits = value;
    });

    ///
    Future.wait([rateAsync, hitAsync]).then((values) {
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(rate);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  void initialBefore() {
    masterId = Get.parameters['masterId']!;
  }
}
