import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/model/request_state.dart';
import 'package:prize_lottery_app/env/log_profile.dart';
import 'package:prize_lottery_app/utils/request.dart';

typedef ResponseErrorHandle = bool Function(ResponseError error);

///
/// 分页请求controller
abstract class AbsPageQueryController extends GetxController {
  ///
  /// 刷新控制器
  EasyRefreshController refreshController = EasyRefreshController();

  ///
  ScrollController? scrollController;

  ///
  ///请求状态
  RequestState state = RequestState.loading;

  ///
  /// 请求错误消息
  String message = '系统出错啦';

  ///
  /// 当前方法是否正在请求
  bool requesting = false;

  ///
  /// 是否显示指定组件
  bool _showTop = false;

  ///
  /// 指定组件距底部距离
  double _topOffset = 0.0;

  ///
  /// 是否已加载全部
  bool loadedAll() {
    return false;
  }

  set showTop(bool value) {
    _showTop = value;
    update();
  }

  bool get showTop => _showTop;

  set topOffset(double value) {
    _topOffset = value;
    update();
  }

  double get topOffset => _topOffset;

  ///
  /// 监听外部滚动器
  void scrollListener(
      ScrollController controller, double throttle, double offset) {
    if (scrollController == null || scrollController != controller) {
      scrollController = controller;
      scrollController!.addListener(() {
        if (scrollController!.positions.elementAt(0).pixels < throttle) {
          if (topOffset > 0) {
            topOffset = 0;
          }
          return;
        }
        if (!showTop || topOffset == 0) {
          showTop = true;
          Future.delayed(const Duration(milliseconds: 30), () {
            topOffset = offset;
          });
        }
      });
    }
  }

  ///
  /// 返回成功
  ///
  void showSuccess(List res) {
    state = res.isNotEmpty ? RequestState.success : RequestState.empty;
    update();
  }

  ///
  /// 显示加载中
  ///
  void showLoading() {
    state = RequestState.loading;
    update();
  }

  ///
  /// 显示返回错误
  ///
  void showError(dynamic error, {ResponseErrorHandle? handle}) async {
    if (error == null) {
      return;
    }
    if (error is DioException) {
      ResponseError respError = error.error as ResponseError;
      if (handle != null && handle(respError)) {
        return;
      }
      message = respError.message;
    }
    state = RequestState.error;
    update();
  }

  ///
  /// 初始加载数据
  ///
  Future<void> onInitial();

  ///
  /// 刷新数据
  ///
  Future<void> onRefresh();

  ///
  /// 加载更多数据
  ///
  Future<void> onLoadMore();

  Future<void> refreshing() async {
    if (requesting) {
      return;
    }
    requesting = true;
    try {
      await onRefresh();
    } catch (error) {
      logger.e('refresh data error.', error: error);
    } finally {
      requesting = false;
    }
  }

  Future<void> loadMore() async {
    if (requesting) {
      return;
    }
    requesting = true;
    try {
      await onLoadMore();
    } catch (error) {
      logger.e('load more data error.', error: error);
    } finally {
      requesting = false;
    }
  }

  ///
  /// 前置初始化
  void initialBefore() {}

  @override
  void onInit() {
    ///
    ///
    initialBefore();

    ///
    ///
    super.onInit();

    ///
    /// 初始化
    onInitial();
  }
}
