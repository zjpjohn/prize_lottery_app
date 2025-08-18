import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:prize_lottery_app/app/app_controller.dart';
import 'package:prize_lottery_app/app/app_repository.dart';
import 'package:prize_lottery_app/base/controller/request_controller.dart';
import 'package:prize_lottery_app/env/env_profile.dart';
import 'package:prize_lottery_app/store/device.dart';
import 'package:prize_lottery_app/store/model/device_info.dart';
import 'package:prize_lottery_app/widgets/upload_image.dart';

class FeedbackController extends AbsRequestController {
  ///
  ///文本控制数据
  final TextEditingController controller = TextEditingController();

  ///
  /// 上传组件唯一标识
  final GlobalKey<UploadImageState> uploadKey = GlobalKey<UploadImageState>();

  String? _type;
  String? _content;
  List<String> images = [];

  set type(String? type) {
    _type = type;
    update();
  }

  String? get type => _type;

  set content(String? content) {
    _content = content;
    update();
  }

  String? get content => _content;

  bool beforeHandle() {
    if (type == null) {
      EasyLoading.showToast('请选择反馈分类');
      return false;
    }
    if (content == null || content!.isEmpty) {
      EasyLoading.showToast('请输入反馈内容');
      return false;
    }
    return true;
  }

  ///
  /// 提交反馈信息
  Future<void> submitFeedback() async {
    ///应用设备信息
    DeviceInfo device = await AppDevice().deviceInfo();

    ///应用包信息
    PackageInfo packageInfo = await AppController().packageInfo();

    ///提交反馈信息
    return AppInfoRepository.submitFeedback(FeedbackInfo(
      type: type!,
      appNo: Profile.props.appNo,
      appVersion: packageInfo.version,
      device: device.device,
      content: content!,
      images: images,
    )).then((value) {
      type = null;
      content = null;
      images.clear();
      controller.clear();
      update();
      uploadKey.currentState?.clearAll();
      EasyLoading.showToast('提交成功');
    }).catchError((error) {
      EasyLoading.showToast('提交失败');
    });
  }

  @override
  Future<void> request() async {
    showLoading();
    Future.delayed(const Duration(milliseconds: 350), () {
      showSuccess(true);
    });
  }
}

class FeedbackInfo {
  ///
  /// 反馈类型
  late String type;

  ///应用标识
  late String appNo;

  ///应用版本
  late String appVersion;

  ///设备信息
  late String device;

  /// 反馈内容
  late String content;

  /// 反馈图片集合
  List<String>? images;

  FeedbackInfo({
    required this.type,
    required this.appNo,
    required this.appVersion,
    required this.device,
    required this.content,
    this.images,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['type'] = type;
    json['appNo'] = appNo;
    json['appVersion'] = appVersion;
    json['device'] = device;
    json['content'] = content;
    json['images'] = images ?? [];
    return json;
  }
}
