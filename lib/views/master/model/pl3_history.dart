import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/forecast/model/pl3_forecast_info.dart';

class Pl3History extends Pl3ForecastInfo {
  ///
  late String red;
  List<String> reds = [];

  Pl3History.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    red = json['red'] ?? '';
    reds = Tools.split(red.trim());
  }
}
