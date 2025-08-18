import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CachedAvatar extends StatelessWidget {
  ///
  ///
  const CachedAvatar({
    super.key,
    required this.width,
    required this.url,
    this.height,
    this.radius = 0,
    this.opacity = 1.0,
    this.progress = false,
    this.fit = BoxFit.cover,
    this.color = const Color(0xFFFAFAFA),
    this.placeColor,
    this.errorColor,
  });

  final double width;
  final double? height;
  final Color color;
  final Color? placeColor;
  final Color? errorColor;
  final String url;
  final double radius;
  final double opacity;
  final BoxFit? fit;
  final bool progress;

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
      );
    }
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      imageBuilder: (context, provider) {
        return Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(
              image: provider,
              opacity: opacity,
              fit: fit,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          decoration: BoxDecoration(
            color: errorColor ?? color,
            borderRadius: BorderRadius.circular(radius),
          ),
        );
      },
      placeholder: (context, url) {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: placeColor ?? color,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: progress
              ? SizedBox(
                  width: min(width / 3, 20.w),
                  height: min(width / 3, 20.w),
                  child: CircularProgressIndicator(
                    strokeWidth: 1.2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.grey.withValues(alpha: 0.1),
                    ),
                  ),
                )
              : Container(),
        );
      },
    );
  }
}
