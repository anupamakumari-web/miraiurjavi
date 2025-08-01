// import 'package:flutter/material.dart';
// import 'package:json_dynamic_widget/json_dynamic_widget.dart';

// part 'stepper_builder.g.dart';

// @jsonWidget
// abstract class _StepperBuilder extends JsonWidgetBuilder {
//   const _StepperBuilder({required super.args});

//   @override
//   StepperBuilderModel createModel({
//     ChildWidgetBuilder? childBuilder,
//     required JsonWidgetData data,
//   }) {
//     return StepperBuilderModel.fromDynamic(data.jsonWidgetArgs);
//   }

//   @override
//   Widget buildCustom({
//     required BuildContext context,
//     JsonWidgetData? data,
//     JsonWidgetRegistry? registry,
//     JsonWidgetBuilderModel? model,
//   }) {
//     final stepperModel = model as StepperBuilderModel;

//     return _CustomStepper(model: stepperModel);
//   }
// }

// class _CustomStepper extends StatefulWidget {
//   final StepperBuilderModel model;

//   const _CustomStepper({super.key, required this.model});

//   @override
//   State<_CustomStepper> createState() => _CustomStepperState();
// }

// class _CustomStepperState extends State<_CustomStepper> {
//   int _currentStep = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Stepper(
//       currentStep: _currentStep,
//       steps: List.generate(widget.model.stepTitles.length, (index) {
//         return Step(
//           title: Text(widget.model.stepTitles[index]),
//           content: Text(widget.model.stepContents[index]),
//           isActive: _currentStep >= index,
//           state: _currentStep > index ? StepState.complete : StepState.indexed,
//         );
//       }),
//       onStepContinue: () {
//         if (_currentStep < widget.model.stepTitles.length - 1) {
//           setState(() => _currentStep += 1);
//         }
//       },
//       onStepCancel: () {
//         if (_currentStep > 0) {
//           setState(() => _currentStep -= 1);
//         }
//       },
//     );
//   }
// }

// class StepperBuilderModel extends JsonWidgetBuilderModel {
//   final List<String> stepTitles;
//   final List<String> stepContents;

//   const StepperBuilderModel({
//     required super.args,
//     required this.stepTitles,
//     required this.stepContents,
//   });

//   static StepperBuilderModel fromDynamic(dynamic map) {
//     if (map == null || map is! Map<String, dynamic>) {
//       return const StepperBuilderModel(
//         args: {},
//         stepTitles: [],
//         stepContents: [],
//       );
//     }

//     return StepperBuilderModel(
//       args: map,
//       stepTitles: (map['stepTitles'] as List?)?.cast<String>() ?? [],
//       stepContents: (map['stepContents'] as List?)?.cast<String>() ?? [],
//     );
//   }

//   @override
//   Map<String, dynamic> toJson() => {
//         'stepTitles': stepTitles,
//         'stepContents': stepContents,
//       };
// }
import 'package:json_dynamic_widget/json_dynamic_widget.dart';


part 'circle_avatar_builder.g.dart';

@jsonWidget
abstract class _CircleAvatarBuilder extends JsonWidgetBuilder {
  const _CircleAvatarBuilder({
    required super.args,
  });

  @override
  _CircleAvatar buildCustom({
    ChildWidgetBuilder? childBuilder,
    required BuildContext context,
    required JsonWidgetData data,
    Key? key,
  });
}

class _CircleAvatar extends StatelessWidget {
  const _CircleAvatar({
    this.radius,
    this.backgroundColor,
    this.foregroundColor,
    this.child,
    super.key,
  });

  final double? radius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      child: child,
    );
  }
}
