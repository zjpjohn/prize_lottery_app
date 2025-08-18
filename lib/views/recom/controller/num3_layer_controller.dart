import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/base/model/fee_data_result.dart';
import 'package:prize_lottery_app/utils/poster_util.dart';
import 'package:prize_lottery_app/utils/screen_protect.dart';
import 'package:prize_lottery_app/views/recom/model/num3_layer_filter.dart';
import 'package:prize_lottery_app/views/recom/repository/warning_repository.dart';
import 'package:screenshot/screenshot.dart';

class Num3LayerController extends AbsRequestController {
  ///
  /// 组件截图控制器
  final ScreenshotController screenshotController = ScreenshotController();

  /// 彩票类型
  late String type;

  ///当前预警数据
  late FeeDataResult<Num3Layer> layer;

  ///缓存预警数据
  Map<String, FeeDataResult<Num3Layer>> results = {};

  ///推荐期号集合
  List<String> periods = [];

  ///当前期号
  String? _period;

  ///期号下标
  int current = 0;

  String get title {
    return '${type == 'fc3d' ? '福彩3D' : '排列三'}${layer.period}期选号预警分析';
  }

  String? get period => _period;

  bool isFirst() {
    if (periods.isNotEmpty) {
      return current >= periods.length - 1;
    }
    return true;
  }

  bool isEnd() {
    return current <= 0;
  }

  void prevPeriod() {
    if (isFirst()) {
      return;
    }
    current = current + 1;
    period = periods[current];
  }

  void nextPeriod() {
    if (isEnd()) {
      return;
    }
    current = current - 1;
    period = periods[current];
  }

  set period(String? period) {
    if (period == null || _period == period) {
      return;
    }
    _period = period;
    if (results[_period] != null) {
      layer = results[_period]!;
    }
    update();
    if (results[_period] == null) {
      EasyLoading.show(status: '加载中');
      WarnRecommendRepository.num3Layer(
        type: type,
        period: _period,
      ).then((value) {
        layer = value;
        update();
        if (!layer.feeRequired) {
          results[layer.period] = value;
        }
      }).catchError((error) {
        showError(error);
      }).whenComplete(() => EasyLoading.dismiss());
    }
  }

  List<Future<void>> asyncTasks() {
    return [
      WarnRecommendRepository.num3Layer(type: type, period: _period)
          .then((value) {
        layer = value;
        if (!value.feeRequired) {
          results[value.period] = value;
        }
        if (layer.period.isNotEmpty) {
          _period = layer.period;
        }
      }),
      WarnRecommendRepository.num3LayerPeriods(type).then((value) {
        periods = value;
        if (periods.isNotEmpty) {
          _period = periods[0];
        }
      }),
    ];
  }

  void saveCaptureWidget(Widget Function() callback) async {
    try {
      if (!await PosterUtils.storagePermission()) {
        EasyLoading.showError('没有权限哟');
        return;
      }
      EasyLoading.show();
      Uint8List image =
          await screenshotController.captureFromWidget(callback());
      await ImageGallerySaver.saveImage(image, quality: 100);
      Future.delayed(const Duration(milliseconds: 250), () {
        EasyLoading.showToast(
          '保存成功，请去相册查看',
          duration: const Duration(milliseconds: 1500),
        );
      });
    } catch (error) {
      EasyLoading.showError('保存图片失败');
    }
  }

  @override
  Future<void> request() async {
    showLoading();
    Future.wait(asyncTasks()).then((_) {
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(true);
      });
    }).catchError((error) {
      showError(error);
    });
  }

  @override
  void initialBefore() {
    type = Get.parameters['type']!;

    ///开启数据保护
    ScreenProtect.protectOn();
  }

  @override
  void onClose() {
    super.onClose();

    ///关闭数据保护
    ScreenProtect.protectOff();
  }
}
