import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/controller/fee_request_controller.dart';
import 'package:prize_lottery_app/views/forecast/model/ssq_forecast_info.dart';
import 'package:prize_lottery_app/views/forecast/repository/forecast_info_repository.dart';

class SsqForecastController extends AbsFeeRequestController {
  ///
  late GlobalKey posterKey;

  ///
  late SsqForecastInfo forecast;

  ///
  late String masterId;

  @override
  Future<void> request() async {
    showLoading();
    ForecastInfoRepository.ssqForecast(masterId).then((value) {
      feeBrowse = false;
      forecast = value..calcValue();
      Future.delayed(const Duration(milliseconds: 200), () {
        showSuccess(forecast);
      });
    }).catchError((error) {
      showError(error, handle: showFee);
    });
  }

  @override
  void initialBefore() {
    masterId = Get.parameters['masterId']!;
    posterKey = GlobalKey();
  }

}
