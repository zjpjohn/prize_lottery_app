import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/views/master/widgets/subscrib_master_widget.dart';
import 'package:prize_lottery_app/views/user/controller/user_subscribe_controller.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class UserSubscribeView extends StatefulWidget {
  ///
  ///
  const UserSubscribeView({super.key});

  @override
  UserSubscribeViewState createState() => UserSubscribeViewState();
}

class UserSubscribeViewState extends State<UserSubscribeView> {
  ///
  ///
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '关注收藏',
      right: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return _headerDialog(context);
              });
        },
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Icon(
            const IconData(0xe607, fontFamily: 'iconfont'),
            size: 20.sp,
            color: Colors.black87,
          ),
        ),
      ),
      content: Container(
        color: const Color(0xFFF6F6FB),
        child: RefreshWidget<UserSubscribeController>(
          scrollController: _scrollController,
          topConfig: const ScrollTopConfig(align: TopAlign.right),
          builder: (controller) => ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: controller.focusList.length,
            itemBuilder: (context, index) {
              return Slidable(
                endActionPane: ActionPane(
                  key: Key(UniqueKey().toString()),
                  extentRatio: 0.52,
                  dragDismissible: false,
                  motion: const BehindMotion(),
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                        outlinedButtonTheme: const OutlinedButtonThemeData(
                          style: ButtonStyle(
                            iconColor: WidgetStatePropertyAll(Colors.white),
                          ),
                        ),
                      ),
                      child: SlidableAction(
                        autoClose: true,
                        onPressed: (context) {
                          controller.specialMaster(index);
                        },
                        padding: EdgeInsets.zero,
                        icon: const IconData(0xe771, fontFamily: 'iconfont'),
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFFFE931F),
                        label: '重点',
                      ),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        outlinedButtonTheme: const OutlinedButtonThemeData(
                          style: ButtonStyle(
                            iconColor: WidgetStatePropertyAll(Colors.white),
                          ),
                        ),
                      ),
                      child: SlidableAction(
                        autoClose: true,
                        onPressed: (context) {
                          controller.addToBattle(index);
                        },
                        padding: EdgeInsets.zero,
                        icon: const IconData(0xe677, fontFamily: 'iconfont'),
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFFFF6E1B),
                        label: '对比',
                      ),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        outlinedButtonTheme: const OutlinedButtonThemeData(
                          style: ButtonStyle(
                            iconColor: WidgetStatePropertyAll(Colors.white),
                          ),
                        ),
                      ),
                      child: SlidableAction(
                        autoClose: true,
                        onPressed: (context) {
                          var focusInfo = controller.focusList[index];
                          controller.unSubscribe(
                            masterId: focusInfo.masterId,
                            type: focusInfo.channel.value,
                          );
                        },
                        padding: EdgeInsets.zero,
                        icon: const IconData(0xe63b, fontFamily: 'iconfont'),
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFFF53D3D),
                        label: '删除',
                      ),
                    ),
                  ],
                ),
                child: SubscribeMasterWidget(
                  master: controller.focusList[index],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _headerDialog(BuildContext context) {
    return Center(
      child: Container(
        width: 280.w,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '收藏使用说明',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.w),
              child: Text(
                '1.用户对感兴趣的专家可以进行收藏，收藏后的专家将在此收藏列表中展示。'
                '\n2.如果用户对收藏的专家不感兴趣或者价值不大，可以左滑删除列表中的收藏专家。'
                '\n3.如果用户需要将专家的推荐加入到PK列表中，可以左滑选择对比将专家加入到PK列表中。'
                '\n4.如果用户需要对收藏专家重点关注，可以左滑选择重点按钮加以重点关注。',
                style: TextStyle(
                  color: const Color(0xFF666666),
                  fontSize: 14.sp,
                  height: 1.5,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 200.w,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 8.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2254F4).withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                  child: Text(
                    '我知道啦',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
