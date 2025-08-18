import 'dart:io';

import 'package:path_provider/path_provider.dart';

///
/// 应用缓存数据管理与清理
///
class AppCacheTool {
  ///
  /// 清除应用缓存
  ///
  static Future<void> clearCache() async {
    Directory tempDir = await getTemporaryDirectory();
    await _removeDir(tempDir);
  }

  ///
  /// 递归删除缓存文件夹
  ///
  static Future<void> _removeDir(FileSystemEntity file) async {
    if (file is Directory) {
      List<FileSystemEntity> files = file.listSync();
      for (FileSystemEntity entity in files) {
        await _removeDir(entity);
      }
    }
    await file.delete();
  }
}
