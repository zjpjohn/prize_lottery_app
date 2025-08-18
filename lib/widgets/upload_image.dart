import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prize_lottery_app/store/config.dart';
import 'package:prize_lottery_app/store/model/oss_policy.dart';

typedef UploadSuccess = Function(String image);
typedef RemoveCallback = Function(String image);

const List<String> filterList = ['jpg', 'png', 'jpeg'];

class UploadImage extends StatefulWidget {
  ///
  ///上传成功回调
  final UploadSuccess success;

  ///
  /// 删除图片回调
  final RemoveCallback remove;

  ///
  /// 图片尺寸
  final double size;

  ///
  /// 最多上传图片数量
  final int maxSize;

  ///
  /// 上传图片路径前缀
  final String? prefix;

  ///
  /// 允许上传图片类型集合
  final List<String> filters;

  ///
  /// 上传图片按钮icon
  final IconData btnIcon;

  const UploadImage({
    super.key,
    required this.success,
    required this.remove,
    required this.btnIcon,
    this.size = 64,
    this.maxSize = 6,
    this.prefix,
    this.filters = filterList,
  });

  @override
  UploadImageState createState() => UploadImageState();
}

class UploadImageState extends State<UploadImage> {
  ///
  /// dio实例
  late Dio _dio;

  ///
  ///图片选择器
  final ImagePicker _picker = ImagePicker();

  ///
  /// 图片集合
  List<String> images = [];

  ///
  /// 上传图片状态
  bool upload = false;

  ///
  /// 临时文件夹
  late Directory tempDir;

  ///
  /// 清空上传图片
  void clearAll() {
    setState(() {
      images.clear();
    });
  }

  Future<void> _initialize() async {
    ///
    /// 初始化dio实例
    BaseOptions options = BaseOptions(
      ///连接超时时间
      connectTimeout: const Duration(seconds: 10),

      ///响应超时时间
      receiveTimeout: const Duration(seconds: 8),

      contentType: 'multipart/form-data',

      ///响应数据格式
      responseType: ResponseType.plain,
    );
    _dio = Dio(options);

    ///
    /// 获取应用临时文件夹
    tempDir = await getTemporaryDirectory();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 9.w, right: 16.w, bottom: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildImageList(),
      ),
    );
  }

  List<Widget> _buildImageList() {
    List<Widget> views = List.from(images.map((e) => _buildImageItem(e)));
    if (images.length < widget.maxSize) {
      views.add(_buildImageBtn());
    }
    return views;
  }

  Widget _buildImageItem(String image) {
    return SizedBox(
      width: widget.size + 18.w,
      height: widget.size + 18.w,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(2.0.w),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2.0.w),
                child: CachedNetworkImage(
                  imageUrl: image,
                  width: widget.size,
                  height: widget.size,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    size: widget.size / 2,
                    color: Colors.black12.withValues(alpha: 0.05),
                  ),
                  placeholder: (context, uri) => Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(
                        strokeWidth: 1.w,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.grey.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (images.remove(image)) {
                    widget.remove(image);
                  }
                });
              },
              child: Container(
                width: 18.w,
                height: 18.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(9.w),
                ),
                child: Icon(
                  Icons.close,
                  size: 13.w,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildImageBtn() {
    return Container(
      width: widget.size + 18.w,
      height: widget.size + 18.w,
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () async {
          ///
          /// 数量校验
          if (images.length >= widget.maxSize) {
            EasyLoading.showToast('最多选择${widget.maxSize}张照片');
            return;
          }

          ///
          /// 是否正在上传
          if (upload) {
            EasyLoading.showToast('正在上传，请耐心等待');
            return;
          }

          ///
          /// 设置正在上传
          setState(() {
            upload = true;
          });

          ///
          /// 选择图片
          _picker.pickImage(source: ImageSource.gallery).then((file) {
            if (file == null) {
              return;
            }
            //文件后缀
            String suffix = file.path.substring(file.path.lastIndexOf('.'));
            CompressFormat? format;
            if (suffix.contains('png')) {
              format = CompressFormat.png;
            } else if (suffix.contains('jpg') || suffix.contains("jpeg")) {
              format = CompressFormat.jpeg;
            }
            if (format == null) {
              EasyLoading.showToast('仅支持png或者jpeg图片');
              return;
            }
            //时间戳
            String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
            //压缩后临时文件路径
            String targetPath = '${tempDir.absolute.path}/$timestamp$suffix';
            //忽略后缀名
            FlutterImageCompress.validator.ignoreCheckExtName = true;
            //压缩并上传
            FlutterImageCompress.compressAndGetFile(
              file.path,
              targetPath,
              minHeight: 480,
              minWidth: 270,
              quality: 50,
              format: format,
            ).then((value) => _uploadImage(value)).then((value) {
              ///上传返回oss图片链接
              if (value != null) {
                widget.success(value);
                setState(() {
                  images.add(value);
                });
              }
            });
          }).whenComplete(() {
            setState(() {
              upload = false;
            });
          });
        },
        child: Container(
          width: widget.size,
          height: widget.size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFF8F8F8),
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: Icon(
            widget.btnIcon,
            size: (widget.size / 2).w,
            color: Colors.black12,
          ),
        ),
      ),
    );
  }

  Future<String?> _uploadImage(XFile? file) async {
    if (file == null) {
      return null;
    }
    String suffix = file.path.substring(file.path.lastIndexOf('.') + 1);
    if (!widget.filters.contains(suffix)) {
      EasyLoading.showToast('图片格式不支持');
      return null;
    }

    ///
    /// oss直传签名
    OssPolicy? policy = await ConfigStore().getOssPolicy();

    if (policy == null) {
      EasyLoading.showToast('签名错误');
      return null;
    }

    ///
    /// 前缀文件夹
    String prefixDir = '';
    if (widget.prefix != null) {
      prefixDir =
          widget.prefix!.endsWith('/') ? widget.prefix! : '${widget.prefix!}/';
    }

    ///
    /// 文件名称
    String fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(100000)}.$suffix';

    ///
    /// 构造上传文件
    MultipartFile multipartFile = await MultipartFile.fromFile(
      file.path,
      filename: fileName,
      contentType: MediaType.parse('image/$suffix'),
    );
    FormData formData = policy.toFormData(
      file: multipartFile,
      name: fileName,
      prefixDir: prefixDir,
    );

    ///
    /// 文件上传
    EasyLoading.show();
    String? image;
    try {
      image = await _dio.post(policy.host, data: formData).then((response) {
        String image = '${policy.domain}/${policy.dir}$prefixDir$fileName';
        return image;
      });
    } catch (e) {
      EasyLoading.showToast('上传文件失败');
    } finally {
      EasyLoading.dismiss();
    }
    return image;
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }
}
