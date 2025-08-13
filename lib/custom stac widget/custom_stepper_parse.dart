import 'package:flutter/material.dart';
import 'package:miraiurjavi_app/model/custom_stepper.dart';
import 'package:stac/stac.dart';
import 'package:stac_framework/stac_framework.dart';

class CustomStepperParser extends StacParser<CustomStepper> {
  const CustomStepperParser();

  @override
  String get type => 'stepper';

  @override
  CustomStepper getModel(Map<String, dynamic> json) =>
      CustomStepper.fromJson(json);

  @override
  Widget parse(BuildContext context, CustomStepper model) {
    return _CustomStepperWidget(model: model);
  }
}

class _CustomStepperWidget extends StatefulWidget {
  final CustomStepper model;
  const _CustomStepperWidget({required this.model});

  @override
  State<_CustomStepperWidget> createState() => _CustomStepperWidgetState();
}

class _CustomStepperWidgetState extends State<_CustomStepperWidget> {
  late int currentStep;

  @override
  void initState() {
    super.initState();
    currentStep = widget.model.currentStep;
  }

  @override
  Widget build(BuildContext context) {
    final model = widget.model;

    return Stepper(
      type: model.steppertype,
      steps: model.steps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;

        return Step(
          state: index < currentStep
              ? StepState.complete
              : (index == currentStep ? StepState.indexed : StepState.disabled),
          title: Stac.fromJson(step.title, context) ?? const SizedBox.shrink(),
          subtitle: step.subtitle != null
              ? Stac.fromJson(step.subtitle!, context)
              : null,
          content:
              Stac.fromJson(step.content, context) ?? const SizedBox.shrink(),
          isActive: index <= currentStep,
          label: step.label != null
              ? Stac.fromJson(step.label!, context)
              : null,
        );
      }).toList(),
      currentStep: currentStep,
      onStepTapped: (index) {
        setState(() {
          currentStep = index;
        });
        if (model.onStepTapped != null) {
          Stac.onCallFromJson({
            'actionType': model.onStepTapped!,
            'index': index,
          }, context);
        }
      },
      onStepContinue: () {
        if (currentStep < model.steps.length - 1) {
          setState(() {
            currentStep++;
          });
        }
        if (model.onStepContinue != null) {
          Stac.onCallFromJson({'actionType': model.onStepContinue!}, context);
        }
      },
      onStepCancel: () {
        if (currentStep > 0) {
          setState(() {
            currentStep--;
          });
        }
        if (model.onStepCancel != null) {
          Stac.onCallFromJson({'actionType': model.onStepCancel!}, context);
        }
      },
      elevation: model.elevation ?? 0,
      margin: model.margin?.parse,
      connectorThickness: model.connectorThickness,
    );
  }
}
