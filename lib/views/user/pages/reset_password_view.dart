import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/views/user/controller/reset_password_controller.dart';
import 'package:prize_lottery_app/views/user/widgets/password_eye_widget.dart';
import 'package:prize_lottery_app/widgets/action_state_button.dart';
import 'package:prize_lottery_app/widgets/common_widgets.dart';
import 'package:prize_lottery_app/widgets/countdown_widget.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '修改密码',
      content: GetBuilder<ResetPasswordController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 32.w),
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: Get.width * 0.90,
                child: _buildFormView(controller),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFormView(ResetPasswordController controller) {
    return Form(
      key: controller.formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 18.w, bottom: 6.w),
            child: Text(
              '短信验证码',
              style: TextStyle(
                fontSize: 15.sp,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 18.w, right: 18.w, bottom: 8.w),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration:
                      CommonWidgets.filledDecoration(hintText: '请输入手机验证码'),
                  style: const TextStyle(letterSpacing: 1.2),
                  cursorWidth: 1.2.w,
                  onSaved: (value) {
                    controller.code = value!;
                  },
                  validator: (code) {
                    return controller.validateCode(code);
                  },
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20.w, right: 16.w),
                      child: CountdownWidget(
                        handle: controller.sendSms,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 18.w, bottom: 6.w),
            child: Text(
              '输入新密码',
              style: TextStyle(
                fontSize: 15.sp,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.w),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                TextFormField(
                  obscureText: !controller.showPassword,
                  key: controller.passwordKey,
                  keyboardType: TextInputType.visiblePassword,
                  decoration:
                      CommonWidgets.filledDecoration(hintText: '请输入新的密码'),
                  style: const TextStyle(letterSpacing: 0),
                  cursorWidth: 1.2.w,
                  onSaved: (value) {
                    controller.password = value!;
                  },
                  validator: (code) {
                    return controller.validatePwd(code);
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.w, right: 16.w),
                  child: PasswordEyeView(
                    value: controller.showPassword,
                    tap: (value) {
                      controller.showPassword = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 18.w, bottom: 6.w),
            child: Text(
              '确认新密码',
              style: TextStyle(
                fontSize: 15.sp,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                TextFormField(
                  obscureText: !controller.showConfirm,
                  keyboardType: TextInputType.visiblePassword,
                  decoration:
                      CommonWidgets.filledDecoration(hintText: '请输入确认密码'),
                  style: const TextStyle(letterSpacing: 0),
                  cursorWidth: 1.2.w,
                  onSaved: (value) {
                    controller.confirm = value!;
                  },
                  validator: (code) {
                    return controller.validateConfirm(code);
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.w, right: 16.w),
                  child: PasswordEyeView(
                    value: controller.showConfirm,
                    tap: (value) {
                      controller.showConfirm = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
            child: Text(
              '密码必须由8-16个英文大小写字母、数字组成，且必须包含字母和数字两种。',
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.black54,
              ),
            ),
          ),
          Container(
            height: 42.w,
            margin: EdgeInsets.only(top: 20.w, left: 16.w, right: 16.w),
            child: ActionStateButton(
              unActive: '确 认',
              active: '正在提交',
              hintTxt: '修改中，请耐心等待',
              before: controller.beforeHandle,
              action: controller.resetAction,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blueAccent),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(42.w),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
