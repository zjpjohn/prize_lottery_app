import 'dart:async';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AspectRatioCacheImage extends StatelessWidget {
  ///
  ///
  const AspectRatioCacheImage({
    super.key,
    required this.url,
    required this.width,
    required this.height,
    this.radius = 0,
    this.opacity = 1.0,
    this.progress = false,
    this.fit = BoxFit.cover,
    this.color = const Color(0xFFFAFAFA),
  });

  final String url;
  final double width;
  final double height;
  final Color color;
  final double radius;
  final double opacity;
  final BoxFit? fit;
  final bool progress;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, provider) {
        Completer<ui.Image> completer = Completer<ui.Image>();
        ImageStream stream = provider.resolve(ImageConfiguration.empty);
        late ImageStreamListener listener;
        listener = ImageStreamListener(
          (imageInfo, bool sync) {
            completer.complete(imageInfo.image);
            stream.removeListener(listener);
          },
          onError: (error, stackTrace) {
            completer.completeError(error);
            stream.removeListener(listener);
            FlutterError.reportError(FlutterErrorDetails(
              context: ErrorDescription('image failed to precache'),
              library: 'apsect ratio cache image ',
              exception: error,
              stack: stackTrace,
              silent: true,
            ));
          },
        );
        stream.addListener(listener);

        return FutureBuilder<ui.Image>(
          future: completer.future,
          builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
            if (!snapshot.hasData || snapshot.hasError) {
              return Container();
            }
            double realWidth = snapshot.data!.width.toDouble();
            double realHeight = snapshot.data!.height.toDouble();
            double scale = width / realWidth;
            return Container(
              width: realWidth * scale,
              height: realHeight * scale,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: provider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radius),
          ),
        );
      },
      placeholder: (context, url) {
        return Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: progress
              ? SizedBox(
                  width: width / 3 >= 20.w ? 20.w : width / 3,
                  height: width / 3 >= 20.w ? 20.w : width / 3,
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
