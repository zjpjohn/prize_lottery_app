import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';

///
///
class Futures {
  ///
  /// 异步任务计算
  /// [compute]-异步任务
  /// [success]-成功回调处理
  /// [error]-失败回调处理
  /// [showLoading]-是否显示loading加载
  /// [expectTime]-预期加载时间,单位毫秒
  static Future<void> future<T>({
    required Future<T> compute,
    Function(T)? success,
    Function(dynamic)? error,
    bool showLoading = false,
    int expectTime = 300,
  }) async {
    if (showLoading) {
      EasyLoading.show(status: '加载中');
    }
    int start = DateTime.now().millisecond;
    try {
      T result = await compute;
      int ellipse = DateTime.now().millisecond - start;
      if (ellipse < expectTime) {
        Future.delayed(Duration(milliseconds: expectTime - ellipse), () {
          if (success != null) {
            success(result);
          }
        });
        return;
      }
      if (success != null) {
        success(result);
      }
    } catch (ex) {
      if (error != null) {
        error(ex);
      }
    }
    if (showLoading && EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }
}
