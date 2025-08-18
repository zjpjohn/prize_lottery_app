import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prize_lottery_app/resources/resources.dart';

typedef OnValueChanged = void Function(String value);
typedef OnSubmitted = void Function(String value);
typedef OnCancelClick = void Function(String value);

class SearchInput extends StatefulWidget {
  ///
  ///
  const SearchInput({
    super.key,
    this.searchHeight = 48,
    this.hintText,
    this.value = '',
    this.vertical = 8,
    this.changeDuration = 500,
    this.onValueChanged,
    this.onSubmitted,
    this.onCancel,
    required this.controller,
  });

  final double searchHeight;
  final String? hintText;
  final String? value;
  final double vertical;
  final int changeDuration;
  final TextEditingController controller;
  final OnValueChanged? onValueChanged;
  final OnSubmitted? onSubmitted;
  final OnCancelClick? onCancel;

  @override
  SearchInputState createState() => SearchInputState();
}

class SearchInputState extends State<SearchInput> {
  ///
  final FocusNode _focusNode = FocusNode();

  ///
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.searchHeight,
      child: Row(
        children: [
          SizedBox(width: 16.w),
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: widget.vertical),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(5.w),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: Icon(
                        const IconData(0xe650, fontFamily: 'iconfont'),
                        size: 16.sp,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.w),
                        height: widget.searchHeight,
                        alignment: Alignment.center,
                        child: TextField(
                          maxLines: 1,
                          focusNode: _focusNode,
                          textInputAction: TextInputAction.search,
                          controller: widget.controller,
                          textAlignVertical: TextAlignVertical.top,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14.sp,
                            decoration: TextDecoration.none,
                          ),
                          decoration: InputDecoration(
                            hintText: widget.hintText ?? '',
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                          ),
                          onSubmitted: (text) {
                            if (widget.onSubmitted != null) {
                              widget.onSubmitted!(text);
                            }
                          },
                          onChanged: (text) {
                            _startChangeTimer(text);
                          },
                        ),
                      ),
                    ),
                    if (widget.controller.text.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(right: 8.w),
                        child: GestureDetector(
                          onTap: () {
                            widget.controller.clear();
                            if (widget.onCancel != null) {
                              widget.onCancel!(widget.controller.text);
                            }
                          },
                          child: Image.asset(
                            R.close,
                            width: 16.w,
                            height: 16.w,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (widget.controller.text.isNotEmpty) {
                widget.controller.clear();
                if (widget.onCancel != null) {
                  widget.onCancel!(widget.controller.text);
                }
                _focusNode.unfocus();
                return;
              }
              Get.back();
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 64.w,
              height: widget.searchHeight,
              alignment: Alignment.center,
              child: Text(
                '取消',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startChangeTimer(String value) {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer(Duration(milliseconds: widget.changeDuration), () {
      if (widget.onValueChanged != null) {
        widget.onValueChanged!(widget.controller.text);
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
  }
}
