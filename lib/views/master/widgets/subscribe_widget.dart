import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubScribeWidget extends StatefulWidget {
  ///专家类型
  ///
  final String type;

  ///专家id
  ///
  final String masterId;

  ///是否已订阅
  final int subscribe;

  const SubScribeWidget({
    super.key,
    required this.type,
    required this.masterId,
    required this.subscribe,
  });

  @override
  SubScribeWidgetState createState() => SubScribeWidgetState();
}

class SubScribeWidgetState extends State<SubScribeWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          Offstage(
            offstage: widget.subscribe != 0,
            child: Container(
              width: 76.w,
              margin: EdgeInsets.only(right: 16.w),
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 28.w,
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xFFFD4A68),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(3.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '订阅Ta',
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 2.w),
                        child: Icon(
                          const IconData(0xe637, fontFamily: 'iconfont'),
                          size: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Offstage(
            offstage: widget.subscribe != 1,
            child: Container(
              width: 76.w,
              margin: EdgeInsets.only(right: 16.w),
              child: InkWell(
                onTap: () {
                  EasyLoading.showToast('您已订阅');
                },
                child: Container(
                  height: 28.w,
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xffFF421A),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(3.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '已订阅',
                        style: TextStyle(color: Colors.white, fontSize: 15.sp),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 2.w),
                        child: Icon(
                          const IconData(0xe638, fontFamily: 'iconfont'),
                          size: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
