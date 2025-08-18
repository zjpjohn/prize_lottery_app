import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/widgets/refresh_widget.dart';
import 'package:prize_lottery_app/views/battle/controller/dlt_battle_controller.dart';
import 'package:prize_lottery_app/views/battle/model/master_battle.dart';
import 'package:prize_lottery_app/views/battle/widgets/battle_rank_entry_widget.dart';
import 'package:prize_lottery_app/views/home/widgets/achieve_tag_view.dart';
import 'package:prize_lottery_app/views/rank/model/dlt_master_rank.dart';
import 'package:prize_lottery_app/views/rank/widgets/mul_rank_entry_widget.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class DltBattleRankView extends StatelessWidget {
  ///
  ///
  const DltBattleRankView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      border: false,
      title: 'PK专家选择',
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
      content: RefreshWidget<DltBattleMasterController>(
        init: DltBattleMasterController(),
        builder: (controller) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: controller.ranks.length,
            itemBuilder: (context, index) {
              return _buildBattleMaster(
                controller,
                index,
                index < controller.ranks.length - 1,
              );
            },
          );
        },
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
              '专家PK使用说明',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.w),
              child: Text(
                '1.点击您要加入PK列表的专家，选择该专家本期预测加入到列表中。'
                '\n2.当账户余额不足时，会提示观看激励视频后才可将专家预测加入列表中。'
                '\n3.选择的专家还未上传预测数据，会提示专家本期没有预测数据。',
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

  Widget _buildBattleMaster(
      DltBattleMasterController controller, int index, bool border) {
    MasterBattleRank<DltMasterMulRank> rank = controller.ranks[index];
    return BattleRankEntryWidget(
      border: border,
      browsed: rank.browsed == 1,
      showAds: index > 0 && index % 10 == 3,
      battled: rank.battled != null && rank.battled == 1,
      data: MulMasterRank(
        rank: rank.masterRank,
        achieves: [
          AchieveInfo(name: '围红', count: rank.masterRank.red20.count),
          AchieveInfo(name: '杀红', count: rank.masterRank.rk.count),
          AchieveInfo(
              name: '杀蓝',
              count: rank.masterRank.bk.count,
              color: TagColor.blue),
        ],
      ),
      onTap: () {
        DltBattleController().addBattle(
          rank.masterRank.master.masterId,
          success: (masterId) {
            controller.addBattled(masterId);
          },
        );
      },
    );
  }
}
