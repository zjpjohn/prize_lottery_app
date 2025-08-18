import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/utils/tools.dart';
import 'package:prize_lottery_app/views/glad/model/master_glad.dart';
import 'package:prize_lottery_app/views/home/widgets/achieve_tag_view.dart';
import 'package:prize_lottery_app/views/home/widgets/glad_header.dart';
import 'package:prize_lottery_app/widgets/tag_mark.dart';

typedef GladRateCallback<T extends MasterGlad> = List<String> Function(T glad);
typedef AchieveTagCallback<T extends MasterGlad> = List<AchieveTag> Function(
    T glad);
typedef MasterInfoCallback<T extends MasterGlad> = void Function(T glad);

class MasterGladPanel<T extends MasterGlad> extends StatelessWidget {
  ///
  const MasterGladPanel({
    super.key,
    required this.glads,
    required this.colors,
    required this.moreAction,
    required this.rateCallback,
    required this.tagCallback,
    required this.masterCallback,
  });

  final List<T> glads;
  final List<Color> colors;
  final GladRateCallback<T> rateCallback;
  final AchieveTagCallback<T> tagCallback;
  final MasterInfoCallback<T> masterCallback;
  final GestureTapCallback moreAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.w),
      padding: EdgeInsets.only(bottom: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Column(
        children: [
          _buildGladHeader(),
          ..._buildGladItems(glads),
        ],
      ),
    );
  }

  Widget _buildGladHeader() {
    return Container(
      padding: EdgeInsets.only(
        top: 12.w,
        bottom: 4.w,
        left: 12.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: GladHeader(colors: colors),
          ),
          GestureDetector(
            onTap: moreAction,
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.w),
              child: Row(
                children: [
                  Text(
                    '更多',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 11.sp,
                    ),
                  ),
                  Icon(
                    const IconData(0xe690, fontFamily: 'iconfont'),
                    size: 12.w,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildGladItems(List<T> glads) {
    List<Widget> views = [];
    for (int i = 0; i < glads.length; i++) {
      views.add(_buildGladItem(glads[i], i == glads.length - 1));
    }
    return views;
  }

  Widget _buildGladItem(T glad, bool bottom) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: bottom
              ? BorderSide.none
              : BorderSide(color: Colors.black12, width: 0.15.w),
        ),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          masterCallback(glad);
        },
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(14.w, 0, 16.w, 0),
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 2.w),
              child: CachedNetworkImage(
                width: 60.w,
                height: 68.w,
                fit: BoxFit.cover,
                imageUrl: glad.master.avatar,
                placeholder: (context, uri) => Center(
                  child: SizedBox(
                    width: 18.w,
                    height: 18.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.grey.withValues(alpha: 0.1),
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: Colors.black12,
                  size: 18.w,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 70.w,
                margin: EdgeInsets.only(right: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          Tools.limitName(glad.master.name, 10),
                          style: TextStyle(
                              color: const Color(0xFF5C5C5C), fontSize: 14.sp),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '详情',
                                style: TextStyle(
                                  color: Colors.black26,
                                  fontSize: 10.sp,
                                ),
                              ),
                              Icon(
                                const IconData(0xe613, fontFamily: 'iconfont'),
                                size: 12.w,
                                color: Colors.black12,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 8.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 2.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(2.0.w),
                            color: Colors.blueAccent.withValues(alpha: 0.12),
                          ),
                          child: Text(
                            '擅长',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                        ...rateCallback(glad).map((e) => OutlineTag(name: e)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: tagCallback(glad),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
