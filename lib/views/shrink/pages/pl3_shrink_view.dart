import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/resources/constants.dart';
import 'package:prize_lottery_app/utils/constants.dart';
import 'package:prize_lottery_app/utils/poster_util.dart';
import 'package:prize_lottery_app/views/shrink/controller/pl3_shrink_controller.dart';
import 'package:prize_lottery_app/views/shrink/model/shrink_state.dart';
import 'package:prize_lottery_app/views/shrink/widgets/clip_button.dart';
import 'package:prize_lottery_app/views/shrink/widgets/shrink/big_shrink_widget.dart';
import 'package:prize_lottery_app/views/shrink/widgets/shrink/dan_shrink_widget.dart';
import 'package:prize_lottery_app/views/shrink/widgets/shrink/kua_shrink_widget.dart';
import 'package:prize_lottery_app/views/shrink/widgets/shrink/n3_pattern_shrink_widget.dart';
import 'package:prize_lottery_app/views/shrink/widgets/shrink/oe_shrink_widget.dart';
import 'package:prize_lottery_app/views/shrink/widgets/shrink/prime_shrink_widget.dart';
import 'package:prize_lottery_app/views/shrink/widgets/shrink/road_shrink_widget.dart';
import 'package:prize_lottery_app/views/shrink/widgets/shrink/sum_shrink_widget.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/empty_widget.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';

