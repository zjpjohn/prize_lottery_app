import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/store/config.dart';
import 'package:prize_lottery_app/utils/storage.dart';
import 'package:prize_lottery_app/views/home/widgets/layer_state_view.dart';
import 'package:prize_lottery_app/views/recom/repository/warning_repository.dart';

const String layerStateKey = 'num3_layer_';

class LayerState {
  ///
  late String period;

  //0-未知，1-命中,2-更新
  late int state;

  ///命中显示弹层次数
  late int count;

  LayerState.empty() {
    period = '';
    state = 0;
    count = 0;
  }

  LayerState.fromJson(Map<dynamic, dynamic> json) {
    period = json['period'];
    state = json['state'];
    count = json['count'];
  }

  LayerState({required this.period, required this.state, this.count = 0});

  Map<String, dynamic> toJson() {
    return {
      'period': period,
      'state': state,
      'count': count,
    };
  }
}

class LayerStateController extends GetxController {
  ///
  static LayerStateController? _instance;

  factory LayerStateController() {
    LayerStateController._instance ??=
        Get.put(LayerStateController._initialize(), permanent: true);
    return LayerStateController._instance!;
  }

  LayerStateController._initialize();

  Future<LayerState> layerHomeState(int duration) async {
    try {
      return await WarnRecommendRepository.num3LayerState('fc3d').then((data) {
        LayerState layerState =
            LayerState(period: data.period, state: data.state);
        if (ConfigStore().intro > 3 && layerState.state == 2) {
          ///展示更新内容弹层
          showModifiedHint(type: 'fc3d', duration: duration);
        }
        return layerState;
      });
    } catch (error) {
      return LayerState.empty();
    }
  }

  Future<LayerState> layerState({
    required String type,
    int duration = 800,
  }) async {
    try {
      return await WarnRecommendRepository.num3LayerState(type).then((data) {
        LayerState layerState =
            LayerState(period: data.period, state: data.state);
        String key = '$layerStateKey$type';
        int count = _calcSuccessCount(layerState, key);
        if (layerState.state == 1) {
          count = count + 1;

          ///最多展示4次命中提示弹层
          if (count <= 4) {
            showSuccessHint(duration);
          }
        } else if (layerState.state == 2) {
          ///展示更新内容弹层
          showModifiedHint(type: type, duration: duration);
        }
        LayerState stored = LayerState(
          period: layerState.period,
          state: layerState.state,
          count: count,
        );
        Storage().putObject(key, stored);
        return layerState;
      });
    } catch (error) {
      return LayerState.empty();
    }
  }

  int _calcSuccessCount(LayerState layerState, String key) {
    int count = 0;
    if (layerState.state == 1) {
      LayerState? exist = Storage().getObj(key, (v) => LayerState.fromJson(v));
      if (exist != null &&
          exist.period == layerState.period &&
          exist.state == layerState.state) {
        count = exist.count;
      }
    }
    return count;
  }

  void showSuccessHint(int duration) {
    Future.delayed(Duration(milliseconds: duration), () {
      showDialog(
          context: Get.context!,
          builder: (context) {
            return const LayerSuccessView(duration: 3000);
          });
    });
  }

  void showModifiedHint({required String type, required int duration}) {
    Future.delayed(Duration(milliseconds: duration), () {
      showDialog(
          context: Get.context!,
          builder: (context) {
            return LayerModifiedView(type: type);
          });
    });
  }
}
