import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/model/request_state.dart';
import 'package:prize_lottery_app/utils/request.dart';

typedef ResponseErrorHandle = bool Function(ResponseError error);

///
/// 请求组件controller
abstract class AbsRequestController extends GetxController {
  ///
  /// 请求状态
  RequestState state = RequestState.loading;

  ///错误消息
  String message = '系统出错啦';

  ///显示组件透明度
  double opacity = 0;

  AbsRequestController();

  bool get success {
    return state == RequestState.success;
  }

  ///
  /// 显示返回成功
  void showSuccess(dynamic data, {Function? success}) {
    bool empty = _isEmpty(data);
    state = empty ? RequestState.empty : RequestState.success;
    update();
    if (state == RequestState.success && success != null) {
      success();
    }
    opacityShow();
  }

  bool _isEmpty(dynamic data) {
    if (data == null) {
      return true;
    }
    if (data is List || data is Set || data is Map) {
      return data.length == 0;
    }
    if (data is bool) {
      return !data;
    }
    return false;
  }

  ///
  /// 显示返回失败
  ///
  void showError(dynamic error, {ResponseErrorHandle? handle}) {
    if (error != null && error is DioException) {
      ResponseError respError = error.error as ResponseError;
      if (handle != null && handle(respError)) {
        update();
        opacityShow();
        return;
      }
      message = respError.message;
    }
    state = RequestState.error;
    update();

    ///
    opacityShow();
  }

  void opacityShow() {
    Future.delayed(const Duration(milliseconds: 10), () {
      opacity = 1;
      update();
    });
  }

  ///
  /// 显示加载中
  void showLoading() {
    state = RequestState.loading;
    opacity = 0;
    update();
  }

  ///
  /// 重试加载数据
  void reload() {
    showLoading();
    request();
  }

  ///
  /// 请求数据
  Future<void> request();

  ///
  /// 前置初始化
  void initialBefore() {}

  ///
  /// 请求数据前
  void readyBefore() {}

  @override
  void onReady() {
    ///
    readyBefore();

    ///
    super.onReady();

    ///
    showLoading();

    /// 请求数据
    request();
  }

  @override
  void onInit() {
    ///前置初始化
    initialBefore();

    ///
    super.onInit();
  }

}
