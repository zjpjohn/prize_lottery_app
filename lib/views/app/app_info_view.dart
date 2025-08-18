import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/app/app_controller.dart';
import 'package:prize_lottery_app/app/model/app_info.dart';
import 'package:prize_lottery_app/env/env_profile.dart';
import 'package:prize_lottery_app/resources/resources.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/widgets/common_widgets.dart';
import 'package:prize_lottery_app/widgets/empty_widget.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class AppInfoView extends StatelessWidget {
  ///
  ///
  const AppInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '关于${Profile.props.appName}',
      content: Container(
        color: const Color(0xFFF6F6FB),
        child: GetBuilder<AppController>(builder: (controller) {
          AppInfoVo? appInfo = controller.appInfo;
          if (appInfo == null) {
            return Align(
              child: EmptyView(
                message: '暂无应用信息',
                subtitle: '点击加载',
                callback: () {
                  controller.getAppInfo(showLoading: true);
                },
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildUpgrade(controller),
                _buildPlatform(appInfo),
                _buildContent(appInfo),
              ],
            ),
          );
        }),
      ),
    );
  }

  ///
  /// [_buildPlatform]平台详细信息介绍
  ///
  Widget _buildPlatform(AppInfoVo appInfo) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
      child: Text(
        appInfo.current.depiction,
        style: TextStyle(
          height: 1.3.w,
          fontSize: 14.sp,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _buildUpgrade(AppController controller) {
    return Column(
      children: <Widget>[
        Container(
          width: 86.w,
          height: 86.w,
          margin: EdgeInsets.only(top: 32.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w),
            image: const DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage(R.logo),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 12.w,
            bottom: 16.w,
          ),
          child: RichText(
            text: TextSpan(
              text: '${Profile.props.appName}V',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: controller.appInfo!.current.version,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.upgrade();
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 6.5.w, horizontal: 16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF2A62FD),
              borderRadius: BorderRadius.circular(25.w),
            ),
            child: Text(
              controller.latestVersion ? '最新版本' : '检查更新',
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildContent(AppInfoVo appInfo) {
    return Container(
      padding: EdgeInsets.only(top: 24.w),
      child: Column(
        children: [
          _buildContentItem(
            title: '隐私政策',
            handle: () {
              Get.toNamed(AppRoutes.privacy);
            },
          ),
          _buildContentItem(
            title: '服务协议',
            handle: () {
              Get.toNamed(AppRoutes.usage);
            },
          ),
          _buildContentItem(
            title: '证照资质',
            handle: () {
              Get.toNamed(AppRoutes.credential);
            },
          ),
          _buildContentItem(
            title: '备案许可',
            content: appInfo.appInfo.record,
            handle: () {
              Get.toNamed(AppRoutes.beian);
            },
          ),
          _buildContentItem(
            title: '联系电话',
            content: appInfo.appInfo.telephone,
            bordered: false,
          ),
        ],
      ),
    );
  }

  Widget _buildContentItem({
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
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 17.w),
        decoration: BoxDecoration(
          color: Colors.white,
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
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 4.w),
                  child: Text(
                    content,
                    style: TextStyle(color: Colors.black54, fontSize: 13.sp),
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
}
