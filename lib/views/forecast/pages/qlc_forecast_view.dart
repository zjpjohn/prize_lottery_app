import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/model/forecast_value.dart';
import 'package:prize_lottery_app/base/model/stat_hit_value.dart';
import 'package:prize_lottery_app/base/widgets/fee_share_request_widget.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/store/resource.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/utils/poster_util.dart';
import 'package:prize_lottery_app/views/battle/controller/qlc_battle_controller.dart';
import 'package:prize_lottery_app/views/forecast/controller/qlc_forecast_controller.dart';
import 'package:prize_lottery_app/views/forecast/model/qlc_forecast_info.dart';
import 'package:prize_lottery_app/views/forecast/widgets/forecast_poster_view.dart';
import 'package:prize_lottery_app/widgets/common_widgets.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/forecast_notice.dart';

class QlcForecastView extends StatefulWidget {
  const QlcForecastView({super.key});

  @override
  State<QlcForecastView> createState() => _QlcForecastViewState();
}

class _QlcForecastViewState extends State<QlcForecastView> {
  @override
  Widget build(BuildContext context) {
    return FeeShareRequestWidget<QlcForecastController>(
      global: false,
      background: Colors.white,
      init: QlcForecastController(),
      adsBg: ResourceStore().resource(R.qlcForecastBg),
      adsTitle: '查看七乐彩预测详情',
      adsName: '方案详情',
      title: '七乐彩方案',
      share: (controller) {
        _showSharePoster(controller);
      },
      battle: (controller) {
        QlcBattleController().addAndRoute(controller.masterId);
      },
      featureTap: (controller) {
        Get.toNamed(
          '/qlc/master/feature/${controller.masterId}',
        );
      },
      builder: (controller) {
        return ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildForecastCard(controller, controller.forecast),
                const ForecastNotice(),
                SizedBox(height: 24.w),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildForecastCard(
    QlcForecastController controller,
    QlcForecastInfo forecast,
  ) {
    return Container(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 20.w,
      ),
      child: Column(
        children: [
          _buildTitle(forecast),
          _buildForecastItem('定三胆', forecast.red3, forecast.red3Hit),
          _buildForecastItem('杀三码', forecast.kill3, forecast.kill3Hit),
          _buildForecastItem('杀六码', forecast.kill6, forecast.kill6Hit),
          _buildForecastItem('选12码', forecast.red12, forecast.red12Hit),
          _buildForecastItem('选18码', forecast.red18, forecast.red18Hit),
          _buildForecastItem('选22码', forecast.red22, forecast.red22Hit),
          _buildForecastItem('定双胆', forecast.red2, forecast.red2Hit),
          _buildForecastItem('定独胆', forecast.red1, forecast.red1Hit),
        ],
      ),
    );
  }

  Widget _buildTitle(QlcForecastInfo forecast) {
    return Container(
      padding: EdgeInsets.only(bottom: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '第${forecast.period}期预测方案',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black87,
            ),
          ),
          Text(
            forecast.red1.opened == 0 ? '(未开奖)' : '(已开奖)',
            style: TextStyle(
              color: Colors.black38,
              fontSize: 14.sp,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildForecastItem(
      String title, ForecastValue value, StatHitValue? hit) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(bottom: 14.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black87,
                ),
              ),
              ...CommonWidgets.statHitViews(hit),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.w, top: 10.w),
            child: Wrap(
              children: value.dataViews(),
            ),
          ),
        ],
      ),
    );
  }

  void _showSharePoster(QlcForecastController controller) {
    Constants.shareBottomSheet(
      content: ForecastPosterView(
        posterKey: controller.posterKey,
        title: '七乐彩第${controller.forecast.period}期',
        forecasts: {
          '双胆': ForecastItem(
            forecast: controller.forecast.red2,
            hit: controller.forecast.red2Hit,
          ),
          '三胆': ForecastItem(
            forecast: controller.forecast.red3,
            hit: controller.forecast.red3Hit,
          ),
          '12码': ForecastItem(
            forecast: controller.forecast.red12,
            hit: controller.forecast.red12Hit,
          ),
          '18码': ForecastItem(
            forecast: controller.forecast.red18,
            hit: controller.forecast.red18Hit,
          ),
          '22码': ForecastItem(
            forecast: controller.forecast.red22,
            hit: controller.forecast.red22Hit,
          ),
          '杀三码': ForecastItem(
            forecast: controller.forecast.kill3,
            hit: controller.forecast.kill3Hit,
          ),
          '杀六码': ForecastItem(
            forecast: controller.forecast.kill6,
            hit: controller.forecast.kill6Hit,
          ),
        },
      ),
      save: () {
        PosterUtils.saveImage(controller.posterKey);
      },
    );
  }
}
