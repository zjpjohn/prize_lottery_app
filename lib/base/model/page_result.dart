///
///
typedef DataConvertHandle<T> = T Function(dynamic data);

///
///
class PageResult<T> {
  ///
  /// 总数据量
  int total = 0;

  ///
  /// 当前页码
  int current = 1;

  ///
  /// 每页数据量
  int pageSize = 10;

  ///
  /// 当前页返回数据量
  int size = 0;

  ///
  /// 返回数据集合
  List<T> records = [];

  PageResult.fromJson({
    required Map<String, dynamic> json,
    required DataConvertHandle<T> handle,
  }) {
    total = json['total'];
    current = json['current'];
    pageSize = json['pageSize'];
    List list = json['records'];
    records = list.isEmpty ? [] : list.map((e) => handle(e)).toList();
  }
}
