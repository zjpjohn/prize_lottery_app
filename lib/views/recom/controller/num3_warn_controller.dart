import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/base/model/fee_data_result.dart';
import 'package:prize_lottery_app/utils/poster_util.dart';
import 'package:prize_lottery_app/utils/screen_protect.dart';
import 'package:prize_lottery_app/views/recom/model/n3_warn_recommend.dart';
import 'package:prize_lottery_app/views/recom/repository/warning_repository.dart';

class Num3WarnController extends AbsRequestController {
  ///
  /// 组件截图控制器
  final ScreenshotController screenshotController = ScreenshotController();

  /// 彩票类型
  late String type;

  ///当前预警数据
  late FeeDataResult<Num3ComWarn> recommend;

  ///缓存预警数据
  Map<String, FeeDataResult<Num3ComWarn>> results = {};

  ///推荐期号集合
  List<String> periods = [];

  ///当前期号
  String? _period;

  ///期号下标
  int current = 0;

  String get title {
    String title = '${type == 'fc3d' ? '福彩3D' : '排列三'}选号预警分析：';
    if (recommend.data != null &&
        recommend.data!.lastHit != null &&
        recommend.data!.lastHit!.value != 0) {
      ///上期命中情况
      title = '$title上期选号预警分析${recommend.data!.lastHit!.description}，';
    }

    ///本期数据为空或未开奖
    if (recommend.data == null ||
        recommend.data!.hit == null ||
        recommend.data!.hit!.value == 0) {
      return '$title${recommend.period}期将再接再厉!';
    }

    ///本期已开奖
    return '$title${recommend.period}期预警分析${recommend.data!.hit!.description}';
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
      recommend = results[_period]!;
    }
    update();
    if (results[_period] == null) {
      EasyLoading.show(status: '加载中');
      WarnRecommendRepository.num3ComWarn(
        type: type,
        period: _period,
      ).then((value) {
        recommend = value;
        update();
        if (!recommend.feeRequired) {
          results[recommend.period] = value;
        }
      }).catchError((error) {
        showError(error);
      }).whenComplete(() => EasyLoading.dismiss());
    }
  }

  List<Future<void>> asyncTasks() {
    return [
      WarnRecommendRepository.num3ComWarn(type: type, period: _period)
          .then((value) {
        recommend = value;
        if (!value.feeRequired) {
          results[value.period] = value;
        }
        if (recommend.period.isNotEmpty) {
          _period = recommend.period;
        }
      }),
      WarnRecommendRepository.num3WarnPeriod(type).then((value) {
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
