import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:smart_stepper/smart_stepper.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>> resolveDynamicJsonReferences({
  required Map<String, dynamic> input,
  required String module,
  required String screen,
}) async {
  Future<dynamic> resolve(dynamic value) async {
    if (value is String && value.startsWith('@')) {
      final docId = value.substring(1);
      final path = 'sdui_schemas/$module/screens/$screen/widgets /$docId';

      final docSnapshot = await FirebaseFirestore.instance
          .collection('sdui_schemas')
          .doc(module)
          .collection('screens')
          .doc(screen)
          .collection('widgets')
          .doc(docId)
          .get();

      if (!docSnapshot.exists) {
        throw Exception("Widget '$docId' not found at path: $path");
      }

      final data = docSnapshot.data();
      if (data is Map<String, dynamic>) {
        return await resolve(data); // handle nested @ references
      } else {
        return data;
      }
    } else if (value is Map<String, dynamic>) {
      final Map<String, dynamic> resolvedMap = {};
      for (var entry in value.entries) {
        resolvedMap[entry.key] = await resolve(entry.value);
      }
      return resolvedMap;
    } else if (value is List) {
      return Future.wait(value.map((item) => resolve(item)));
    } else {
      return value;
    }
  }

  return await resolve(input) as Map<String, dynamic>;
}

/// Flutter code sample for [Stepper].

void main() => runApp(const StepperExampleApp());

class StepperExampleApp extends StatelessWidget {
  const StepperExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: StepperExample());
  }
}

class StepperExample extends StatefulWidget {
  const StepperExample({super.key});

  @override
  State<StepperExample> createState() => _StepperExampleState();
}

class _StepperExampleState extends State<StepperExample> {
  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Welcome to mirai 🎉"),
              const SizedBox(height: 20),
              const Text("Please tell us a little bit about you"),
              DashedCircularProgressBar(
                height: 70,
                width: 70,
                valueNotifier: _valueNotifier,
                progress: 50,
                maxProgress: 100,
                corners: StrokeCap.butt,
                foregroundColor: Colors.blue,
                backgroundColor: const Color(0xffeeeeee),
                foregroundStrokeWidth: 5,
                backgroundStrokeWidth: 5,
                animation: true,
                child: Center(
                  child: ValueListenableBuilder(
                    valueListenable: _valueNotifier,
                    builder: (_, double value, __) => Text(
                      '${value.toInt()}%',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        // fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                if (_index < 1) {
                  setState(() => _index++);
                } else {
                  // Last step action here
                  debugPrint("Continue / Submit pressed");
                }
              },
              child: Text(_index < 1 ? "Next" : "Continue"),
            ),
          ),
        ],
      ),
    );
  }
}

class Dummy extends StatefulWidget {
  const Dummy({super.key});

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  int currentStep = 3;
  int totalSteps = 4;
  int currentStep1 = 2;
  int currentStep2 = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Smart Stepper Example",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SmartStepper(
        width: MediaQuery.of(context).size.width,
        currentStep: currentStep1,
        currentTextColor: Color(0xff0162DD),

        inactiveLineColor: Color(0xffa1aebe),
        inactiveTextColor: Color(0xff000000),
        inactiveBorderColor: Color(0xffa1aebe),
        currentLineColor: Color(0xffa1aebe),

        totalSteps: totalSteps,
        completeStepColor: Color(0xff34c759),
        currentBorderColor: Color(0xff0162DD),
        completeLineColor: Color(0xff0162DD),
        currentStepColor: Color(0xffffffff),
        lineWidth: totalSteps == 2
            ? MediaQuery.of(context).size.width * .75
            : totalSteps == 3
            ? MediaQuery.of(context).size.width * .35
            : 30,
        inactiveStepColor: Color(0xffffffff),
        borderWidth: 2,
        lineHeight: 3,
        onStepperTap: (value) {
          setState(() {
            currentStep1 = value;
          });
        },
      ),
    );
  }
}
