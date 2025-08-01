import 'package:flutter/material.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

// part 'onboarding_stepper_builder.g.dart';



//working on it//
@jsonWidget
abstract class _OnboardingStepperBuilder extends JsonWidgetBuilder {
  const _OnboardingStepperBuilder({required super.args});

  @override
  Widget buildCustom({
    required BuildContext context,
    required JsonWidgetData data,
    Key? key,
    ChildWidgetBuilder? childBuilder,
  }) {
    final List<dynamic> stepsJson = args['steps'] ?? [];
    final steps = stepsJson
        .map<JsonWidgetData>((e) => JsonWidgetData.fromDynamic(e))
        .toList();

    return _OnboardingStepperWidget(
      steps: steps,
      key: key,
    );
  }
}

class _OnboardingStepperWidget extends StatefulWidget {
  final List<JsonWidgetData> steps;

  const _OnboardingStepperWidget({
    super.key,
    required this.steps,
  });

  @override
  State<_OnboardingStepperWidget> createState() => _OnboardingStepperWidgetState();
}

class _OnboardingStepperWidgetState extends State<_OnboardingStepperWidget> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      type: StepperType.horizontal,
      currentStep: currentStep,
      connectorColor: WidgetStateProperty.all(Color(0xFF0162DD)),
      controlsBuilder: (context, _) => const SizedBox.shrink(),
      onStepTapped: (index) => setState(() => currentStep = index),
      steps: List.generate(widget.steps.length, (index) {
        return Step(
          title: const SizedBox.shrink(),
          isActive: currentStep == index,
          state: currentStep > index ? StepState.complete : StepState.indexed,
          content: Column(
            children: [
              widget.steps[index].build(context: context),
              const SizedBox(height: 24),
              _buildStepButton(index),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStepButton(int index) {
    final isLast = index == widget.steps.length - 1;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        minimumSize: const Size.fromHeight(50),
      ),
      onPressed: () {
        if (!isLast) {
          setState(() => currentStep += 1);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Journey Started!")),
          );
        }
      },
      child: Text(
        isLast ? 'Begin your journey' : 'Continue',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
