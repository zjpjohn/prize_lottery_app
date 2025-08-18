import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/utils/date_util.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/user/controller/invite_history_controller.dart';
import 'package:prize_lottery_app/views/user/model/user_info.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class InviteHistoryView extends StatelessWidget {
  ///
  const InviteHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '邀请历史',
      content: RefreshWidget<InviteHistoryController>(
        bottomBouncing: false,
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.histories.length,
            itemBuilder: (context, index) {
              return _buildHistoryItem(controller.histories[index],
                  index < controller.histories.length - 1);
            },
          );
        },
      ),
    );
  }

  Widget _buildHistoryItem(InvitedUser user, bool border) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 16.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: border
              ? BorderSide(color: Colors.black12, width: 0.20.w)
              : BorderSide.none,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 6.w),
            child: Text(
              user.nickname,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Tools.encodeTel(user.phone),
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    DateUtil.formatDate(
                      DateUtil.parse(
                        user.gmtCreate,
                        pattern: "yyyy/MM/dd HH:mm",
                      ),
                      format: "yyyy.MM.dd HH:mm",
                    ),
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
