import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:stac/stac.dart';

import '../model/custom_pinput.dart';

// Custom Pinput Parser
class CustomPinputParser extends StacParser<CustomPinput> {
  const CustomPinputParser();

  @override
  String get type => 'pinput';

  @override
  CustomPinput getModel(Map<String, dynamic> json) => CustomPinput.fromJson(json);

  @override
  Widget parse(BuildContext context, CustomPinput model) {
    // Create default pin theme
    PinTheme defaultPinTheme = _createPinTheme(
      model.theme?.defaultPinTheme,
      defaultColor: Colors.grey.shade300,
      defaultBorderColor: Colors.grey.shade400,
    );

    // Create focused pin theme
    PinTheme focusedPinTheme = _createPinTheme(
      model.theme?.focusedPinTheme,
      defaultColor: Colors.blue.shade100,
      defaultBorderColor: Colors.blue,
      fallback: defaultPinTheme,
    );

    // Create submitted pin theme
    PinTheme submittedPinTheme = _createPinTheme(
      model.theme?.submittedPinTheme,
      defaultColor: Colors.green.shade100,
      defaultBorderColor: Colors.green,
      fallback: defaultPinTheme,
    );

    // Create error pin theme
    PinTheme errorPinTheme = _createPinTheme(
      model.theme?.errorPinTheme,
      defaultColor: Colors.red.shade100,
      defaultBorderColor: Colors.red,
      fallback: defaultPinTheme,
    );

    return Pinput(
      length: model.length,
      obscureText: model.obscureText,
      obscuringCharacter: model.obscuringCharacter ?? '●',
      readOnly: model.readOnly,
      autofocus: model.autofocus,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      errorPinTheme: errorPinTheme,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onChanged: model.onChanged != null ? (value) => Stac.onCallFromJson({'actionType': model.onChanged!, 'value': value}, context) : null,
      onCompleted: model.onCompleted != null ? (value) => Stac.onCallFromJson({'actionType': model.onCompleted!, 'value': value}, context) : null,
      onSubmitted: model.onSubmitted != null ? (value) => Stac.onCallFromJson({'actionType': model.onSubmitted!, 'value': value}, context) : null,
      validator: model.validator != null ? (value) => _validatePin(value, model.validator!) : null,
    );
  }

  // Helper method to create PinTheme from CustomPinputDecoration
  PinTheme _createPinTheme(
    CustomPinputDecoration? decoration, {
    required Color defaultColor,
    required Color defaultBorderColor,
    PinTheme? fallback,
  }) {
    return PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: decoration?.backgroundColor != null ? _parseColor(decoration!.backgroundColor!) : fallback?.decoration?.color ?? defaultColor,
        border: Border.all(
          color: decoration?.borderColor != null ? _parseColor(decoration!.borderColor!) : fallback?.decoration?.border?.top.color ?? defaultBorderColor,
          width: decoration?.borderWidth != null ? double.tryParse(decoration!.borderWidth!) ?? 2.0 : 2.0,
        ),
        borderRadius: BorderRadius.circular(
          decoration?.borderRadius != null ? double.tryParse(decoration!.borderRadius!) ?? 8.0 : 8.0,
        ),
      ),
    );
  }

  // Helper method to parse color from string
  Color _parseColor(String colorString) {
    if (colorString.startsWith('#')) {
      return Color(int.parse(colorString.substring(1), radix: 16) + 0xFF000000);
    }
    // Add more color parsing logic as needed
    return Colors.grey;
  }

  // Helper method for validation
  String? _validatePin(String? value, String validatorKey) {
    // This would typically call a validation function registered in StacRegistry
    // For now, we'll implement basic validation
    if (value == null || value.isEmpty) {
      print('PIN is required');
      return 'PIN is required';
    }
    if (value.length != 4) {
      print('PIN must be 4 digit');
      return 'PIN must be 4 digit';
    }
    return null;
  }
}