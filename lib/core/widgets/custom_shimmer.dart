// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Color get shimmerBaseColor => const Color.fromARGB(255, 225, 225, 225);

Color get shimmerHighlightColor => Colors.grey.shade100;

Color get shimmerContentColor => Colors.white;

class CustomShimmer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  const CustomShimmer(
      {super.key,
      this.height,
      this.width,
      this.borderRadius,
      this.margin,
      this.child,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: shimmerBaseColor,
        highlightColor: shimmerHighlightColor,
        child: Container(
            padding: padding,
            width: width,
            margin: margin,
            height: height,
            decoration: BoxDecoration(
                color: shimmerContentColor,
                borderRadius: BorderRadius.circular(borderRadius ?? 16)),
            child: child));
  }
}
