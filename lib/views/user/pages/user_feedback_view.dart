import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/views/user/controller/feedback_controller.dart';
import 'package:prize_lottery_app/widgets/action_state_button.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:prize_lottery_app/widgets/upload_image.dart';

const List<String> types = [
  '注册登录',
  '余额账户',
  '签到积分',
  '发布预测',
  '查看推荐',
  '邀请分享',
  '账户提现',
  '系统缺陷',
  '其他分类',
];

class FeedbackView extends StatelessWidget {
  ///
  ///
  const FeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '建议反馈',
      content: RequestWidget<FeedbackController>(
        builder: (controller) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(),
                  _buildTypeView(controller),
                  _buildContentView(controller),
                  _buildImageView(controller),
                  _buildSubmitBtn(controller)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.w),
      child: Text(
        '反馈分类',
        style: TextStyle(color: Colors.black87, fontSize: 16.sp),
      ),
    );
  }

  ///反馈问题类型
  Widget _buildTypeView(FeedbackController controller) {
    return Container(
      margin: EdgeInsets.only(top: 16.w),
      child: Wrap(
        spacing: 10.w,
        runSpacing: 12.w,
        children:
            types.map((type) => _buildTypeItem(controller, type)).toList(),
      ),
    );
  }

  Widget _buildTypeItem(FeedbackController controller, String type) {
    return GestureDetector(
      onTap: () {
        controller.type = type;
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFDCDCDC),
            width: 0.4.w,
          ),
          borderRadius: BorderRadius.circular(2.w),
        ),
        child: Text(
          type,
          style: TextStyle(
            fontSize: 13.sp,
            color: controller.type == type ? Colors.redAccent : Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget _buildContentView(FeedbackController controller) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.w,
      ),
      child: TextField(
        controller: controller.controller,
        maxLines: 6,
        maxLength: 200,
        autofocus: false,
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.black54,
        ),
        decoration: InputDecoration(
          hintText: '请输入您要反馈的问题内容（必填）',
          hintStyle: const TextStyle(color: Colors.black26),
          fillColor: const Color(0xFFF8F8F8),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6.w), //边角为5
            ),
            borderSide: const BorderSide(
              color: Colors.white, //边线颜色为白色
              width: 1, //边线宽度为2
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(6.w), //边角为30
            ),
          ),
        ),
        onChanged: (value) {
          controller.content = value;
        },
      ),
    );
  }

  Widget _buildImageView(FeedbackController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 16.w, bottom: 2.w),
            child: Text(
              '上传图片(最多3张)',
              style: TextStyle(
                color: Colors.black26,
                fontSize: 12.sp,
              ),
            ),
          ),
          UploadImage(
            key: controller.uploadKey,
            size: 90.w,
            maxSize: 3,
            prefix: '/feedback',
            btnIcon: const IconData(0xe62b, fontFamily: 'iconfont'),
            success: (image) {
              controller.images.add(image);
            },
            remove: (image) {
              controller.images.remove(image);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitBtn(FeedbackController controller) {
    return Container(
      height: 38.h,
      width: 200.w,
      margin: EdgeInsets.only(top: 24.w),
      child: ActionStateButton(
        active: '正在提交',
        unActive: '提交反馈',
        hintTxt: '提交中，请耐心等待',
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.blueAccent),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(38.w),
            ),
          ),
        ),
        before: controller.beforeHandle,
        action: controller.submitFeedback,
      ),
    );
  }
}
