import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/forecast/model/ssq_forecast_info.dart';

class SsqHistory extends SsqForecastInfo {
  ///
  late String red;
  List<String> reds = [];

  ///
  late String blue;
  List<String> blues = [];

  SsqHistory.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    red = json['red'] ?? '';
    reds = Tools.split(red.trim());
    blue = json['blue'] ?? '';
    blues = Tools.split(blue.trim());
  }
}
