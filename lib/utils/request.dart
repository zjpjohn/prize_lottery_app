import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide FormData, Response;
import 'package:prize_lottery_app/env/env_profile.dart';
import 'package:prize_lottery_app/env/log_profile.dart';
import 'package:prize_lottery_app/store/user.dart';

class HttpRequest {
  ///aes加密header key
  ///
  static const aesHeader = 'web-enc-ivr';

  ///auth授权登录header
  ///
  static const authHeader = 'authentication';

  ///dio实例
  late Dio _dio;

  ///初始化请求
  static HttpRequest? _instance;

  factory HttpRequest() {
    HttpRequest._instance ??= HttpRequest._internal();
    return HttpRequest._instance!;
  }

  HttpRequest._internal() {
    _dio = Dio(
      BaseOptions(
        ///请求base url
        baseUrl: Profile.props.baseUri,

        ///连接超时时间
        connectTimeout: const Duration(seconds: 25),

        ///响应超时时间
        receiveTimeout: const Duration(seconds: 25),

        ///响应数据格式
        responseType: ResponseType.json,
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) {
        ///
        /// 将授权token放入header中
        String token = UserStore().authToken;
        if (token.isNotEmpty) {
          options.headers[authHeader] = token;
        }

        ///请求request拦截处理
        return handler.next(options);
      }, onResponse: (response, handler) {
        ///响应数据
        Map<String, dynamic> data = response.data;

        ///业务异常处理
        if (data['code'] != 200) {
          return handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              error: ResponseError(
                code: data['code'],
                data: data['data'],
                message: data['error'] ?? '',
                path: response.requestOptions.path,
              ),
            ),
          );
        }

        ///响应response结果拦截处理
        responseHandle(response);

        return handler.next(response);
      }, onError: (error, handler) {
        ///错误处理
        onError(error, handler);
      }),
    );
  }

  ///响应处理
  ///
  void responseHandle(Response response) {
    String? encoder = response.headers.value(aesHeader);
    if (encoder != null) {
      Uint8List data = encrypt.Encrypted.fromBase64(encoder).bytes;
      Uint8List keyBytes = data.sublist(0, 24),
          ivrBytes = data.sublist(24, data.length);
      String content = utf8.decode(
        encrypt
            .AES(
              encrypt.Key(keyBytes),
              mode: encrypt.AESMode.cbc,
              padding: 'PKCS7',
            )
            .decrypt(
              encrypt.Encrypted.fromBase64(response.data['data']),
              iv: encrypt.IV(ivrBytes),
            ),
      );
      response.data['data'] = json.decode(content);
    }
  }

  ResponseError createError(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:

        ///请求取消
        return ResponseError(
          code: -1,
          message: '请求取消',
          path: error.requestOptions.path,
        );
      case DioExceptionType.connectionTimeout:

        ///连接超时
        return ResponseError(
          code: -1,
          message: '连接超时',
          path: error.requestOptions.path,
        );
      case DioExceptionType.receiveTimeout:

        ///响应超时
        return ResponseError(
          code: -1,
          message: '响应超时',
          path: error.requestOptions.path,
        );
      case DioExceptionType.connectionError || DioExceptionType.badCertificate:
        return ResponseError(
          code: -1,
          message: '连接错误',
          path: error.requestOptions.path,
        );
      case DioExceptionType.sendTimeout:

        ///请求超时
        return ResponseError(
          code: -1,
          message: '请求超时',
          path: error.requestOptions.path,
        );
      case DioExceptionType.badResponse:

        ///后端响应错误消息
        return ResponseError.fromResp(error.response!);
      case DioExceptionType.unknown:

        ///网络错误
        if (error.error is SocketException) {
          return ResponseError(
            code: -1,
            message: '网络异常',
            path: error.requestOptions.path,
          );
        }

        /// 后端业务错误
        if (error.error is ResponseError) {
          return error.error as ResponseError;
        }

        ///默认处理
        return ResponseError(
          code: -1,
          message: '请求错误',
          path: error.requestOptions.path,
        );
    }
  }

  ///
  /// 错误异常处理
  void onError(DioException error, ErrorInterceptorHandler handle) {
    logger.e(error);

    ///
    ///错误拦截处理
    ResponseError responseError = createError(error);
    logger.e('response error.', error: responseError);

    ///
    ///接口鉴权失败
    if (responseError.code == 401) {
      ///
      ///清除本地登录授权信息重新登录
      UserStore().removeLocalAuth();
    }

    ///
    /// 抛出异常
    handle.next(
      DioException(
        requestOptions: error.requestOptions,
        error: responseError,
      ),
    );
  }

  ///
  ///GET 请求
  Future<ResponseEntity> get(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio
        .get(
          path,
          queryParameters: params,
          cancelToken: cancelToken,
          options: options ?? Options(),
        )
        .then((value) => ResponseEntity.from(value.data));
  }

  ///
  ///POST FORM 请求
  Future<ResponseEntity> post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) {
    options ??= Options();
    options.contentType = Headers.formUrlEncodedContentType;
    return _dio
        .post(path,
            data: data,
            cancelToken: cancelToken,
            queryParameters: params,
            options: options)
        .then((value) => ResponseEntity.from(value.data));
  }

  ///
  ///POST JSON 请求
  Future<ResponseEntity> postJson(
    String path, {
    dynamic data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) {
    options ??= Options();
    options.contentType = Headers.jsonContentType;
    return _dio
        .post(
          path,
          data: data,
          cancelToken: cancelToken,
          queryParameters: params,
          options: options,
        )
        .then((value) => ResponseEntity.from(value.data));
  }

  ///
  ///PUT 请求
  Future<ResponseEntity> put(
    String path, {
    Map<String, dynamic>? params,
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio
        .put(path,
            data: data,
            cancelToken: cancelToken,
            queryParameters: params,
            options: (options ?? Options())
              ..contentType = Headers.formUrlEncodedContentType)
        .then((value) => ResponseEntity.from(value.data));
  }

  ///
  /// PUT JSON请求
  Future<ResponseEntity> putJson(
    String path, {
    Map<String, dynamic>? params,
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio
        .put(path,
            data: data,
            cancelToken: cancelToken,
            queryParameters: params,
            options: (options ?? Options())
              ..contentType = Headers.jsonContentType)
        .then((value) => ResponseEntity.from(value.data));
  }

  ///
  ///DELETE 请求
  Future<ResponseEntity> delete(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio
        .delete(path,
            cancelToken: cancelToken,
            queryParameters: params,
            options: (options ?? Options())
              ..contentType = Headers.formUrlEncodedContentType)
        .then((value) => ResponseEntity.from(value.data));
  }

  ///
  /// DELETE JSON请求
  Future<ResponseEntity> deleteJson(
    String path, {
    Map<String, dynamic>? params,
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio
        .delete(path,
            data: data,
            cancelToken: cancelToken,
            queryParameters: params,
            options: (options ?? Options())
              ..contentType = Headers.jsonContentType)
        .then((value) => ResponseEntity.from(value.data));
  }
}

///
/// 统一响应结果
class ResponseEntity {
  ///
  /// 错误提醒内容
  String? error;

  ///
  /// 成功消息
  String? message;

  ///
  /// 响应码
  late int code;

  ///
  /// 响应数据
  dynamic data;

  ///
  /// 响应时间
  late String timestamp;

  ResponseEntity(
    this.error,
    this.message,
    this.code,
    this.data,
    this.timestamp,
  );

  ResponseEntity.from(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    code = json['code'];
    data = json['data'];
    timestamp = json['timestamp'];
  }
}

class ResponseError implements Exception {
  ///
  /// -1——系统网络异常,其他——业务异常码
  int code = -1;

  ///
  /// 请求地址
  String path = '';

  ///
  /// 异常内容
  String message = '系统响应错误';

  ///
  ///错误时返回的业务数据
  dynamic data;

  ResponseError.fromResp(Response response) {
    path = response.requestOptions.path;
    if (response.statusCode == 404 ||
        response.statusCode == 503 ||
        response.statusCode == 502) {
      code = -1;
      message = '服务暂时不可用';
      return;
    }
    if (response.statusCode == 401) {
      message = "登录后可访问";
    }
    if (response.statusCode == 403) {
      message = "暂无权限访问";
    }

    Headers headers = response.headers;
    if (Headers.jsonContentType.isCaseInsensitiveContains(
        headers.value(Headers.contentTypeHeader) ?? '')) {
      code = response.statusCode ?? -1;
      message = response.data['error'] ?? '系统响应错误';
      return;
    }
  }

  ResponseError({
    required this.code,
    required this.message,
    this.path = '',
    this.data,
  });

  @override
  String toString() {
    if (message == '') {
      return 'response error: code [$code] , path [$path]';
    }
    return 'response error: code [$code] , path [$path] , message [$message]';
  }
}
