import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/base/widgets/request_widget.dart';
import 'package:prize_lottery_app/routes/names.dart';
import 'package:prize_lottery_app/views/recom/controller/num3_layer_controller.dart';
import 'package:prize_lottery_app/views/recom/model/n3_warn_recommend.dart';
import 'package:prize_lottery_app/views/recom/model/num3_layer_filter.dart';
import 'package:prize_lottery_app/views/recom/widgets/member_hint_widget.dart';
import 'package:prize_lottery_app/views/recom/widgets/warn_mock_widget.dart';
import 'package:prize_lottery_app/widgets/corner_badge.dart';
import 'package:prize_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:prize_lottery_app/widgets/layout_container.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

class Num3LayerView extends StatelessWidget {
  const Num3LayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '预警推荐',
      border: false,
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
      content: RequestWidget<Num3LayerController>(
        emptyText: '暂无预警推荐内容',
        builder: (controller) {
          return Stack(
            children: [
              ScrollConfiguration(
                behavior: CustomScrollBehavior(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildWarnHeader(controller),
                      _buildLastAnalyze(controller),
                      _buildLayerContent(controller),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 12.w,
                bottom: Get.height / 2 - 88.h,
                child: _buildPeriodView(controller),
              ),
            ],
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
              '预警分析说明',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.w),
              child: Text(
                '1.预警分析功能是系统对本期开奖数据进行分析给出定胆、杀码以及跨度等预警，并给出优选的组选号码。'
                '\n2.预警分析最新分析数据会在下午17:30点至19点发布，期间可能会对数据进行多次修正。'
                '\n3.预警分析给出的组选号码相对较多，请用户结合自身选号经验，选择自己看中的组合。'
                '\n4.为保护应用内容安全，本功能禁用系统截屏，如有需要请长按预警内容保存图片。',
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

  Widget _buildWarnHeader(Num3LayerController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.w),
            child: Text(
              controller.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    controller.type == 'fc3d' ? '福彩3D' : '排列三',
                    style: TextStyle(
                      color: const Color(0xFFFF0033),
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    '·第${controller.layer.period}期',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              RichText(
                text: TextSpan(
                  text: '${controller.layer.data!.browses}',
                  style: TextStyle(
                    color: const Color(0xFFFF0033),
                    fontSize: 14.sp,
                  ),
                  children: [
                    TextSpan(
                      text: '人查看',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLastAnalyze(Num3LayerController controller) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        bottom: 12.w,
      ),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 6.w),
            child: Text(
              '第${controller.layer.data!.last.period}期开奖回顾:',
              style: TextStyle(
                fontSize: 17.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ..._buildLottery(controller.layer.data!.last),
        ],
      ),
    );
  }

  List<Widget> _buildLottery(Lottery lottery) {
    return [
      RichText(
        text: TextSpan(
          text: '本期开奖号码：',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.sp,
          ),
          children: [
            TextSpan(
              text: lottery.red.join('、'),
            ),
          ],
        ),
      ),
      Row(
        children: [
          SizedBox(
            width: 156.w,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                ),
                children: [
                  const TextSpan(text: '开奖号码形态：'),
                  TextSpan(
                    text: lottery.pattern ?? '',
                    style: TextStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 156.w,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                ),
                children: [
                  const TextSpan(
                    text: '开奖号码跨度：',
                  ),
                  TextSpan(
                    text: '${lottery.kua ?? 0}',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          SizedBox(
            width: 156.w,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                ),
                children: [
                  const TextSpan(
                    text: '开奖号码和值：',
                  ),
                  TextSpan(
                    text: '${lottery.sum ?? 0}',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 156.w,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                ),
                children: [
                  const TextSpan(
                    text: '开奖和值尾数：',
                  ),
                  TextSpan(
                    text: '${lottery.sumTail ?? 0}',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          SizedBox(
            width: 156.w,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                ),
                children: [
                  const TextSpan(
                    text: '开奖号码奇偶：',
                  ),
                  TextSpan(
                    text: lottery.oddEven ?? '',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 156.w,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                ),
                children: [
                  const TextSpan(
                    text: '开奖号码质合：',
                  ),
                  TextSpan(
                    text: lottery.primeRatio ?? '',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ];
  }

  Widget _buildPeriodView(Num3LayerController controller) {
    return Container(
      width: 34.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.w),
        border: Border.all(color: Colors.black26, width: 0.4.w),
      ),
      padding: EdgeInsets.symmetric(vertical: 10.w),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (!controller.isFirst()) {
                controller.prevPeriod();
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Column(
              children: [
                Icon(
                  const IconData(0xe682, fontFamily: 'iconfont'),
                  size: 14.w,
                  color: controller.isFirst()
                      ? Colors.black26
                      : const Color(0xFFFF0033),
                ),
                Text(
                  '上期',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: controller.isFirst()
                        ? Colors.black26
                        : const Color(0xFFFF0033),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.4.w,
            width: 34.w,
            color: Colors.black26,
            margin: EdgeInsets.symmetric(vertical: 10.w),
          ),
          GestureDetector(
            onTap: () {
              if (!controller.isEnd()) {
                controller.nextPeriod();
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Column(
              children: [
                Text(
                  '下期',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: controller.isEnd()
                        ? Colors.black26
                        : const Color(0xFFFF0033),
                  ),
                ),
                Icon(
                  const IconData(0xe683, fontFamily: 'iconfont'),
                  size: 14.w,
                  color: controller.isEnd()
                      ? Colors.black26
                      : const Color(0xFFFF0033),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLayerContent(Num3LayerController controller) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        bottom: 16.w,
      ),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.w),
            child: Text(
              '第${controller.layer.period}期预警分析:',
              style: TextStyle(
                fontSize: 17.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 12.w),
            child: Text(
              '根据上期开奖数据及形态多维指标，结合系统独有算法计算分析，本期可能选号预警推荐如下:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
              ),
            ),
          ),
          controller.layer.feeRequired
              ? _buildUnAuthedContent(controller)
              : _buildAuthedContent(controller)
        ],
      ),
    );
  }

  Widget _buildUnAuthedContent(Num3LayerController controller) {
    return GestureDetector(
      onTap: () {
        Get.offNamed(AppRoutes.member);
      },
      child: Column(
        children: [
          Stack(
            children: [
              ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 2.5.w, sigmaY: 2.5.w),
                child: const WarnMockWidget(),
              ),
              MemberHintWidget(
                width: Get.width - 32.w,
                height: 200.w,
                period: controller.layer.period,
                name: '预警推荐',
              ),
            ],
          ),
          _buildWarnHint(),
        ],
      ),
    );
  }

  Widget _buildAuthedContent(Num3LayerController controller) {
    Num3Layer layer = controller.layer.data!;
    return GestureDetector(
      onTap: () {
        controller.saveCaptureWidget(() => _buildPosterWidget(controller));
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLayerRecommend("参考大底", controller.layer.data!.layer1),
          _buildLayerRecommend("跨度预警", getFocus(controller.layer.data!)),
          _buildLayerRecommend("和值预警", getLast(controller.layer.data!)),
          if (layer.current != null) ..._buildLottery(layer.current!),
          _buildWarnHint(),
        ],
      ),
    );
  }

  LayerValue? getFocus(Num3Layer layer) {
    if (layer.layer2.name.contains('跨度')) {
      return layer.layer2;
    }
    if (layer.layer3.name.contains('跨度')) {
      return layer.layer3;
    }
    return null;
  }

  LayerValue? getLast(Num3Layer layer) {
    if (layer.layer3.name.contains('和值')) {
      return layer.layer3;
    }
    if (layer.layer4.name.contains('和值')) {
      return layer.layer4;
    }
    return null;
  }

  Widget _buildLayerRecommend(String title, LayerValue? layer) {
    if (layer == null) {
      return const SizedBox.shrink();
    }
    return Stack(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(bottom: 14.w),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.w),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(6),
                offset: Offset(0, -2.w),
                blurRadius: 3.w,
              ),
              BoxShadow(
                color: Colors.black.withAlpha(6),
                offset: Offset(0, 2.w),
                blurRadius: 3.w,
              ),
              BoxShadow(
                color: Colors.black.withAlpha(6),
                offset: Offset(2.w, 0),
                blurRadius: 3.w,
              ),
              BoxShadow(
                color: Colors.black.withAlpha(6),
                offset: Offset(-2.w, 0),
                blurRadius: 3.w,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8.w),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              warnItem(
                '${layer.name}推荐',
                layer.condition,
              ),
              if (layer.zu3.items.isNotEmpty)
                recommendItem(
                  title: '组三[${layer.zu3.items.length * 2}注]',
                  recommend: layer.zu3,
                ),
              recommendItem(
                title: '组六[${layer.zu6.items.length}注]',
                recommend: layer.zu6,
              ),
            ],
          ),
        ),
        if (layer.hit >= 1)
          Positioned(
            right: 1.5.w,
            top: 1.5.w,
            child: CornerBadge(
              badge: '命中',
              size: 34.w,
              color: Colors.white,
              position: BadgePosition.topEnd,
              radius: BorderRadius.only(
                topRight: Radius.circular(6.w),
              ),
              background: const Color(0xFFFF0044),
            ),
          ),
      ],
    );
  }

  Widget warnItem(String title, List<int> values) {
    return Wrap(
      children: [
        Container(
          height: 22.w,
          padding: EdgeInsets.only(right: 4.w, top: 2.w),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
            ),
          ),
        ),
        ...values.map((e) {
          return Container(
            height: 22.w,
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Text(
              '$e',
              style: TextStyle(
                fontSize: 17.sp,
                fontFamily: 'shuhei',
                color: const Color(0xCC000000),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget recommendItem(
      {required String title, required WarnComplex recommend}) {
    return Wrap(
      children: [
        Container(
          height: 22.w,
          padding: EdgeInsets.only(right: 4.w, top: 2.w),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black,
            ),
          ),
        ),
        ...recommend.items.map((e) {
          return Container(
            height: 22.w,
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: e.valueView(),
          );
        }),
      ],
    );
  }

  Widget _buildPosterWidget(Num3LayerController controller) {
    Num3Layer data = controller.layer.data!;
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 16.w, top: 24.w),
            child: Text(
              '第${data.period}期${data.type.description}预警分析',
              style: TextStyle(
                fontSize: 17.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 12.w),
            child: Text(
              '根据上期开奖数据多维指标，结合系统独家算法分析计算，本期可能选号预警推荐如下:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
              ),
            ),
          ),
          _buildLayerRecommend("参考大底", controller.layer.data!.layer1),
          _buildLayerRecommend("跨度预警", getFocus(controller.layer.data!)),
          _buildLayerRecommend("和值预警", getLast(controller.layer.data!)),
          _buildShareHint(),
        ],
      ),
    );
  }

  Widget _buildShareHint() {
    return Container(
      padding: EdgeInsets.only(left: 4.w, top: 4.sp, bottom: 16.w),
      child: Text(
        '温馨提示：数字彩具有随机性，以上内容仅供参考，请您理性购彩。',
        style: TextStyle(
          color: Colors.black45,
          fontSize: 12.sp,
        ),
      ),
    );
  }

  Widget _buildWarnHint() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.w),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            '以上内容仅供参考，不作为投注依据，请您理性购彩',
            style: TextStyle(
              color: Colors.black38,
              fontSize: 11.sp,
            ),
          ),
          Text(
            '备注说明：本页面禁止系统截屏，用户可长按预警内容保存图片',
            style: TextStyle(
              color: Colors.black38,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }
}
