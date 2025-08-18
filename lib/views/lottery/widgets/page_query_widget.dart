import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

const List<int> pageList = [50, 100, 150, 200];
const List<int> pianList = [20, 40, 60, 80];

typedef PageTapCallback = Function(int);

class PageQueryWidget extends StatelessWidget {
  const PageQueryWidget({
    super.key,
    this.page = 50,
    this.pages = pageList,
    required this.onTap,
    required this.toMaster,
  });

  final int page;
  final List<int> pages;
  final PageTapCallback onTap;
  final String toMaster;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(children: _pageViews()),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(toMaster);
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            height: 32.h,
            alignment: Alignment.center,
            color: const Color(0xFFFF0045),
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              '查看专家推荐',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _pageViews() {
    List<Widget> views = [];
    for (int i = 0; i < pages.length; i++) {
      views.add(
        Expanded(
          child: GestureDetector(
            onTap: () {
              onTap(pages[i]);
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              height: 32.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: page == pages[i]
                    ? const Color(0xFFF1F1F1)
                    : Colors.transparent,
                border: Border(
                  top: BorderSide(color: const Color(0xFFF1F1F1), width: 0.5.w),
                  bottom:
                  BorderSide(color: const Color(0xFFF1F1F1), width: 0.5.w),
                  left: i > 0
                      ? BorderSide(color: const Color(0xFFF1F1F1), width: 0.8.w)
                      : BorderSide.none,
                ),
              ),
              child: Text(
                '${pages[i]}期',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return views;
  }
}
