import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/forecast/model/fc3d_forecast_info.dart';

class Fc3dHistory extends Fc3dForecastInfo {
  ///
  late String red;

  ///
  List<String> reds = [];

  Fc3dHistory.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    red = json['red'] ?? '';
    reds = Tools.split(red.trim());
  }
}
