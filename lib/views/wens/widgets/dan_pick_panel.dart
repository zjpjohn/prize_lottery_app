import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/views/lottery/utils/num3_lottery_utils.dart';
import 'package:prize_lottery_app/views/shrink/widgets/clip_button.dart';
import 'package:prize_lottery_app/views/wens/controller/wens_filter_controller.dart';
import 'package:prize_lottery_app/widgets/modal_sheet_view.dart';

typedef DataLoader = List<int> Function();
typedef DataSelected = bool Function();
typedef ValuePick = void Function(int);
typedef ValueSelected = bool Function(int);
typedef ValueDisabled = bool Function(int);

class DirectPickPanel extends StatelessWidget {
  const DirectPickPanel({
    super.key,
    this.height = 600,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return ModalSheetView(
      title: '定位选择',
      height: height,
      child: _buildContainer(),
    );
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.center,
      child: GetBuilder<WensFilterController>(
        builder: (controller) {
          return Column(
            children: [
              SizedBox(height: 12.w),
              _buildDirectView(
                  '百位定位', controller.filter.direct[0]!, controller),
              _buildDirectView(
                  '十位定位', controller.filter.direct[1]!, controller),
              _buildDirectView(
                  '个位定位', controller.filter.direct[2]!, controller),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDirectView(
      String title, List<int> direct, WensFilterController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 16.w, bottom: 8.w),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14.sp,
            ),
          ),
        ),
        Wrap(
          runSpacing: 12.w,
          spacing: 12.w,
          children: [
            ...List.generate(10, (i) => i).map((e) => ClipButton(
                  text: '$e',
                  value: e,
                  width: 32.w,
                  height: 32.w,
                  fontSize: 14.sp,
                  selected: direct.contains(e),
                  disable: controller.filter.killList.contains(e),
                  onTap: (value) {
                    controller.directPick(e, direct);
                  },
                )),
            GestureDetector(
              onTap: () {
                controller.directClear(direct);
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 46.w,
                height: 32.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  '清空',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DanGroupPickPanel extends StatelessWidget {
  const DanGroupPickPanel({
    super.key,
    this.height = 600,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return ModalSheetView(
      title: '胆码选择',
      height: height,
      child: _buildContainer(),
    );
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.center,
      child: GetBuilder<WensFilterController>(
        builder: (controller) {
          return Column(
            children: [
              SizedBox(height: 12.w),
              _buildGroup1View(controller),
              _buildGroup2View('胆码组二', controller.filter.danList2, controller),
              _buildGroup2View('胆码组三', controller.filter.danList3, controller),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGroup1View(WensFilterController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.w),
          child: Text(
            '胆码组一',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14.sp,
            ),
          ),
        ),
        Wrap(
          runSpacing: 12.w,
          spacing: 12.w,
          children: [
            ...List.generate(10, (i) => i).map((e) => ClipButton(
                  text: '$e',
                  value: e,
                  width: 32.w,
                  height: 32.w,
                  fontSize: 14.sp,
                  disable: controller.filter.killList.contains(e),
                  selected: controller.filter.danList1.contains(e),
                  onTap: (value) {
                    controller.danPick(e, controller.filter.danList1);
                  },
                )),
            GestureDetector(
              onTap: () {
                controller.clearDan(controller.filter.danList1);
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 46.w,
                height: 32.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  '清空',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.enableWeekDan();
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 68.w,
                height: 32.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  '推荐胆码',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGroup2View(
      String title, List<int> danList, WensFilterController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 16.w, bottom: 8.w),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14.sp,
            ),
          ),
        ),
        Wrap(
          runSpacing: 12.w,
          spacing: 12.w,
          children: [
            ...List.generate(10, (i) => i).map((e) => ClipButton(
                  text: '$e',
                  value: e,
                  width: 32.w,
                  height: 32.w,
                  fontSize: 14.sp,
                  selected: danList.contains(e),
                  disable: controller.filter.killList.contains(e),
                  onTap: (value) {
                    controller.danPick(e, danList);
                  },
                )),
            GestureDetector(
              onTap: () {
                controller.clearDan(danList);
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 46.w,
                height: 32.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  '清空',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DuanZuPickPanel extends StatelessWidget {
  const DuanZuPickPanel({
    super.key,
    this.height = 320,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return ModalSheetView(
      title: '奖号断组',
      height: height,
      child: _buildContainer(),
    );
  }

  Widget _buildContainer() {
    return GetBuilder<WensFilterController>(
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            children: [
              _buildDuanZu(
                  '6-2-2断组一', controller.filter.currDuanZu, controller),
              _buildDuanZu(
                  '6-2-2断组二', controller.filter.lastDuanZu, controller),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDuanZu(String title, Map<int, DuanZuInfo> duanZu,
      WensFilterController controller) {
    if (duanZu.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 18.w, bottom: 10.w),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 15.sp,
            ),
          ),
        ),
        Row(
          children: duanZu.entries
              .map((e) => ClipButton(
                    text: e.value.txt,
                    value: e.key,
                    width: 104.w,
                    height: 34.w,
                    fontSize: 13.sp,
                    margin: 12.w,
                    selected: e.value.excludes.isNotEmpty,
                    onTap: (value) {
                      controller.enableDuanZu(e.value);
                    },
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class DanPickPanel extends StatelessWidget {
  const DanPickPanel({
    super.key,
    required this.title,
    required this.remark,
    this.subRemark,
    this.height = 200,
    required this.loader,
    required this.onTap,
    required this.selected,
  });

  final String title;
  final String remark;
  final String? subRemark;
  final double height;
  final DataLoader loader;
  final DataSelected selected;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ModalSheetView(
      title: title,
      height: height,
      child: _buildContainer(),
    );
  }

  Widget _buildContainer() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...loader().map(
                (e) => Container(
                  height: 36.w,
                  width: 36.w,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xfff4f4f4),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: Text(
                    '$e',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.black87,
                      fontFamily: 'bebas',
                    ),
                  ),
                ),
              ),
              ClipButton(
                text: selected() ? '禁用' : '启用',
                value: 0,
                width: 46.w,
                height: 36.w,
                selected: selected(),
                onTap: (value) {
                  onTap();
                },
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.w),
            child: Text(
              remark,
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12.sp,
              ),
            ),
          ),
          if (subRemark != null)
            Padding(
              padding: EdgeInsets.only(top: 2.w),
              child: Text(
                subRemark!,
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 12.sp,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class KuaSumPanel extends StatelessWidget {
  const KuaSumPanel({
    super.key,
    required this.title,
    required this.remark,
    this.height = 200,
    required this.loader,
    required this.pick,
    required this.selected,
  });

  final String title;
  final String remark;
  final double height;
  final DataLoader loader;
  final ValuePick pick;
  final ValueSelected selected;

  @override
  Widget build(BuildContext context) {
    return ModalSheetView(
      title: title,
      height: height,
      child: _buildContainer(),
    );
  }

  Widget _buildContainer() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            runSpacing: 12.w,
            spacing: 12.w,
            children: [
              ...loader().map(
                (e) => ClipButton(
                  text: '$e',
                  value: e,
                  width: 32.w,
                  height: 32.w,
                  fontSize: 14.sp,
                  selected: selected(e),
                  onTap: (value) {
                    pick(value);
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.w),
            child: Text(
              remark,
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DanKillPanel extends StatelessWidget {
  const DanKillPanel({
    super.key,
    required this.title,
    required this.remark,
    this.height = 200,
    required this.loader,
    required this.pick,
    required this.selected,
    required this.disabled,
  });

  final String title;
  final String remark;
  final double height;
  final DataLoader loader;
  final ValuePick pick;
  final ValueSelected selected;
  final ValueDisabled disabled;

  @override
  Widget build(BuildContext context) {
    return ModalSheetView(
      title: title,
      height: height,
      child: _buildContainer(),
    );
  }

  Widget _buildContainer() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            runSpacing: 12.w,
            spacing: 12.w,
            children: [
              ...loader().map(
                (e) => ClipButton(
                  text: '$e',
                  value: e,
                  width: 32.w,
                  height: 32.w,
                  fontSize: 14.sp,
                  disable: disabled(e),
                  selected: selected(e),
                  onTap: (value) {
                    pick(value);
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.w),
            child: Text(
              remark,
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DiffSumPanel extends StatelessWidget {
  const DiffSumPanel({
    super.key,
    required this.title,
    required this.remark,
    this.height = 200,
    required this.loader,
    required this.pick,
    required this.selected,
    required this.recEnable,
  });

  final String title;
  final String remark;
  final double height;
  final DataLoader loader;
  final ValuePick pick;
  final ValueSelected selected;
  final Function recEnable;

  @override
  Widget build(BuildContext context) {
    return ModalSheetView(
      title: title,
      height: height,
      child: _buildContainer(),
    );
  }

  Widget _buildContainer() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            runSpacing: 12.w,
            spacing: 12.w,
            children: [
              ...loader().map(
                (e) => ClipButton(
                  text: '$e',
                  value: e,
                  width: 32.w,
                  height: 32.w,
                  fontSize: 14.sp,
                  selected: selected(e),
                  onTap: (value) {
                    pick(value);
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  recEnable();
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 68.w,
                  height: 32.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F6),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    '系统推荐',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.w),
            child: Text(
              remark,
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TwoMaPanel extends StatefulWidget {
  const TwoMaPanel({
    super.key,
    required this.height,
  });

  final double height;

  @override
  State<TwoMaPanel> createState() => _TwoMaPanelState();
}

class _TwoMaPanelState extends State<TwoMaPanel> {
  ///
  ///
  List<int> _twoMa = [];

  @override
  Widget build(BuildContext context) {
    return ModalSheetView(
      title: '自配两码',
      height: widget.height,
      child: _buildContainer(),
    );
  }

  Widget _buildContainer() {
    return GetBuilder<WensFilterController>(
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTwoMaResult(controller),
              Wrap(
                runSpacing: 12.w,
                spacing: 12.w,
                children: [
                  ...List.generate(10, (i) => i).map(
                    (e) => ClipButton(
                      text: '$e',
                      value: e,
                      width: 32.w,
                      height: 32.w,
                      fontSize: 14.sp,
                      selected: _twoMa.contains(e),
                      onTap: (value) {
                        if (_twoMa.contains(value)) {
                          _twoMa.remove(value);
                        } else {
                          _twoMa.add(value);
                        }
                        setState(() {});
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_twoMa.length < 2) {
                        EasyLoading.showToast('请正确选择两码');
                        return;
                      }
                      controller.twoMaPick(_twoMa);
                      _twoMa = [];
                      setState(() {});
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 46.w,
                      height: 32.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F6F6),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        '确定',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.enableTwoMa();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 68.w,
                      height: 32.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F6F6),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        '系统推荐',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.w),
                child: Text(
                  '注：选择两码点击确定添加，点击两码组合进行删除',
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTwoMaResult(WensFilterController controller) {
    if (controller.filter.twoMa.isEmpty) {
      return Container(
        height: 32.w,
        margin: EdgeInsets.symmetric(vertical: 16.w),
        alignment: Alignment.centerLeft,
        child: Text(
          '请选择您的两码组合',
          style: TextStyle(
            color: Colors.black45,
            fontSize: 13.sp,
          ),
        ),
      );
    }
    List<Widget> views = [];
    for (int i = 0; i < controller.filter.twoMa.length; i++) {
      views.add(GestureDetector(
        onTap: () {
          controller.removeTwoMa(i);
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 32.w,
          height: 32.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFF6F6F6),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            controller.filter.twoMa[i].join(''),
            style: TextStyle(
              color: Colors.black87,
              fontSize: 12.sp,
            ),
          ),
        ),
      ));
    }
    views.add(
      GestureDetector(
        onTap: () {
          controller.clearTwoMa();
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 40.w,
          height: 32.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFF6F6F6),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            '清空',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 12.sp,
            ),
          ),
        ),
      ),
    );
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(vertical: 16.w),
      child: Wrap(
        spacing: 12.w,
        runSpacing: 12.w,
        children: views,
      ),
    );
  }
}
