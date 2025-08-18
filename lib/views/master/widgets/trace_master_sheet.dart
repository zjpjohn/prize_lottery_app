import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prize_lottery_app/base/model/stat_hit_value.dart';
import 'package:prize_lottery_app/widgets/modal_sheet_view.dart';

class TraceStatHit {
  final String trace;
  final String traceZh;
  final StatHitValue hit;

  TraceStatHit({
    required this.trace,
    required this.traceZh,
    required this.hit,
  });
}

typedef TraceTapCallback = Function(String trace, String traceZh);

class TraceMasterSheet extends StatefulWidget {
  const TraceMasterSheet({
    super.key,
    required this.title,
    required this.trace,
    required this.traceZh,
    required this.onTrace,
    required this.hits,
    this.leftTitle,
    this.leftTap,
  });

  final String title;
  final String? leftTitle;
  final String trace;
  final String traceZh;
  final TraceTapCallback onTrace;
  final GestureTapCallback? leftTap;
  final List<TraceStatHit> hits;

  @override
  State<TraceMasterSheet> createState() => _TraceMasterSheetState();
}

class _TraceMasterSheetState extends State<TraceMasterSheet> {
  ///
  /// 追踪字段值
  late String trace;

  /// 追踪字段中文名
  late String traceZh;

  @override
  void initState() {
    super.initState();
    trace = widget.trace;
    traceZh = widget.traceZh;
  }

  @override
  Widget build(BuildContext context) {
    return ModalSheetView(
      title: widget.title,
      border: false,
      leftTxt: widget.leftTitle,
      leftTap: widget.leftTap,
      color: const Color(0xFFF8F8F8),
      height: MediaQuery.of(context).size.height * 0.50,
      child: _buildTraceContent(),
    );
  }

  Widget _buildTraceContent() {
    return Padding(
      padding: EdgeInsets.only(top: 8.w),
      child: Column(
        children: widget.hits.map((e) => _buildTraceItem(e)).toList(),
      ),
    );
  }

  Widget _buildTraceItem(TraceStatHit hit) {
    return GestureDetector(
      onTap: () {
        widget.onTrace(hit.trace, hit.traceZh);
        setState(() {
          trace = hit.trace;
          traceZh = hit.traceZh;
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 14.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
        decoration: BoxDecoration(
          color: hit.trace == trace
              ? Colors.orangeAccent.withValues(alpha: 0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(4.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              hit.traceZh,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            RichText(
              text: TextSpan(
                text: '最近${hit.hit.count}期',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 13.sp,
                ),
                children: [
                  TextSpan(
                    text:
                        hit.hit.series == 0 ? '上期未命中' : '连中${hit.hit.series}期',
                    style: const TextStyle(
                      color: Color(0xFFFF0033),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
