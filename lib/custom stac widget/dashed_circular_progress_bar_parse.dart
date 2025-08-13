import 'package:flutter/material.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:miraiurjavi_app/model/custom_dashed_circular_progress_bar.dart';
import 'package:stac/stac.dart';

class CustomDashedCircularProgressBarParser
    extends StacParser<CustomDashedCircularProgressBar> {
  const CustomDashedCircularProgressBarParser();

  @override
  String get type => 'dashedCircularProgressBar';

  @override
  CustomDashedCircularProgressBar getModel(Map<String, dynamic> json) =>
      CustomDashedCircularProgressBar.fromJson(json);

  @override
  Widget parse(BuildContext context, CustomDashedCircularProgressBar model) {
    final notifiers = {'progressNotifier': ValueNotifier<double>(50)};
    return DashedCircularProgressBar(
      width: model.width,
      height: model.height,
      valueNotifier: model.valueNotifier ?? notifiers['progressNotifier'],
      progress: model.progress,
      maxProgress: model.maxProgress,
      foregroundStrokeWidth: model.foregroundStrokeWidth,
      backgroundStrokeWidth: model.backgroundStrokeWidth,
      foregroundColor: Colors.blue,
      backgroundColor: const Color(0xffeeeeee),
      corners: model.corners,
      animation: model.animation,
      child: model.child != null
          ? Stac.fromJson(model.child, context)
          : null,
    );
  }
}
