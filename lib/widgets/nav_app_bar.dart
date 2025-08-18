import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

const double baseHeight = 44;

class NavAppBar extends StatelessWidget {
  const NavAppBar({
    super.key,
    required this.center,
    this.left,
    this.right,
    this.border = true,
    this.color = Colors.white,
    this.gradients,
  });

  final bool border;
  final Widget center;
  final Widget? left;
  final Widget? right;
  final Color color;
  final List<Color>? gradients;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      decoration: BoxDecoration(
        color: gradients == null || gradients!.isEmpty
            ? color
            : Colors.transparent,
        border: Border(
          bottom: (gradients == null || gradients!.isEmpty) && border
              ? BorderSide(color: Colors.black12, width: 0.20.w)
              : BorderSide.none,
        ),
        gradient: gradients != null ? LinearGradient(colors: gradients!) : null,
      ),
      child: PreferredSize(
        preferredSize: Size.fromHeight(baseHeight.w),
        child: SizedBox(
          height: baseHeight.w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: left != null
                    ? InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: left,
                        ),
                      )
                    : Container(
                        alignment: Alignment.centerLeft,
                        child: null,
                      ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  alignment: Alignment.center,
                  child: center,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: right,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
