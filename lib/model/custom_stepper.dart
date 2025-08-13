// Data model for Pinput configuration
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac/src/parsers/stac_material_color/stac_material_color.dart';

class CustomStepper {
  final List<CustomStep> steps;
  final StepperType steppertype;
  final int currentStep;
  final String? onStepTapped;
  final String? onStepContinue;
  final String? onStepCancel;
  final double? elevation;
  final StacEdgeInsets? margin;
  final StacMaterialColor? connectorColor;
  final double? connectorThickness;
  final double? stepIconHeight;
  final double? stepIconWidth;
  final StacEdgeInsets? stepIconMargin;

  const CustomStepper({
    required this.steps,
    this.steppertype = StepperType.vertical,
    this.currentStep = 0,
    this.onStepTapped,
    this.onStepContinue,
    this.onStepCancel,
    this.elevation,
    this.margin,
    this.connectorColor,
    this.connectorThickness,
    this.stepIconHeight,
    this.stepIconWidth,
    this.stepIconMargin,
  });

  factory CustomStepper.fromJson(Map<String, dynamic> json) {
    return CustomStepper(
      steps: json['steps'] != null
          ? (json['steps'] as List)
                .map(
                  (step) => CustomStep.fromJson(step as Map<String, dynamic>),
                )
                .toList()
          : [],
      steppertype: _parseStepperType(json['steppertype']),
      currentStep: json['currentStep'] as int? ?? 0,
      onStepTapped: json['onStepTapped'] as String?,
      onStepContinue: json['onStepContinue'] as String?,
      onStepCancel: json['onStepCancel'] as String?,
      elevation: json['elevation'] as double?,
      margin: json['margin'] != null
          ? StacEdgeInsets.fromJson(json['margin'] as Map<String, dynamic>)
          : null,
      connectorColor: json['connectorColor'] != null
          ? StacMaterialColor.fromJson(
              json['connectorColor'] as Map<String, dynamic>,
            )
          : null,
      connectorThickness: json['connectorThickness'] as double?,
      stepIconHeight: json['stepIconHeight'] as double?,
      stepIconWidth: json['stepIconWidth'] as double?,
      stepIconMargin: json['stepIconMargin'] != null
          ? StacEdgeInsets.fromJson(
              json['stepIconMargin'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'steps': steps.map((step) => step.toJson()).toList(),
      'currentStep': currentStep,
      'onStepTapped': onStepTapped,
      'onStepContinue': onStepContinue,
      'onStepCancel': onStepCancel,
      'elevation': elevation,
      'margin': margin?.toJson(),
      'connectorColor': connectorColor,
      'connectorThickness': connectorThickness,
      'stepIconHeight': stepIconHeight,
      'stepIconWidth': stepIconWidth,
      'stepIconMargin': stepIconMargin?.toJson(),
      'steppertype': steppertype,
    };
  }

  static StepperType _parseStepperType(dynamic value) {
    if (value is String) {
      switch (value.toLowerCase()) {
        case 'horizontal':
          return StepperType.horizontal;
        case 'vertical':
        default:
          return StepperType.vertical;
      }
    }
    return StepperType.vertical;
  }
}

// step configuration
class CustomStep {
  final StepState state;
  final Map<String, dynamic> title;
  final Map<String, dynamic>? subtitle;
  final Map<String, dynamic> content;
  final bool isActive;
  final Map<String, dynamic>? label;
  final CustomStepStyle? stepStyle;

  CustomStep({
    this.state = StepState.indexed,
    required this.title,
    this.subtitle,
    required this.content,
    this.isActive = false,
    this.label,
    this.stepStyle,
  });

  factory CustomStep.fromJson(Map<String, dynamic> json) {
    return CustomStep(
      state: _parseStepState(json['state']),
      title: json['title'] as Map<String, dynamic>,
      subtitle: json['subtitle'] as Map<String, dynamic>?,
      content: json['content'] as Map<String, dynamic>,
      isActive: json['isActive'] as bool? ?? false,
      label: json['label'] as Map<String, dynamic>?,
      stepStyle: json['stepStyle'] != null
          ? CustomStepStyle.fromJson(json['stepStyle'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'state': state.toString().split('.').last,
      'title': title,
      'subtitle': subtitle,
      'content': content,
      'isActive': isActive,
      'label': label,
      'stepStyle': stepStyle?.toJson(),
    };
  }

  static StepState _parseStepState(dynamic value) {
    if (value is String) {
      switch (value.toLowerCase()) {
        case 'complete':
          return StepState.complete;
        case 'disabled':
          return StepState.disabled;
        case 'editing':
          return StepState.editing;
        case 'error':
          return StepState.error;
        case 'indexed':
          return StepState.indexed;
        default:
          return StepState.disabled;
      }
    }
    return StepState.indexed;
  }
}

// step style configuration
class CustomStepStyle {
  final String? color;
  final String? errorColor;
  final StacBorder? border;
  final StacBoxShadow? boxShadow;
  final StacGradient? gradient;
  final StacTextStyle? indexStyle;

  const CustomStepStyle({
    this.color,
    this.errorColor,
    this.border,
    this.boxShadow,
    this.gradient,
    this.indexStyle,
  });

  factory CustomStepStyle.fromJson(Map<String, dynamic> json) {
    return CustomStepStyle(
      color: json['color'] as String?,
      errorColor: json['errorColor'] as String?,
      border: json['border'] != null
          ? StacBorder.fromJson(json['border'] as Map<String, dynamic>)
          : null,
      boxShadow: json['boxShadow'] != null
          ? StacBoxShadow.fromJson(json['boxShadow'] as Map<String, dynamic>)
          : null,
      gradient: json['gradient'] != null
          ? StacGradient.fromJson(json['gradient'] as Map<String, dynamic>)
          : null,
      indexStyle: json['indexStyle'] != null
          ? StacTextStyle.fromJson(json['indexStyle'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'color': color,
      'errorColor': errorColor,
      'border': border,
      'boxShadow': boxShadow,
      'gradient': gradient,
      'indexStyle': indexStyle,
    };
  }
}
