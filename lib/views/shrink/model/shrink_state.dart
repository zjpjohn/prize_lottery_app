import 'package:worker_manager/worker_manager.dart';

///
/// 缩水过滤状态
enum ShrinkState {
  start,
  complete,
}

///
/// isolate过滤操作参数
class IsolateParams {
  final int type;
  final Map<int, String> params;

  const IsolateParams({
    required this.type,
    required this.params,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'params': params,
    };
  }
}

class Calculator {
  static Future<R> execute<A, R>(
      {required A arg, required R Function(A) task}) async {
    return await workerManager.execute<R>(() => task(arg));
  }
}
