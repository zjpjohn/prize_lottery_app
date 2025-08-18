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
import 'package:prize_lottery_app/views/battle/controller/ssq_battle_controller.dart';
import 'package:prize_lottery_app/views/forecast/controller/ssq_forecast_controller.dart';
import 'package:prize_lottery_app/views/forecast/model/ssq_forecast_info.dart';
import 'package:prize_lottery_app/views/forecast/widgets/forecast_poster_view.dart';
import 'package:prize_lottery_app/widgets/common_widgets.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/forecast_notice.dart';

class SsqForecastView extends StatefulWidget {
  const SsqForecastView({super.key});

  @override
  State<SsqForecastView> createState() => _SsqForecastViewState();
}

class _SsqForecastViewState extends State<SsqForecastView> {
  @override
  Widget build(BuildContext context) {
    return FeeShareRequestWidget<SsqForecastController>(
      global: false,
      background: Colors.white,
      init: SsqForecastController(),
      adsBg: ResourceStore().resource(R.ssqForecastBg),
      adsTitle: '查看双色球预测详情',
      adsName: '预测方案',
      title: '双色球方案',
      share: (controller) {
        _showSharePoster(controller);
      },
      battle: (controller) {
        SsqBattleController().addAndRoute(controller.masterId);
      },
      featureTap: (controller) {
        Get.toNamed(
          '/ssq/master/feature/${controller.masterId}',
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
    SsqForecastController controller,
    SsqForecastInfo forecast,
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
          _buildForecastItem('红球25码', forecast.red25, forecast.red25Hit),
          _buildForecastItem('红球20码', forecast.red20, forecast.red20Hit),
          _buildForecastItem('红球杀三', forecast.redKill3, forecast.rk3Hit),
          _buildForecastItem('红球杀六', forecast.redKill6, forecast.rk6Hit),
          _buildForecastItem('红球12码', forecast.red12, forecast.red12Hit),
          _buildForecastItem('红球双胆', forecast.red2, forecast.red2Hit),
          _buildForecastItem('红球独胆', forecast.red1, forecast.red1Hit),
          _buildForecastItem('蓝球5码', forecast.blue5, forecast.blue5Hit),
          _buildForecastItem('蓝球三胆', forecast.blue3, forecast.blue3Hit),
          _buildForecastItem('蓝球杀码', forecast.blueKill, forecast.bkHit),
        ],
      ),
    );
  }

  Widget _buildTitle(SsqForecastInfo forecast) {
    return Container(
      padding: EdgeInsets.only(bottom: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '第${forecast.period}期预测推荐',
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

  void _showSharePoster(SsqForecastController controller) {
    Constants.shareBottomSheet(
      content: ForecastPosterView(
        posterKey: controller.posterKey,
        title: '双色球第${controller.forecast.period}期',
        forecasts: {
          '红球三胆': ForecastItem(
            forecast: controller.forecast.red3,
            hit: controller.forecast.red3Hit,
          ),
          '红球20码': ForecastItem(
            forecast: controller.forecast.red20,
            hit: controller.forecast.red20Hit,
          ),
          '红球25码': ForecastItem(
            forecast: controller.forecast.red25,
            hit: controller.forecast.red25Hit,
          ),
          '红球杀三': ForecastItem(
            forecast: controller.forecast.redKill3,
            hit: controller.forecast.rk3Hit,
          ),
          '红球杀六': ForecastItem(
            forecast: controller.forecast.redKill6,
            hit: controller.forecast.bkHit,
          ),
          '蓝球五码': ForecastItem(
            forecast: controller.forecast.blue5,
            hit: controller.forecast.blue5Hit,
          ),
          '蓝球杀码': ForecastItem(
            forecast: controller.forecast.blueKill,
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
