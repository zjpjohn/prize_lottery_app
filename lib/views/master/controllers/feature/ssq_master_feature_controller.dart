import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/views/master/model/master_feature.dart';
import 'package:prize_lottery_app/views/master/repository/master_feature_repository.dart';

class SsqMasterFeatureController extends AbsRequestController {
  ///
  ///
  late String masterId;

  ///
  late SsqMasterRate rate;

  ///
  List<SsqICaiHit> hits = [];

  @override
  Future<void> request() async {
    ///
    showLoading();

    ///
    Future<void> rateAsync =
        MasterFeatureRepository.ssqMasterRate(masterId).then((value) {
      rate = value;
    });
    Future<void> hitAsync =
        MasterFeatureRepository.ssqMasterHits(masterId).then((value) {
      hits = value;
    });

    ///
    Future.wait([rateAsync, hitAsync]).then((_) {
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

