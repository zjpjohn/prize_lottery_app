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
import 'package:prize_lottery_app/views/battle/controller/dlt_battle_controller.dart';
import 'package:prize_lottery_app/views/forecast/controller/dlt_forecast_controller.dart';
import 'package:prize_lottery_app/views/forecast/model/dlt_forecast_info.dart';
import 'package:prize_lottery_app/views/forecast/widgets/forecast_poster_view.dart';
import 'package:prize_lottery_app/widgets/common_widgets.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/forecast_notice.dart';

class DltForecastView extends StatefulWidget {
  const DltForecastView({super.key});

  @override
  State<DltForecastView> createState() => _DltForecastViewState();
}

class _DltForecastViewState extends State<DltForecastView> {
  @override
  Widget build(BuildContext context) {
    return FeeShareRequestWidget<DltForecastController>(
      global: false,
      background: Colors.white,
      init: DltForecastController(),
      adsBg: ResourceStore().resource(R.dltForecastBg),
      adsTitle: '查看大乐透预测详情',
      adsName: '方案详情',
      title: '大乐透方案',
      share: (controller) {
        _showSharePoster(controller);
      },
      battle: (controller) {
        DltBattleController().addAndRoute(controller.masterId);
      },
      featureTap: (controller) {
        Get.toNamed(
          '/dlt/master/feature/${controller.masterId}',
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
    DltForecastController controller,
    DltForecastInfo forecast,
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
          _buildForecastItem('红球三胆', forecast.red3, forecast.red3Hit),
          _buildForecastItem('红球20码', forecast.red20, forecast.red20Hit),
          _buildForecastItem('红球杀三', forecast.redKill3, forecast.rk3Hit),
          _buildForecastItem('红球杀六', forecast.redKill6, forecast.rk6Hit),
          _buildForecastItem('红球10码', forecast.red10, forecast.red10Hit),
          _buildForecastItem('红球双胆', forecast.red2, forecast.red2Hit),
          _buildForecastItem('红球独胆', forecast.red1, forecast.red1Hit),
          _buildForecastItem('蓝球独胆', forecast.blue1, forecast.blue1Hit),
          _buildForecastItem('蓝球双胆', forecast.blue2, forecast.blue2Hit),
          _buildForecastItem('蓝球6码', forecast.blue6, forecast.blue6Hit),
          _buildForecastItem('蓝球杀码', forecast.blueKill3, forecast.bkHit),
        ],
      ),
    );
  }

  Widget _buildTitle(DltForecastInfo forecast) {
    return Container(
      padding: EdgeInsets.only(bottom: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '第${forecast.period}期预测方案',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16.sp,
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
      padding: EdgeInsets.only(bottom: 12.w),
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
            padding: EdgeInsets.only(left: 12.w, top: 8.w),
            child: Wrap(
              children: value.dataViews(),
            ),
          ),
        ],
      ),
    );
  }

  void _showSharePoster(DltForecastController controller) {
    Constants.shareBottomSheet(
      content: ForecastPosterView(
        posterKey: controller.posterKey,
        title: '大乐透第${controller.forecast.period}期',
        forecasts: {
          '红球三胆': ForecastItem(
            forecast: controller.forecast.red3,
            hit: controller.forecast.red3Hit,
          ),
          '红球10码': ForecastItem(
            forecast: controller.forecast.red10,
            hit: controller.forecast.red10Hit,
          ),
          '红球20码': ForecastItem(
            forecast: controller.forecast.red20,
            hit: controller.forecast.red20Hit,
          ),
          '红球杀三': ForecastItem(
            forecast: controller.forecast.redKill3,
            hit: controller.forecast.rk3Hit,
          ),
          '红球杀六': ForecastItem(
            forecast: controller.forecast.redKill6,
            hit: controller.forecast.rk6Hit,
          ),
          '篮球双胆': ForecastItem(
            forecast: controller.forecast.blue2,
            hit: controller.forecast.blue2Hit,
          ),
          '篮球六码': ForecastItem(
            forecast: controller.forecast.blue6,
            hit: controller.forecast.blue6Hit,
          ),
          '篮球杀码': ForecastItem(
            forecast: controller.forecast.blueKill3,
            hit: controller.forecast.bkHit,
          ),
        },
      ),
      save: () {
        PosterUtils.saveImage(controller.posterKey);
      },
    );
  }
}
