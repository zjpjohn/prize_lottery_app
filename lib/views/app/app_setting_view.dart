import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/app/app_controller.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/store/store.dart';
import 'package:prize_lottery_app/utils/cache_tools.dart';
import 'package:prize_lottery_app/widgets/common_widgets.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class AppSettingView extends StatelessWidget {
  ///
  ///
  const AppSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '账户设置',
      content: Stack(
        children: [
          Container(
            color: const Color(0xFFF6F6FB),
            child: ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildUserInfo(),
                    _buildAccountPanel(),
                    _buildHelpPanel(),
                    _buildAppPanel(),
                    SizedBox(height: 66.h),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            width: Get.width,
            child: _buildLoginOut(),
          )
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.w),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Image.asset(R.avatar, width: 48.w),
          ),
          GetBuilder<UserStore>(builder: (store) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 4.w),
                  child: Text(
                    store.authUser != null ? store.authUser!.phone : '',
                    style: TextStyle(
                      fontSize: 19.sp,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Text(
                  '用户名：${store.authUser != null ? store.authUser!.nickname : ''}',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13.sp,
                  ),
                )
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFunctionItem({
    required String title,
    String content = '',
    bool bordered = true,
    bool dotted = false,
    Function? handle,
  }) {
    return GestureDetector(
      onTap: () {
        if (handle != null) {
          handle();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: bordered
                ? BorderSide(color: Colors.black12, width: 0.25.w)
                : BorderSide.none,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.black87, fontSize: 14.sp),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 4.w),
                  child: Text(
                    content,
                    style: TextStyle(color: Colors.black38, fontSize: 12.sp),
                  ),
                ),
                if (dotted)
                  CommonWidgets.dotted(
                    size: 6.w,
                    color: const Color(0xFFFF0033),
                  ),
                Padding(
                  padding: EdgeInsets.zero,
                  child: Icon(
                    const IconData(0xe8b3, fontFamily: 'iconfont'),
                    size: 12.w,
                    color: Colors.black26,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountPanel() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10.w),
      child: GetBuilder<UserStore>(builder: (store) {
        return Column(
          children: [
            _buildFunctionItem(
              title: '注册来源',
              content: store.authUser != null && store.authUser!.channel != null
                  ? store.authUser!.channel!.description
                  : '',
            ),
            _buildFunctionItem(
              title: '预测专家',
              dotted: true,
              content: store.authUser != null && store.authUser!.expert == 1
                  ? '已成为'
                  : '未开通',
            ),
            _buildFunctionItem(
              title: '账户安全',
              content: '账户安全设置',
              dotted: true,
              handle: () {
                Get.toNamed(AppRoutes.reset);
              },
            ),
            _buildFunctionItem(
              title: '微信支付',
              content: (store.authUser?.wxBind ?? false) ? '已开通' : '开通微信支付',
              dotted: !(store.authUser?.wxBind ?? false),
              handle: () {},
            ),
            _buildFunctionItem(
              title: '支付宝支付',
              bordered: false,
              content: (store.authUser?.aliBind ?? false) ? '已开通' : '开通支付宝支付',
              dotted: !(store.authUser?.aliBind ?? false),
              handle: () {},
            ),
          ],
        );
      }),
    );
  }

  Widget _buildHelpPanel() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10.w),
      child: Column(
        children: [
          _buildFunctionItem(
            title: '邀请分享',
            content: '加入流量合作计划来赚钱',
            handle: () {
              Get.toNamed(AppRoutes.invite);
            },
          ),
          _buildFunctionItem(
            title: '功能反馈',
            content: '建议反馈改善应用',
            handle: () {
              Get.toNamed(AppRoutes.feedback);
            },
          ),
          _buildFunctionItem(
            title: '应用助手',
            content: '应用服务相关帮助',
            dotted: false,
            handle: () {
              Get.toNamed(AppRoutes.assistant);
            },
          ),
          _buildFunctionItem(
            title: '隐私政策',
            handle: () {
              Get.toNamed(AppRoutes.privacy);
            },
          ),
          _buildFunctionItem(
            title: '使用协议',
            bordered: false,
            handle: () {
              Get.toNamed(AppRoutes.usage);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAppPanel() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10.w),
      child: Column(
        children: [
          _buildFunctionItem(
            title: '清理缓存',
            handle: () {
              EasyLoading.show(status: '正在清除');
              AppCacheTool.clearCache().whenComplete(() {
                Future.delayed(const Duration(milliseconds: 250), () {
                  EasyLoading.showToast('清除缓存完成');
                });
              });
            },
          ),
          _buildFunctionItem(
            title: '应用权限',
            content: '系统权限说明',
            handle: () {
              Get.toNamed(AppRoutes.permission);
            },
          ),
          GetBuilder<AppController>(builder: (controller) {
            return _buildFunctionItem(
              title: '检测更新',
              content: !controller.latestVersion ? '有新版本' : '最新版本',
              dotted: !controller.latestVersion,
              handle: () {
                if (controller.latestVersion) {
                  EasyLoading.showToast('最新版本');
                  return;
                }
                controller.upgrade();
              },
            );
          }),
          GetBuilder<AppController>(builder: (controller) {
            return _buildFunctionItem(
              title: '关于凡彩推荐',
              content: controller.appVersion,
              dotted: !controller.latestVersion,
              bordered: false,
              handle: () {
                Get.toNamed(AppRoutes.appInfo);
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildLoginOut() {
    return GestureDetector(
      onTap: () {
        UserStore().loginOut();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 20.w),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xFFF6F6FB),
              blurRadius: 4,
              offset: Offset(0, -4),
            )
          ],
        ),
        child: Text(
          '退出当前账号',
          style: TextStyle(
            fontSize: 17.sp,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
