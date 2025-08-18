import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/views/home/widgets/achieve_tag_view.dart';
import 'package:prize_lottery_app/views/home/widgets/master_rank_view.dart';
import 'package:prize_lottery_app/views/rank/model/master_mul_rank.dart';

class RankPanelWidget extends StatelessWidget {
  ///
  ///
  const RankPanelWidget({
    super.key,
    required this.type,
    required this.ranks,
    required this.detailPrefix,
    required this.moreAction,
    this.colors = const [Color(0xFFFD7164), Color(0xFFFD9E8A)],
    this.title = '优质精品专家出炉!',
    this.channel,
  });

  final String title;
  final int type;
  final List<Color> colors;
  final String detailPrefix;
  final List<MasterMulRank> ranks;
  final GestureTapCallback moreAction;
  final String? channel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors,
              ),
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(8.w),
                topEnd: Radius.circular(8.w),
              ),
            ),
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.fromLTRB(4.w, 0, 0, 0),
                  child: ShaderMask(
                    shaderCallback: (bounds) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black12,
                          Color(0x04000000),
                        ],
                      ).createShader(Offset.zero & bounds.size);
                    },
                    child: Text(
                      'TOP',
                      style: TextStyle(
                        fontSize: 34.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: moreAction,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(12.w, 6.w, 10.w, 4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(4.w, 0, 0, 0),
                          child: Text(
                            '排行榜',
                            style: TextStyle(
                              fontSize: 19.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 4.w),
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              height: 22.h,
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '完整榜单',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(
                                    const IconData(0xe613,
                                        fontFamily: 'iconfont'),
                                    size: 12.w,
                                    color: Colors.white54,
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 18.w),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: ranks.map((e) {
                return MasterRankView(
                  tagColor: type == 0 ? TagColor.red : TagColor.blue,
                  name: e.master.name,
                  avatar: e.master.avatar,
                  rank: e.rank,
                  hitValue: type == 0 ? e.redHit() : e.blueHit()!,
                  margin: EdgeInsets.only(right: e.rank % 2 != 0 ? 16.w : 0),
                  onTap: () {
                    Map<String, String>? parameters;
                    if (channel != null) {
                      parameters = {'channel': channel!};
                    }
                    Get.toNamed(
                      '$detailPrefix${e.master.masterId}',
                      parameters: parameters,
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