class Pl3ShrinkView extends StatelessWidget {
  ///
  ///
  const Pl3ShrinkView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '缩水过滤',
      border: false,
      content: RequestWidget<Pl3ShrinkController>(
        builder: (controller) {
          return ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(height: 8.w, color: const Color(0xFFF6F6FB)),
                  _buildBallView(controller),
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

  Widget _buildBallView(Pl3ShrinkController controller) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShrinkType(controller),
            Offstage(
              offstage: controller.type != 0,
              child: _buildDirectView(controller),
            ),
            Offstage(
              offstage: controller.type != 1,
              child: _buildCombineView(controller),
            ),
          ],
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

  Widget _buildShrinkPanel(Pl3ShrinkController controller) {
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
                          GetBuilder<Pl3ShrinkController>(
                              builder: (controller) {
                            return DanShrinkView(
                              height: 240.w,
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
                      text: '形态',
                      value: 1,
                      width: 66.w,
                      height: 26.w,
                      selected: controller.patternShrink.selected() ||
                          controller.seriesShrink.selected(),
                      onTap: (value) {
                        Constants.bottomSheet(
                          GetBuilder<Pl3ShrinkController>(
                              builder: (controller) {
                            return N3PatternShrinkView(
                              height: 260.w,
                              patternModel: controller.n3patternModel,
                              patternShrink: controller.patternShrink,
                              seriesModel: controller.seriesModel,
                              seriesShrink: controller.seriesShrink,
                              onPattern: (value) {
                                controller.addPattern(value);
                              },
                              onSeries: (value) {
                                controller.addSeries(value);
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
                          GetBuilder<Pl3ShrinkController>(
                              builder: (controller) {
                            return SumShrinkView(
                              height: 320.w,
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
                      text: '跨度',
                      value: 1,
                      width: 66.w,
                      height: 26.w,
                      selected: controller.kuaShrink.selected(),
                      onTap: (value) {
                        Constants.bottomSheet(
                          GetBuilder<Pl3ShrinkController>(
                              builder: (controller) {
                            return KuaShrinkView(
                              height: 220.w,
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
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipButton(
                      text: '奇偶',
                      value: 1,
                      width: 66.w,
                      height: 26.w,
                      selected: controller.eoShrink.selected(),
                      onTap: (value) {
                        Constants.bottomSheet(
                          GetBuilder<Pl3ShrinkController>(
                              builder: (controller) {
                            return OddEvenShrinkView(
                              height: 220.w,
                              model: controller.evenModel,
                              shrink: controller.eoShrink,
                              onTap: (value) {
                                controller.addOddEven(value);
                              },
                              onClear: () {
                                controller.clearOddEven();
                              },
                            );
                          }),
                        );
                      },
                    ),
                    ClipButton(
                      text: '质合',
                      value: 1,
                      width: 66.w,
                      height: 26.w,
                      selected: controller.primeShrink.selected(),
                      onTap: (value) {
                        Constants.bottomSheet(
                          GetBuilder<Pl3ShrinkController>(
                              builder: (controller) {
                            return PrimeShrinkView(
                              height: 220.w,
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
                          GetBuilder<Pl3ShrinkController>(
                              builder: (controller) {
                            return RoadShrinkView(
                              height: 280.w,
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
                      text: '大小',
                      value: 1,
                      width: 66.w,
                      height: 26.w,
                      selected: controller.bigShrink.selected(),
                      onTap: (value) {
                        Constants.bottomSheet(
                          GetBuilder<Pl3ShrinkController>(
                              builder: (controller) {
                            return BigShrinkView(
                              height: 220.w,
                              model: controller.bigModel,
                              shrink: controller.bigShrink,
                              onTap: (value) {
                                controller.addBig(value);
                              },
                              onClear: () {
                                controller.clearBig();
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
                        controller.shrinkCalculate();
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
              color: Colors.red.withValues(alpha: 0.2),
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

  Widget _buildShrinkResult(Pl3ShrinkController controller) {
    List<List<int>> balls =
        controller.type == 0 ? controller.direct : controller.combine;
    if (balls.isEmpty) {
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
    return RepaintBoundary(
      key: controller.posterKey,
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 16.w),
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 12.w,
                runSpacing: 6.w,
                alignment: WrapAlignment.start,
                children: balls.map((e) => _buildLottery(e)).toList(),
              ),
            ),
            GestureDetector(
              onTap: () {
                PosterUtils.saveImage(controller.posterKey);
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: 34.w,
                color: const Color(0xFFFFF2EA),
                alignment: Alignment.center,
                child: Text(
                  controller.type == 0
                      ? '直选共${balls.length}注号码'
                      : '组选共${balls.length}注号码',
                  style: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLottery(List<int> balls) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: balls
          .map(
            (ball) => Container(
              margin: EdgeInsets.only(right: 2.w),
              child: Text(
                '$ball',
                style: TextStyle(
                  fontSize: 13.w,
                  fontFamily: 'bebas',
                  color: const Color(0xFFFF0033),
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildShrinkType(Pl3ShrinkController controller) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 28.w, 0, 0),
      child: Row(
        children: [
          ClipButton(
            text: '直选',
            value: 0,
            width: 60.w,
            height: 24.w,
            margin: 16.w,
            selected: controller.type == 0,
            onTap: (value) {
              controller.type = 0;
            },
          ),
          ClipButton(
            text: '组选',
            value: 1,
            width: 60.w,
            height: 24.w,
            selected: controller.type == 1,
            onTap: (value) {
              controller.type = 1;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDirectView(Pl3ShrinkController controller) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 12.w, 0, 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.w),
            child: _buildDirectItem('百位', 0, controller),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.w),
            child: _buildDirectItem('十位', 1, controller),
          ),
          _buildDirectItem('个位', 2, controller),
          Padding(
            padding: EdgeInsets.only(top: 8.w),
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
    );
  }

  Widget _ballD(int index, int value, Pl3ShrinkController controller) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      child: GestureDetector(
        onTap: () {
          controller.tapDirect(index, value);
        },
        child: Container(
          height: 23.sp,
          width: 23.sp,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(14.w),
            color: controller.directs[index]!.contains(value)
                ? const Color(0xFFFF0045)
                : const Color(0xFFF2F2F2),
          ),
          child: Text(
            '$value',
            style: TextStyle(
              fontSize: 13.sp,
              color: controller.directs[index]!.contains(value)
                  ? Colors.white
                  : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDirectItem(
      String name, int index, Pl3ShrinkController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 6.w),
          child: Text(
            name,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black87,
            ),
          ),
        ),
        Wrap(
          children: balls.map((e) {
            Widget view = _ballD(index, e, controller);
            return view;
          }).toList(),
        ),
      ],
    );
  }

  Widget _ballC(int value, Pl3ShrinkController controller) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      child: GestureDetector(
        onTap: () {
          controller.tapCombine(value);
        },
        child: Container(
          height: 23.w,
          width: 23.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: controller.combines.contains(value)
                ? const Color(0xFFFF0045)
                : const Color(0xFFF2F2F2),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            '$value',
            style: TextStyle(
              fontSize: 13.sp,
              color: controller.combines.contains(value)
                  ? Colors.white
                  : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCombineView(Pl3ShrinkController controller) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 12.w, 0, 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            children: balls.map((e) {
              Widget view = _ballC(e, controller);
              return view;
            }).toList(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.w),
            child: Text(
              '注：点击号码选择排除，再次点击选中',
              style: TextStyle(
                color: Colors.black26,
                fontSize: 12.sp,
              ),
            ),
          )
        ],
      ),
    );
  }
}
