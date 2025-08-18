import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/fee_request_controller.dart';
import 'package:prize_lottery_app/env/log_profile.dart';
import 'package:prize_lottery_app/views/forecast/model/fc3d_forecast_info.dart';
import 'package:prize_lottery_app/views/forecast/repository/forecast_info_repository.dart';

class Fc3dForecastController extends AbsFeeRequestController {
  ///
  late GlobalKey posterKey;

  ///
  late Fc3dForecastInfo forecast;

  ///专家标识
  late String masterId;

  @override
  Future<void> request() async {
    showLoading();
    ForecastInfoRepository.fc3dForecast(masterId).then((value) {
      feeBrowse = false;
      forecast = value..calcValue();
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(forecast);
      });
    }).catchError((error) {
      logger.e(error);
      showError(error, handle: showFee);
    });
  }

  @override
  void initialBefore() {
    masterId = Get.parameters['masterId']!;
    posterKey = GlobalKey();
  }

}
