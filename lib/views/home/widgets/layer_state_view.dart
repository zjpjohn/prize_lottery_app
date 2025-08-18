import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:prize_lottery_app/resources/resources.dart';

class LayerSuccessView extends StatefulWidget {
  const LayerSuccessView({
    super.key,
    this.duration = 2500,
  });

  final int duration;

  @override
  State<LayerSuccessView> createState() => _LayerSuccessViewState();
}

class _LayerSuccessViewState extends State<LayerSuccessView> {
  ///
  ///
  AudioPlayer audioPlayer = AudioPlayer();
  late Timer timer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 144.w,
      height: 144.w,
      child: Lottie.asset(
        R.celebrateLottie,
        repeat: true,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50), () {
      audioPlayer.play(AssetSource(R.celebrateAudio));
    });
    timer = Timer(Duration(milliseconds: widget.duration), () {
      Get.back();
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    timer.cancel();
    super.dispose();
  }
}

class LayerModifiedView extends StatelessWidget {
  const LayerModifiedView({
    super.key,
    required this.type,
  });

  final String type;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 40.h),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Get.toNamed('/$type/num3/layer');
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 20.h),
                child: Image.asset(
                  R.layerModifyBg,
                  width: 240.h,
                  height: 240.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  width: 42.h,
                  height: 42.h,
                  child: Container(
                    transform: Matrix4.translationValues(0, -1.h, 0),
                    child: Icon(
                      const IconData(0xe681, fontFamily: 'iconfont'),
                      size: 26.h,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
