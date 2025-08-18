import 'dart:math';

class Tools {
  ///
  ///手机号校验
  static bool phone(String phone) {
    RegExp regex = RegExp(
        r'^((1[358][0-9])|(14[579])|(166)|(17[0135678])|(19[89]))\d{8}$');
    return regex.hasMatch(phone);
  }

  ///
  ///纯数字判断
  static bool number(String source) {
    RegExp regex = RegExp(r'\d+');
    return regex.hasMatch(source);
  }

  ///
  /// 密码校验
  static bool password(String password) {
    RegExp regex = RegExp(r'(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$');
    return regex.hasMatch(password);
  }

  ///
  /// 设置手机号掩码
  static String encodeTel(String phone) {
    if (phone.isEmpty) {
      return '';
    }
    return phone.replaceRange(3, 7, '****');
  }

  ///
  /// 字符串阶段替换
  static String limitName(String name, int limit) {
    if (name.length > limit) {
      return '${name.substring(0, limit)}...';
    }
    return name;
  }

  static int randLimit(int value, int limit) {
    if (value > limit) {
      return value;
    }
    return value + Random().nextInt(limit - value);
  }

  ///
  /// 字符串截断
  static String limitText(String name, int limit) {
    if (name.length > limit) {
      return name.substring(0, limit);
    }
    return name;
  }

  ///字符串分割,params-[data]
  static List<String> split(String data) {
    return data.isEmpty ? [] : data.trim().split(RegExp(r'\s+'));
  }

  ///字符串匹配分割,参数-[data]
  static List<Model> parse(String data) {
    if (data.isEmpty) {
      return [];
    }
    if (!data.contains('*')) {
      return singleParse(data);
    }
    return segParse(data);
  }

  static List<Model> singleParse(String data) {
    List<String> splits = data.trim().split(RegExp(r'\s+'));
    RegExp modeRegex = RegExp(r'\[\d+\]');
    RegExp regex = RegExp(r'\[|\]');
    List<Model> results = [];
    for (var item in splits) {
      if (modeRegex.hasMatch(item)) {
        String v = item.replaceAll(regex, '');
        results.add(Model(k: v.trim(), v: 1));
      } else {
        results.add(Model(k: item.trim(), v: 0));
      }
    }
    return results;
  }

  ///分段字符串匹配分割,参数-[data]
  static List<Model> segParse(String data) {
    List<String> segs = data.split(RegExp(r'\*'));
    List<Model> results = [];
    for (int i = 0; i < segs.length; i++) {
      List<Model> items = singleParse(segs[i]);
      results.addAll(items);
      if (i < segs.length - 1) {
        results.add(Model(k: '*', v: 0));
      }
    }
    return results;
  }

  static List<String> segSplit(String data) {
    if (data.isEmpty) {
      return [];
    }
    if (!data.contains(RegExp(r'\*'))) {
      return split(data);
    }
    List<String> segs = data.split(RegExp(r'\*'));
    List<String> results = [];
    for (int i = 0; i < segs.length; i++) {
      results.addAll(split(segs[i]));
      if (i < segs.length - 1) {
        results.add('*');
      }
    }
    return results;
  }

  ///
  /// 应用版本号比较
  static int version(String version1, String version2) {
    RegExp pattern = RegExp(r'\.');
    List<int> version1List =
        version1.split(pattern).map((e) => int.parse(e)).toList();
    List<int> version2List =
        version2.split(pattern).map((e) => int.parse(e)).toList();
    int length1 = version1List.length;
    int length2 = version2List.length;
    int length = max(length1, length2);
    for (int i = 0; i < length; i++) {
      int v1 = i < length1 ? version1List[i] : 0;
      int v2 = i < length2 ? version2List[i] : 0;
      if (v1 > v2) {
        return 1;
      }
      if (v1 < v2) {
        return -1;
      }
    }
    return 0;
  }
}

class Model {
  ///
  String k;

  ///
  int v;

  Model({required this.k, required this.v});
}
