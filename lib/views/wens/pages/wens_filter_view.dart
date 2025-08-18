import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/utils/poster_util.dart';
import 'package:prize_lottery_app/views/lottery/utils/num3_lottery_utils.dart';
import 'package:prize_lottery_app/views/shrink/widgets/clip_button.dart';
import 'package:prize_lottery_app/views/wens/controller/wens_filter_controller.dart';
import 'package:prize_lottery_app/views/wens/model/wens_filter.dart';
import 'package:prize_lottery_app/views/wens/widgets/dan_pick_panel.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/empty_widget.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class WensFilterView extends StatelessWidget {
  const WensFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '缩水过滤',
      border: false,
      content: RequestWidget<WensFilterController>(
        builder: (controller) {
          return Column(
            children: [
              _buildPeriodHeader(controller),
              Expanded(
                child: ScrollConfiguration(
                  behavior: CustomScrollBehavior(),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildLotteryView(controller),
                        Container(height: 4.w, color: const Color(0xFFF6F7F9)),
                        _buildFunctionPanel(controller),
                        Container(height: 4.w, color: const Color(0xFFF6F7F9)),
                        _buildFilterResult(controller),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPeriodHeader(WensFilterController controller) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              controller.prevPeriod();
            },
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Icon(
                    const IconData(0xe676, fontFamily: 'iconfont'),
                    size: 14.sp,
                    color:
                        controller.isFirst() ? Colors.black26 : Colors.black87,
                  ),
                ),
                Text(
                  '上一期',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color:
                        controller.isFirst() ? Colors.black26 : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${controller.period}期',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.nextPeriod();
            },
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '下一期',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: controller.isEnd() ? Colors.black26 : Colors.black87,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Icon(
                    const IconData(0xe613, fontFamily: 'iconfont'),
                    size: 14.sp,
                    color: controller.isEnd() ? Colors.black26 : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLotteryView(WensFilterController controller) {
    Num3Lottery lottery = controller.lottery;
    return Column(
      children: [
        if (lottery.last != null) SizedBox(height: 8.w),
        if (lottery.last != null)
          _buildLotteryItem('上一期', lottery.lastPeriod!, lottery.last!),
        SizedBox(height: 8.w),
        _buildLotteryItem('当前期', lottery.period, lottery.current),
        SizedBox(height: 8.w),
        _buildLotteryItem('下一期', lottery.nextPeriod, lottery.next),
        SizedBox(height: 16.w),
      ],
    );
  }

  Widget _buildLotteryItem(String title, String period, String? lottery) {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 14.sp),
                children: [
                  TextSpan(
                    text: title,
                    style: const TextStyle(color: Colors.black87),
                  ),
                  WidgetSpan(child: SizedBox(width: 4.w)),
                  TextSpan(
                    text: '$period期',
                    style: const TextStyle(color: Color(0xFFFF0045)),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 14.sp),
                children: [
                  TextSpan(
                    text: '$title奖号',
                    style: const TextStyle(color: Colors.black87),
                  ),
                  WidgetSpan(child: SizedBox(width: 4.w)),
                  TextSpan(
                    text:
                        lottery != null && lottery.isNotEmpty ? lottery : '待开奖',
                    style: const TextStyle(color: Color(0xFFFF0045)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFunctionPanel(WensFilterController controller) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 12.w, bottom: 10.w),
            child: Text(
              '缩水功能',
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.black87,
              ),
            ),
          ),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            childAspectRatio: 2.6,
            mainAxisSpacing: 12.w,
            crossAxisSpacing: 12.w,
            children: [
              ClipButton(
                text: '胆码选择',
                value: 1,
                width: 72.w,
                height: 30.w,
                margin: 0,
                selected: controller.hasPickedDan(),
                onTap: (value) {
                  Constants.bottomSheet(
                    const DanGroupPickPanel(),
                  );
                },
              ),
              ClipButton(
                text: '奖号断组',
                value: 1,
                width: 72.w,
                height: 30.w,
                margin: 0,
                selected: controller.hasPickedDuanZu(),
                onTap: (value) {
                  Constants.bottomSheet(DuanZuPickPanel(height: 280.w));
                },
              ),
              ClipButton(
                text: '两码组合',
                value: 1,
                width: 72.w,
                height: 30.w,
                margin: 0,
                selected: controller.filter.twoMa.isNotEmpty,
                onTap: (value) {
                  Constants.bottomSheet(TwoMaPanel(height: 320.w));
                },
              ),
              ClipButton(
                text: '跨度选择',
                value: 1,
                width: 72.w,
                height: 30.w,
                margin: 0,
                selected: controller.filter.kuaList.isNotEmpty,
                onTap: (value) {
                  Constants.bottomSheet(
                    GetBuilder<WensFilterController>(
                      builder: (controller) {
                        return KuaSumPanel(
                          title: '跨度选择',
                          height: 240.w,
                          remark: '跨度过滤能大幅缩小选号范围，请谨慎使用',
                          loader: () {
                            return List.generate(10, (i) => i);
                          },
                          selected: (v) {
                            return controller.filter.kuaList.contains(v);
                          },
                          pick: (v) {
                            controller.kuaPick(v);
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              ClipButton(
                text: '和值选择',
                value: 1,
                width: 72.w,
                height: 30.w,
                margin: 0,
                selected: controller.filter.sumList.isNotEmpty,
                onTap: (value) {
                  Constants.bottomSheet(
                    GetBuilder<WensFilterController>(
                      builder: (controller) {
                        return KuaSumPanel(
                          title: '和值选择',
                          height: 300.w,
                          remark: '和值过滤能大幅缩小选号数量，请谨慎使用',
                          loader: () {
                            return List.generate(28, (i) => i);
                          },
                          selected: (v) =>
                              controller.filter.sumList.contains(v),
                          pick: (v) {
                            controller.sumPick(v);
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              ClipButton(
                text: '进位和差',
                value: 1,
                width: 72.w,
                height: 30.w,
                margin: 0,
                selected: controller.filter.jinDiff.isNotEmpty,
                onTap: (value) {
                  Constants.bottomSheet(
                    GetBuilder<WensFilterController>(
                      builder: (controller) {
                        return DiffSumPanel(
                          title: '进位和差',
                          height: 240.w,
                          remark: '进位和差准确率在85%左右，请谨慎使用',
                          loader: () {
                            return List.generate(10, (i) => i);
                          },
                          selected: (v) =>
                              controller.filter.jinDiff.contains(v),
                          recEnable: () {
                            controller.enableJinDiff();
                          },
                          pick: (v) {
                            controller.jinDiffPick(v);
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              ClipButton(
                text: '两码偶合',
                value: 1,
                width: 72.w,
                height: 30.w,
                margin: 0,
                selected: controller.filter.evenSum.isNotEmpty,
                onTap: (value) {
                  Constants.bottomSheet(
                    GetBuilder<WensFilterController>(
                      builder: (controller) {
                        return DiffSumPanel(
                          title: '两码偶合',
                          height: 240.w,
                          remark: '两码偶合准确率在85%左右，请谨慎使用',
                          loader: () {
                            return [0, 2, 4, 6, 8];
                          },
                          selected: (v) =>
                              controller.filter.evenSum.contains(v),
                          recEnable: () {
                            controller.enableEvenSum();
                          },
                          pick: (v) {
                            controller.evenSumPick(v);
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              ClipButton(
                text: '杀码选择',
                value: 1,
                width: 72.w,
                height: 30.w,
                margin: 0,
                selected: controller.filter.killList.isNotEmpty,
                onTap: (value) {
                  Constants.bottomSheet(
                    GetBuilder<WensFilterController>(
                      builder: (controller) {
                        return DanKillPanel(
                          title: '杀码选择',
                          height: 240.w,
                          remark: '杀码能大幅缩小选号数量但容易误杀，请谨慎使用',
                          loader: () {
                            return List.generate(10, (i) => i);
                          },
                          selected: (i) =>
                              controller.filter.killList.contains(i),
                          pick: (value) {
                            controller.killPick(value);
                          },
                          disabled: (i) => controller.disableKill(i),
                        );
                      },
                    ),
                  );
                },
              ),
              ClipButton(
                text: '直选定位',
                value: 1,
                width: 72.w,
                height: 30.w,
                margin: 0,
                selected: controller.filter.directNotEmpty(),
                onTap: (value) {
                  Constants.bottomSheet(
                    GetBuilder<WensFilterController>(
                      builder: (controller) {
                        return const DirectPickPanel();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterResult(WensFilterController controller) {
    return Container(
      padding: EdgeInsets.only(top: 24.w, bottom: 32.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.filterAction();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 6.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF0045),
                        borderRadius: BorderRadius.circular(2.w),
                      ),
                      child: Text(
                        '缩水计算',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 32.w,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.resetFilter(duanZu: false);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 6.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F4F4),
                        borderRadius: BorderRadius.circular(2.w),
                      ),
                      child: Text(
                        '清除条件',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildResultView(controller),
        ],
      ),
    );
  }

  Widget _buildResultView(WensFilterController controller) {
    FilterResult result = controller.result;
    if (result.isEmpty()) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16.w),
        alignment: Alignment.center,
        child: EmptyView(
          size: 120.w,
          message: '没有符合的号码',
        ),
      );
    }
    return Column(
      children: [
        SizedBox(height: 32.w),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: RepaintBoundary(
            key: controller.posterKey,
            child: GestureDetector(
              onLongPress: () {
                PosterUtils.saveImage(controller.posterKey);
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                color: Colors.white,
                constraints: BoxConstraints(minHeight: 120.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    if (controller.result.zu6.isNotEmpty)
                      _buildLotteryResult('组六', controller.result.zu6),
                    if (controller.result.zu3.isNotEmpty)
                      _buildLotteryResult('组三', controller.result.zu3),
                    if (controller.result.direct.isNotEmpty)
                      _buildLotteryResult('直选', controller.result.direct),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLotteryResult(String title, List<String> result) {
    return Column(
      children: [
        Container(
          height: 34.w,
          color: const Color(0xFFFFF5EA).withValues(alpha: 0.5),
          padding: EdgeInsets.only(left: 8.w),
          alignment: Alignment.centerLeft,
          child: Text(
            '$title共${result.length}注号码',
            style: TextStyle(
              color: Colors.deepOrangeAccent,
              fontSize: 14.sp,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 8.w),
          alignment: Alignment.centerLeft,
          child: Wrap(
            spacing: 8.w,
            runSpacing: 6.w,
            alignment: WrapAlignment.start,
            children: result.map((e) => _lottery(e)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _lottery(String ball) {
    return Text(
      ball,
      style: TextStyle(
        fontSize: 13.w,
        fontFamily: 'bebas',
        color: const Color(0xFFFF0045),
        fontWeight: FontWeight.w400,
        decoration: TextDecoration.none,
      ),
    );
  }
}
