import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/utils/date_util.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/master/model/focus_master.dart';
import 'package:prize_lottery_app/widgets/cached_avatar.dart';

class SubscribeMasterWidget extends StatelessWidget {
  ///
  const SubscribeMasterWidget({
    super.key,
    required this.master,
  });

  final SubscribeMaster master;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
            width: 0.18.w,
          ),
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed('/search/detail/${master.masterId}');
            },
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10.w),
                    height: 32.w,
                    width: 32.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6E6E6),
                      borderRadius: BorderRadius.circular(32.w),
                    ),
                    child: CachedAvatar(
                      width: 29.w,
                      height: 29.w,
                      radius: 29.w,
                      url: master.master.avatar,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Tools.limitText(master.master.name, 10),
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              master.special == 1 ? '重点关注' : '',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: const Color(0xFFFF0033),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${master.master.browse}',
                              style: TextStyle(
                                color: const Color(0xFFFF0033),
                                fontSize: 11.sp,
                              ),
                            ),
                            Text(
                              '次浏览',
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 11.sp,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12.w),
                              child: Text(
                                '${master.master.subscribe}',
                                style: TextStyle(
                                  color: const Color(0xFFFF0033),
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                            Text(
                              '人订阅',
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 11.sp,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12.w),
                              child: Text(
                                DateUtil.formatDate(
                                  DateUtil.parse(
                                    master.gmtCreate,
                                    pattern: 'yyyy/MM/dd HH:mm:ss',
                                  ),
                                  format: 'yy/MM/dd HH:mm',
                                ),
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.w),
            padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 14.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(6.w),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 6.w, bottom: 6.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTraceView(),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(
                              '/${master.channel.value}/master/${master.masterId}');
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Text(
                          '历史详情',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 6.w, bottom: 6.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '最新',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black54,
                          ),
                          children: [
                            TextSpan(
                              text: DateUtil.formatDate(
                                DateUtil.parse(
                                  master.modifyTime,
                                  pattern: 'yyyy/MM/dd HH:mm:ss',
                                ),
                                format: DateFormats.zh_mo_d,
                              ),
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: const Color(0xFFFF0033),
                              ),
                            ),
                            TextSpan(
                              text: '·',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFFF0033),
                              ),
                            ),
                            TextSpan(
                              text: '${master.latest}期',
                              style: TextStyle(
                                height: 0.95,
                                fontSize: 13.sp,
                                color: const Color(0xFFFF0033),
                              ),
                            ),
                            const TextSpan(
                              text: '推荐',
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(
                              '/${master.channel.value}/forecast/${master.masterId}');
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Text(
                          '查看方案',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTraceView() {
    return RichText(
      text: TextSpan(
        text: master.traceZh.isNotEmpty ? '订阅追踪' : '已订阅',
        style: TextStyle(
          fontSize: 13.sp,
          color: Colors.black54,
        ),
        children: [
          TextSpan(
            text: master.channel.description,
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFFFF0033),
            ),
          ),
          TextSpan(
            text: '·',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFFF0033),
            ),
          ),
          TextSpan(
            text: _traceText(),
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFFFF0033),
            ),
          ),
        ],
      ),
    );
  }

  String _traceText() {
    if (master.traceZh.isEmpty) {
      return '专家预测';
    }
    var trace = master.traceZh;
    if (trace == '杀一' || trace == '杀二') {
      return '$trace码';
    }
    return trace;
  }
}
