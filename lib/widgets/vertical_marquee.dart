import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class VerticalMarquee extends StatelessWidget {
  const VerticalMarquee({
    super.key,
    required this.radius,
    required this.color,
    required this.items,
    required this.height,
    this.width,
    this.padding = EdgeInsets.zero,
  });

  final BorderRadius radius;
  final Color color;
  final List<Widget> items;
  final double? width;
  final double height;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    double widthCp = width ?? MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: widthCp,
      decoration: BoxDecoration(
        color: color,
        borderRadius: radius,
      ),
      child: Padding(
        padding: padding,
        child: CarouselSlider(
          items: items,
          options: CarouselOptions(
            height: height,
            aspectRatio: 1.0,
            viewportFraction: 1.0,
            scrollDirection: Axis.vertical,
            autoPlay: items.length > 1,
          ),
        ),
      ),
    );
  }
}
