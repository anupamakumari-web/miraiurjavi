import 'package:flutter/material.dart';
import 'package:miraiurjavi_app/model/custom_value_listenable_builder.dart';
import 'package:stac/stac.dart';

class CustomValueListenableBuilderParser
    extends StacParser<CustomValueListenableBuilder> {
  final Map<String, ValueNotifier<dynamic>> notifiers;
  const CustomValueListenableBuilderParser(this.notifiers);

  @override
  String get type => 'valueListenableBuilder';

  @override
  CustomValueListenableBuilder getModel(Map<String, dynamic> json) =>
      CustomValueListenableBuilder.fromJson(json);

  @override
  Widget parse(BuildContext context, CustomValueListenableBuilder model) {
    final notifier = notifiers[model.valueNotifier];
    if (notifier == null) {
      return const SizedBox.shrink();
    }
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (context, value, child) {
        // Replace {value} in builder JSON with actual value
        final builderJson = Map<String, dynamic>.from(model.builder);
        if (builderJson['data'] is String) {
          builderJson['data'] = builderJson['data'].toString().replaceAll(
            '{value}',
            value is double ? value.toInt().toString() : value.toString(),
          );
        }
        return Stac.fromJson(builderJson, context) ?? const SizedBox.shrink();
      },
    );
  }
}
