import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/views/shrink/controller/qlc_shrink_controller.dart';
import 'package:prize_lottery_app/views/shrink/model/shrink_state.dart';
import 'package:prize_lottery_app/views/shrink/widgets/clip_button.dart';
import 'package:prize_lottery_app/views/shrink/widgets/shrink/ac_shrink_widget.dart';
import 'package:prize_lottery_app/views/shrink/widgets/shrink/dan_shrink_widget.dart';
import 'package:prize_lottery_app/views/shrink/widgets/shrink/kua_shrink_widget.dart';
import 'package:prize_lottery_app/views/shrink/widgets/shrink/pattern_shrink_view.dart';
import 'package:prize_lottery_app/views/shrink/widgets/shrink/prime_shrink_widget.dart';
import 'package:prize_lottery_app/views/shrink/widgets/shrink/road_shrink_widget.dart';
import 'package:prize_lottery_app/views/shrink/widgets/shrink/seg_shrink_widget.dart';
import 'package:prize_lottery_app/views/shrink/widgets/shrink/sum_shrink_widget.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/empty_widget.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class QlcShrinkView extends StatelessWidget {
  ///
  ///
  const QlcShrinkView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '缩水过滤',
      border: false,
      content: RequestWidget<QlcShrinkController>(
        builder: (controller) {
          return ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(height: 8.w, color: const Color(0xFFF6F6FB)),
                  _buildDanBall(controller),
                  Container(height: 8.w, color: const Color(0xFFF6F6FB)),
                  _buildShrinkPanel(controller),
                  Container(height: 8.w, color: const Color(0xFFF6F6FB)),
                  _buildShrinkResult(controller),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDanBall(QlcShrinkController controller) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            left: 12.w,
            right: 12.w,
            top: 28.w,
            bottom: 10.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: qlc.map((item) => _ball(item, controller)).toList(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 6.w),
                child: Text(
                  '注：点击号码选择排除，再次点击选中',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black26,
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.w),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(4.w),
              ),
            ),
            child: Text(
              '选择号码',
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.red.withValues(alpha: 0.75),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _ball(int ball, QlcShrinkController controller) {
    return Container(
      margin: EdgeInsets.only(right: 10.w, bottom: 8.w),
      child: GestureDetector(
        onTap: () {
          controller.tapBall(ball);
        },
        child: Container(
          height: 24.w,
          width: 24.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: controller.balls.contains(ball)
                ? const Color(0xFFFF0045)
                : const Color(0xFFF2F2F2),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(14.w),
          ),
          child: Text(
            '$ball',
            style: TextStyle(
              fontSize: 12.sp,
              color: controller.balls.contains(ball)
                  ? Colors.white
                  : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShrinkPanel(QlcShrinkController controller) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 30.w,
            left: 16.w,
            right: 16.w,
            bottom: 24.w,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipButton(
                      text: '胆码',
                      value: 1,
                      width: 66.w,
                      height: 26.w,
                      selected: controller.danShrink.selected(),
                      onTap: (value) {
                        Constants.bottomSheet(
                          GetBuilder<QlcShrinkController>(
                              builder: (controller) {
                            return DanShrinkView(
                              height: 340.w,
                              model: controller.danModel,
                              shrink: controller.danShrink,
                              tapBall: (index) {
                                controller.addDanBall(index);
                              },
                              tapNumber: (index) {
                                controller.addDanNumber(index);
                              },
                            );
                          }),
                        );
                      },
                    ),
                    ClipButton(
                      text: '和值',
                      value: 1,
                      width: 66.w,
                      height: 26.w,
                      selected: controller.sumShrink.selected(),
                      onTap: (value) {
                        Constants.bottomSheet(
                          GetBuilder<QlcShrinkController>(
                              builder: (controller) {
                            return SumShrinkView(
                              height: 340.w,
                              shrink: controller.sumShrink,
                              onTail: (int value) {
                                controller.addSumTail(value);
                              },
                              onOddEven: (int value) {
                                controller.addSumOe(value);
                              },
                              onRange: (RangeValues value) {
                                controller.sumRange(value);
                              },
                              onRoad: (int value) {
                                controller.addSumRoad(value);
                              },
                            );
                          }),
                        );
                      },
                    ),
                    ClipButton(
                      text: '形态',
                      value: 1,
                      width: 66.w,
                      height: 26.w,
                      selected: controller.seriesShrink.selected() ||
                          controller.bigShrink.selected() ||
                          controller.eoShrink.selected(),
                      onTap: (value) {
                        Constants.bottomSheet(
                          GetBuilder<QlcShrinkController>(
                              builder: (controller) {
                            return PatternShrinkView(
                              height: 360.w,
                              evenModel: controller.evenModel,
                              eoShrink: controller.eoShrink,
                              bigModel: controller.bigModel,
                              bigShrink: controller.bigShrink,
                              seriesModel: controller.seriesModel,
                              seriesShrink: controller.seriesShrink,
                              eoTap: (value) {
                                controller.addOddEven(value);
                              },
                              bigTap: (value) {
                                controller.addBig(value);
                              },
                              seriesTap: (value) {
                                controller.addSeries(value);
                              },
                              onClear: () {
                                controller.clearBig();
                                controller.clearOddEven();
                                controller.clearSeries();
                              },
                            );
                          }),
                        );
                      },
                    ),
                    ClipButton(
                      text: 'AC值',
                      value: 1,
                      width: 66.w,
                      height: 26.w,
                      selected: controller.acShrink.selected(),
                      onTap: (value) {
                        Constants.bottomSheet(
                          GetBuilder<QlcShrinkController>(
                              builder: (controller) {
                            return AcShrinkView(
                              height: 300.w,
                              model: controller.acModel,
                              shrink: controller.acShrink,
                              onTap: (value) {
                                controller.addAc(value);
                              },
                              onClear: () {
                                controller.clearAc();
                              },
                            );
                          }),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipButton(
                      text: '质合',
                      value: 1,
                      width: 66.w,
                      height: 26.w,
                      selected: controller.primeShrink.selected(),
                      onTap: (value) {
                        Constants.bottomSheet(
                          GetBuilder<QlcShrinkController>(
                              builder: (controller) {
                            return PrimeShrinkView(
                              height: 300.w,
                              model: controller.primeModel,
                              shrink: controller.primeShrink,
                              onTap: (value) {
                                controller.addPrime(value);
                              },
                              onClear: () {
                                controller.clearPrime();
                              },
                            );
                          }),
                        );
                      },
                    ),
                    ClipButton(
                      text: '012路',
                      value: 1,
                      width: 66.w,
                      height: 26.w,
                      selected: controller.roadShrink.selected(),
                      onTap: (value) {
                        Constants.bottomSheet(
                          GetBuilder<QlcShrinkController>(
                              builder: (controller) {
                            return RoadShrinkView(
                              height: 340.w,
                              model: controller.road012model,
                              shrink: controller.roadShrink,
                              onTap: (road, value) {
                                controller.addRoad(road, value);
                              },
                              onClear: () {
                                controller.clearRoad();
                              },
                            );
                          }),
                        );
                      },
                    ),
                    ClipButton(
                      text: '跨度',
                      value: 1,
                      width: 66.w,
                      height: 26.w,
                      selected: controller.kuaShrink.selected(),
                      onTap: (value) {
                        Constants.bottomSheet(
                          GetBuilder<QlcShrinkController>(
                              builder: (controller) {
                            return KuaShrinkView(
                              height: 360.w,
                              shrink: controller.kuaShrink,
                              onTap: (value) {
                                controller.addKua(value);
                              },
                              onClear: () {
                                controller.clearKua();
                              },
                            );
                          }),
                        );
                      },
                    ),
                    ClipButton(
                      text: '分区',
                      value: 1,
                      width: 66.w,
                      height: 26.w,
                      selected: controller.segShrink.selected(),
                      onTap: (value) {
                        Constants.bottomSheet(
                          GetBuilder<QlcShrinkController>(
                              builder: (controller) {
                            return SegShrinkView(
                              height: 360.w,
                              shrink: controller.segShrink,
                              onTap: (seg, value) {
                                controller.addSeg(seg, value);
                              },
                              onClear: () {
                                controller.clearSegs();
                              },
                            );
                          }),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.calculate();
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
                        controller.clearShrink();
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
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.w),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(4.w),
              ),
            ),
            child: Text(
              '缩水条件',
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.red.withValues(alpha: 0.75),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShrinkResult(QlcShrinkController controller) {
    List<List<int>> lotteries = controller.lotteries;
    if (lotteries.isEmpty) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16.w),
        alignment: Alignment.center,
        child: EmptyView(
          size: 100.w,
          message:
              controller.status == ShrinkState.start ? '请输入缩水条件' : '没有符合的号码',
        ),
      );
    }
    List<List<int>> balls =
        lotteries.length > 50 ? lotteries.sublist(0, 50) : lotteries;
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 8.w),
            alignment: Alignment.center,
            child: Wrap(
              spacing: 10.w,
              runSpacing: 8.w,
              children: balls.map((e) => _buildLottery(e)).toList(),
            ),
          ),
          Container(
            height: 34.w,
            color: const Color(0xFFFFF2EA),
            alignment: Alignment.center,
            child: Text(
              '缩水共${lotteries.length}注${lotteries.length > 50 ? '(仅展示50注)' : ''}',
              style: TextStyle(
                color: Colors.deepOrangeAccent,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLottery(List<int> balls) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: balls
          .map(
            (ball) => Container(
              height: 20.w,
              width: 20.w,
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 3.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(14.w),
              ),
              child: Text(
                '$ball',
                style: TextStyle(
                  fontSize: 10.w,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
