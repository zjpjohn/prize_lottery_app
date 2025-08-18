import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class PosterUtils {
  ///
  /// 组件截图控制器
  static final ScreenshotController screenshotController =
      ScreenshotController();

  ///
  /// 存储权限申请
  static Future<bool> storagePermission() async {
    PermissionStatus status = await Permission.storage.status;
    if (status == PermissionStatus.granted) {
      return true;
    }
    status = await Permission.storage.request();
    return status == PermissionStatus.granted;
  }

  ///
  /// 保存海报图片
  static void saveImage(GlobalKey key) async {
    try {
      if (!await storagePermission()) {
        EasyLoading.showError('没有权限哟');
        return;
      }
      EasyLoading.show();
      RenderRepaintBoundary? boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary?;
      var image = await boundary!.toImage(pixelRatio: 4);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List bytes = byteData!.buffer.asUint8List();
      await ImageGallerySaver.saveImage(bytes, quality: 100);
      Future.delayed(const Duration(milliseconds: 250), () {
        EasyLoading.showToast(
          '保存成功，请去相册查看',
          duration: const Duration(milliseconds: 1500),
        );
      });
    } catch (error) {
      EasyLoading.showError('图片保存失败');
    }
  }

  ///
  /// 保存组件
  static saveWidget(Widget Function() callback) async {
    try {
      if (!await storagePermission()) {
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

  ///
  /// 保存组件
  static saveLongWidget(Widget Function() callback) async {
    try {
      if (!await storagePermission()) {
        EasyLoading.showError('没有权限哟');
        return;
      }
      EasyLoading.show();
      Uint8List image = await screenshotController.captureFromLongWidget(
        InheritedTheme.captureAll(
          Get.context!,
          Material(
            child: callback(),
          ),
        ),
        context: Get.context,
        pixelRatio: MediaQuery.of(Get.context!).devicePixelRatio,
      );
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
}
