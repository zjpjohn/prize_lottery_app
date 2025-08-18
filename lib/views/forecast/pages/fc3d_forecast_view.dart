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
import 'package:prize_lottery_app/views/battle/controller/fc3d_battle_controller.dart';
import 'package:prize_lottery_app/views/forecast/controller/fc3d_forecast_controller.dart';
import 'package:prize_lottery_app/views/forecast/model/fc3d_forecast_info.dart';
import 'package:prize_lottery_app/views/forecast/widgets/forecast_poster_view.dart';
import 'package:prize_lottery_app/widgets/common_widgets.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/forecast_notice.dart';

class Fc3dForecastView extends StatefulWidget {
  const Fc3dForecastView({super.key});

  @override
  State<Fc3dForecastView> createState() => _Fc3dForecastViewState();
}

class _Fc3dForecastViewState extends State<Fc3dForecastView> {
  @override
  Widget build(BuildContext context) {
    return FeeShareRequestWidget<Fc3dForecastController>(
      global: false,
      background: Colors.white,
      init: Fc3dForecastController(),
      adsBg: ResourceStore().resource(R.fc3dForecastBg),
      adsTitle: '查看福彩3D预测详情',
      adsName: '预测方案',
      title: '福彩3D方案',
      share: (controller) {
        _showSharePoster(controller);
      },
      battle: (controller) {
        Fc3dBattleController().addAndRoute(controller.masterId);
      },
      featureTap: (controller) {
        Get.toNamed(
          '/fc3d/master/feature/${controller.masterId}',
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
      Fc3dForecastController controller, Fc3dForecastInfo forecast) {
    return Container(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 20.w,
      ),
      child: Column(
        children: [
          _buildTitle(forecast),
          _buildForecastItem('定三胆', forecast.dan3, forecast.dan3Hit),
          _buildForecastItem('组选七码', forecast.com7, forecast.com7Hit),
          _buildForecastItem('杀一码', forecast.kill1, forecast.kill1Hit),
          _buildForecastItem('杀二码', forecast.kill2, forecast.kill2Hit),
          _buildForecastItem('组选六码', forecast.com6, forecast.com6Hit),
          _buildForecastItem('组选五码', forecast.com5, forecast.com5Hit),
          _buildForecastItem('定位四码', forecast.comb4, forecast.comb4Hit),
          _buildForecastItem('定位五码', forecast.comb5, forecast.comb5Hit),
          _buildForecastItem('定双胆', forecast.dan2, forecast.dan2Hit),
          _buildForecastItem('定独胆', forecast.dan1, forecast.dan1Hit),
        ],
      ),
    );
  }

  Widget _buildTitle(Fc3dForecastInfo forecast) {
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
            forecast.dan1.opened == 0 ? '(未开奖)' : '(已开奖)',
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

  void _showSharePoster(Fc3dForecastController controller) {
    Constants.shareBottomSheet(
      content: ForecastPosterView(
        posterKey: controller.posterKey,
        title: '福彩3D第${controller.forecast.period}期',
        forecasts: {
          '杀一码': ForecastItem(
            forecast: controller.forecast.kill1,
            hit: controller.forecast.kill1Hit,
          ),
          '杀二码': ForecastItem(
            forecast: controller.forecast.kill2,
            hit: controller.forecast.kill2Hit,
          ),
          '定双胆': ForecastItem(
            forecast: controller.forecast.dan2,
            hit: controller.forecast.dan2Hit,
          ),
          '定三胆': ForecastItem(
            forecast: controller.forecast.dan3,
            hit: controller.forecast.dan3Hit,
          ),
          '选五码': ForecastItem(
            forecast: controller.forecast.com5,
            hit: controller.forecast.com5Hit,
          ),
          '选六码': ForecastItem(
            forecast: controller.forecast.com6,
            hit: controller.forecast.com6Hit,
          ),
          '选七码': ForecastItem(
            forecast: controller.forecast.com7,
            hit: controller.forecast.com7Hit,
          ),
          '定位五码': ForecastItem(
            forecast: controller.forecast.comb5,
            hit: controller.forecast.comb5Hit,
          ),
        },
      ),
      save: () {
        PosterUtils.saveImage(controller.posterKey);
      },
    );
  }
}
