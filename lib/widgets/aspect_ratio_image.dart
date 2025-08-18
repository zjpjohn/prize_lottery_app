import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class AspectRatioImage extends StatelessWidget {
  ///
  ///
  const AspectRatioImage({
    super.key,
    required this.url,
    this.width,
    this.height,
  });

  final String url;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    ImageConfiguration configuration = createLocalImageConfiguration(context);
    Completer<ui.Image> completer = Completer<ui.Image>();
    ImageProvider provider = NetworkImage(url);
    ImageStream stream = provider.resolve(configuration);
    ImageStreamListener listener = ImageStreamListener(
      (imageInfo, bool sync) {
        completer.complete(imageInfo.image);
      },
      onError: (error, stackTrace) {
        completer.completeError(error);
        FlutterError.reportError(FlutterErrorDetails(
          context: ErrorDescription('image failed to precache'),
          library: 'image resource service',
          exception: error,
          stack: stackTrace,
          silent: true,
        ));
      },
    );
    stream.addListener(listener);
    return FutureBuilder(
      future: completer.future,
      builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return Container();
        }
        double realWidth = snapshot.data!.width.toDouble();
        double realHeight = snapshot.data!.height.toDouble();
        double scale = 1;
        if (width != null && height != null) {
          scale = min(width! / realWidth, height! / realHeight);
        } else if (width != null) {
          scale = width! / realWidth;
        } else if (height != null) {
          scale = height! / realHeight;
        }
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
  }
}
