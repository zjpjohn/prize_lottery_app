import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/views/user/controller/user_browse_controller.dart';
import 'package:prize_lottery_app/views/user/model/browse_record.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:prize_lottery_app/widgets/tag_mark.dart';

class UserBrowseView extends StatefulWidget {
  ///
  ///
  const UserBrowseView({super.key});

  @override
  UserBrowseViewState createState() => UserBrowseViewState();
}

class UserBrowseViewState extends State<UserBrowseView> {
  ///
  ///
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '浏览历史',
      content: Container(
        color: const Color(0xFFF6F6FB),
        child: RefreshWidget<UserBrowseController>(
          empty: '最近半月暂无浏览',
          scrollController: _scrollController,
          topConfig: const ScrollTopConfig(align: TopAlign.right),
          builder: (controller) => ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: controller.items.length,
            itemBuilder: (context, index) => _buildRecordItem(
              item: controller.items[index],
              index: index,
              border: index < controller.items.length - 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecordItem({
    required RecordListItem item,
    required int index,
    required bool border,
  }) {
    if (item.type == 1) {
      return _buildBrowseRecord(
        record: item.record!,
        index: index,
        border: border,
      );
    }
    return Container(
      alignment: Alignment.centerLeft,
      color: const Color(0xFFFBFBFB),
      padding: EdgeInsets.symmetric(
        vertical: 10.w,
        horizontal: 16.w,
      ),
      child: Text(
        item.name!,
        style: TextStyle(fontSize: 15.sp),
      ),
    );
  }

  Widget _buildBrowseRecord({
    required BrowseRecord record,
    required int index,
    required bool border,
  }) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              late String path;
              if (record.source.value == 1) {
                path =
                    '/${record.type.value}/master/${record.master!.masterId}';
              } else {
                path =
                    '/${record.type.value}/${browsePath[record.source.value]!}';
              }
              Get.toNamed(path);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.symmetric(vertical: 16.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: border
                      ? BorderSide(color: Colors.black12, width: 0.20.w)
                      : BorderSide.none,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 12.w),
                        child: CachedAvatar(
                          width: 42.w,
                          height: 42.w,
                          radius: record.source.value == 1 ? 4.w : 0,
                          url: record.source.value == 1
                              ? record.master!.avatar
                              : lotteryIcons[record.type.value]!,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 8.w),
                            child: Text(
                              record.source.value == 1
                                  ? record.master!.name
                                  : record.source.description,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: const Color(0xFF3C3C3C),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          TagView(name: '第${record.period}期'),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.w),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 16.w),
                          child: Text(
                            record.source.description,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 16.w),
                          child: Text(
                            record.type.description,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        Text(
                          record.gmtCreate,
                          style: TextStyle(
                            color: Colors.black26,
                            fontSize: 12.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
