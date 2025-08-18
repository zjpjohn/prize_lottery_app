import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/user/controller/agent_income_controller.dart';
import 'package:prize_lottery_app/views/user/model/agent_account.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class AgentIncomeView extends StatelessWidget {
  const AgentIncomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '收益明细',
      right: _buildHeaderRight(),
      content: RefreshWidget<AgentIncomeController>(
        bottomBouncing: false,
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.histories.length,
            itemBuilder: (context, index) {
              return _buildIncomeItem(
                controller.histories[index],
                index < controller.histories.length - 1,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildHeaderRight() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.only(left: 16.w),
        child: Icon(
          const IconData(0xe607, fontFamily: 'iconfont'),
          size: 20.sp,
          color: Colors.black87,
        ),
      ),
      onTap: () {
        showDialog(
            context: Get.context!,
            barrierDismissible: false,
            builder: (context) {
              return Center(
                child: Container(
                  width: 300.w,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.w),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '展示说明',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.w),
                        child: Text(
                          '流量主收益明细由其分享的用户使用应用产生的收益分成，最多显示15天获得收益的历史记录。',
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
            });
      },
    );
  }

  Widget _buildIncomeItem(AgentIncome item, bool border) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 16.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: border
              ? BorderSide(color: const Color(0xFFF1F1F1), width: 0.3.w)
              : BorderSide.none,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 2.w),
                child: Text(
                  Tools.encodeTel(item.phone),
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              Text(
                item.gmtCreate,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          RichText(
            text: TextSpan(
              text: '${item.amount}',
              style: TextStyle(
                color: const Color(0xFFFF0045),
                fontSize: 17.sp,
                fontFamily: 'bebas',
              ),
              children: [
                WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 1.w),
                    child: Text(
                      '金币',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFFFF0045),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
