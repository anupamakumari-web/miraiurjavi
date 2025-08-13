import 'package:flutter/material.dart';

class CustomDashedCircularProgressBar {
  final double width;
  final double height;
  final double progress;
  final double maxProgress;
  final double foregroundStrokeWidth;
  final double backgroundStrokeWidth;
  final Color foregroundColor;
  final Color backgroundColor;
  final StrokeCap corners;
  final bool animation;
  final ValueNotifier<double>? valueNotifier;
  final Map<String,dynamic>? child;

  const CustomDashedCircularProgressBar({
    required this.width,
    required this.height,
    required this.progress,
    required this.maxProgress,
    required this.foregroundStrokeWidth,
    required this.backgroundStrokeWidth,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.corners,
    required this.animation,
    this.valueNotifier,
    this.child,
  });

  factory CustomDashedCircularProgressBar.fromJson(Map<String, dynamic> json) {
    final notifiers = {'progressNotifier': ValueNotifier<double>(0)};
    return CustomDashedCircularProgressBar(
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      valueNotifier: notifiers[json['valueNotifier']],
      progress: (json['progress'] as num).toDouble(),
      maxProgress: (json['maxProgress'] as num).toDouble(),
      foregroundStrokeWidth: (json['foregroundStrokeWidth'] as num).toDouble(),
      backgroundStrokeWidth: (json['backgroundStrokeWidth'] as num).toDouble(),
      foregroundColor: Color(int.parse(json['foregroundColor'], radix: 16)),
      backgroundColor: Color(int.parse(json['backgroundColor'], radix: 16)),
      corners: json['corners'] == 'round' ? StrokeCap.round : StrokeCap.butt,
      animation: json['animation'] ?? false,
      child: json['child'] is Map<String, dynamic>
          ? json['child'] as Map<String, dynamic>
          : null,
    );
  }

  static Alignment _parseAlignment(String? value) {
    switch (value) {
      case 'center':
        return Alignment.center;
      case 'topLeft':
        return Alignment.topLeft;
      case 'topRight':
        return Alignment.topRight;
      case 'bottomLeft':
        return Alignment.bottomLeft;
      case 'bottomRight':
        return Alignment.bottomRight;
      case 'topCenter':
        return Alignment.topCenter;
      case 'bottomCenter':
        return Alignment.bottomCenter;
      case 'centerLeft':
        return Alignment.centerLeft;
      case 'centerRight':
        return Alignment.centerRight;
      default:
        return Alignment.center;
    }
  }
}
