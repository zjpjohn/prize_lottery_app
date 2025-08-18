import 'package:get/get.dart';
import 'package:prize_lottery_app/app/app_repository.dart';
import 'package:prize_lottery_app/app/model/app_resource.dart';
import 'package:prize_lottery_app/env/env_profile.dart';
import 'package:prize_lottery_app/utils/storage.dart';

class ResourceStore extends GetxController {
  ///
  static const String appResourceKey = 'app_resources';

  static ResourceStore? _instance;

  factory ResourceStore() {
    ResourceStore._instance ??=
        Get.put<ResourceStore>(ResourceStore._initialize());
    return ResourceStore._instance!;
  }

  ResourceStore._initialize();

  ///
  /// 资源文件集合
  Map<String, AppResource>? _resources;

  String resource(String key) {
    return resources?[key]?.uri ?? '';
  }

  Future<void> loadResource() async {
    await AppInfoRepository.getAppResources(Profile.props.appNo)
        .then((value) => resources = value);
  }

  ///
  /// 获取资源集合
  Map<String, AppResource>? get resources {
    ///本地内存的资源
    if (_resources != null) {
      return _resources;
    }

    ///本地缓存的资源
    Map? json = Storage().getObject(appResourceKey);
    if (json != null && json.isNotEmpty) {
      _resources =
          json.map((key, value) => MapEntry(key, AppResource.fromJson(value)));
      update();
      return _resources;
    }
    return null;
  }

  ///
  /// 设置资源集合
  set resources(Map<String, AppResource>? resources) {
    if (resources == null || resources.isEmpty) {
      return;
    }
    Storage().putObject(appResourceKey, resources);
    _resources = resources;
    update();
  }
}
