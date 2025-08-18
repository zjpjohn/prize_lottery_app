import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/model/stat_hit_value.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/master/model/master_schema.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';

typedef AchieveCallback<T extends MasterSchema> = String Function(T schema);
typedef SchemaRateCallback<T extends MasterSchema> = StatHitValue Function(
    T schema);
typedef SchemaTapCallback<T extends MasterSchema> = void Function(T schema);

class MasterSchemaPanel<T extends MasterSchema> extends StatelessWidget {
  ///
  const MasterSchemaPanel({
    super.key,
    required this.schemas,
    required this.onTap,
    required this.rateCallback,
    required this.achieveCallback,
  });

  final List<T> schemas;
  final AchieveCallback<T> achieveCallback;
  final SchemaRateCallback<T> rateCallback;
  final SchemaTapCallback<T> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10.w),
      child: Column(
        children: _buildSchemaList(schemas),
      ),
    );
  }

  List<Widget> _buildSchemaList(List<T> schemas) {
    List<Widget> views = [];
    for (int i = 0; i < schemas.length; i++) {
      views.add(_buildSchemaView(schemas[i], i < schemas.length - 1));
    }
    return views;
  }

  Widget _buildSchemaView(T schema, bool border) {
    StatHitValue rate = rateCallback(schema);
    String achieve = achieveCallback(schema);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: border
              ? BorderSide(color: Colors.black12, width: 0.2.w)
              : BorderSide.none,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          onTap(schema);
        },
        behavior: HitTestBehavior.opaque,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(right: 12.w),
              height: 44.w,
              width: 44.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFE3E3E3),
                borderRadius: BorderRadius.circular(44.w),
              ),
              child: CachedAvatar(
                width: 41.w,
                height: 41.w,
                radius: 41.w,
                url: schema.master.avatar,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 45.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Tools.limitText(schema.master.name, 8),
                              style: TextStyle(
                                color: const Color(0xBB000000),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 2.2.w),
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.orange.withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(3.w),
                                  ),
                                  child: Text(
                                    rate.series > 0
                                        ? '${rate.series}连红'
                                        : '未命中',
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 12.w),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6.w, vertical: 2.2.w),
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent
                                        .withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(3.w),
                                  ),
                                  child: Text(
                                    '近${rate.count}',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.deepOrange.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4.w),
                          border: Border.all(
                            width: 0.5.w,
                            color: Colors.deepOrange.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 2.w, bottom: 2.w),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${(rate.rate * 100).toInt()}',
                                      style: TextStyle(
                                        color: Colors.deepOrangeAccent,
                                        fontSize: 14.sp,
                                        fontFamily: 'bebas',
                                      ),
                                    ),
                                    TextSpan(
                                      text: '%',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.deepOrangeAccent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 3.w,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(4.w),
                                  bottomRight: Radius.circular(4.w),
                                ),
                              ),
                              child: Text(
                                '15期命中率',
                                style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 6.w, bottom: 6.w),
                    child: Text(
                      achieve,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(vertical: 8.w, horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                    child: Text(
                      Constants.publishTxt(
                        period: schema.latest,
                        modified: schema.modified,
                      ),
                      style: TextStyle(
                        color: schema.modified == 1
                            ? Colors.deepOrangeAccent
                            : Colors.black54,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
