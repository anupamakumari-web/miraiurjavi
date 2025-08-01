import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _DynamicPageState();
}

class _DynamicPageState extends State<TestPage> {
  Map<String, dynamic>? json;
  JsonWidgetData? widgetData;
  bool loading = true;
  String? error;
  final registry = JsonWidgetRegistry.instance;

  @override
  void initState() {
    super.initState();
    // uploadJsonToFirestore();
    loadJsonFromFirebase();
    registerCustomWidgets(registry);
  }

  Future<void> _loadJson() async {
    final data = JsonWidgetData.fromDynamic(json, registry: registry);

    setState(() {
      widgetData = data;
    });
  }

  Future<void> loadJsonFromFirebase() async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection('sdui_schemas')
          .doc('authentication')
          .collection('screens')
          .doc('signin')
          .collection('widgets')
          .doc('scaffold');
      final snapshot = await docRef.get();

      if (snapshot.exists) {
        final data = snapshot.data();
        print("Fetched: $data");
      } else {
        print("No data found");
      }
      final baseJson = snapshot.data();
      if (baseJson == null) {
        throw Exception("❌ Firestore JSON for scaffold not found");
      }

      final resolved = await resolveDynamicJsonReferences(
        input: baseJson,
        module: 'authentication',
        screen: 'signin',
      );
      setState(() {
        json = resolved;
        loading = false;
      });
      _loadJson();
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  Future<void> uploadJsonToFirestore() async {
    // Your JSON map
    final Map<String, dynamic> jsonData = {
      "type": "container",
      "args": {
        "width": 50,
        "height": 50,
        "child": {
          "type": "center",
          "args": {
            "child": {
              "type": "text_form_field",
              "id": "pin4",
              "args": {
                "textAlign": "center",
                "maxLength": 1,
                "keyboardType": "number",
                "style": {
                  "fontSize": 18,
                  "fontWeight": "w600",
                  "color": "#2E3849",
                  "fontFamily": "Poppins",
                },
                "decoration": {
                  "counterText": "",
                  "border": {
                    "type": "outline",
                    "borderRadius": {"type": "all", "radius": 10},
                    "borderSide": {
                      "type": "all",
                      "color": "#BABABA",
                      "width": 1.0,
                    },
                  },
                },
              },
            },
          },
        },
      },
    };

    // final ref = FirebaseFirestore.instance
    //     .collection('sdui_schemas')
    //     .doc('authentication')
    //     .collection('screens')
    //     .doc('signin')
    //     .collection('widgets')
    //     .doc('scaffold');
    // final snapshot = await ref.get();

    // if (snapshot.exists) {
    //   final data = snapshot.data();
    //   print("Fetched: $data");
    // } else {
    //   print("No data found");
    // }

    // Upload to Firestore at path:
    final docRef = FirebaseFirestore.instance
        .collection('sdui_schemas')
        .doc('authentication')
        .collection('screens')
        .doc('verify_4_digit_pin')
        .collection('widgets')
        .doc('pinInputBox_4');

    try {
      print("⏳ Uploading JSON...");
      await docRef.set(jsonData);
      print('✅ JSON uploaded successfully!');

      final uploaded = await docRef.get();
      print("📄 Data in Firestore: ${uploaded.data()}");
      print('✅ JSON uploaded successfully!');
    } catch (e) {
      print('❌ Failed to upload JSON: $e');
    }
  }

  void registerCustomWidgets(JsonWidgetRegistry registry) {
    registry.registerFunctions(<String, JsonWidgetFunction>{
      'submit': ({args, required registry}) => () {
        final BuildContext context = registry.getValue(args![0]);

        final valid = Form.of(context).validate();
        registry.setValue('form_validation', valid);
        final phoneNumber = registry.getValue('mobile');
        final checkboxValue = registry.getValue('changedValue');
        if (valid == true &&
            phoneNumber.toString().length == 10 &&
            checkboxValue != null &&
            checkboxValue == true) {
          Navigator.of(context).pushNamed('/otpVerification');
        } else if (checkboxValue == null || !checkboxValue) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: const Color(0xFF2E3849),
              content: Text(
                "Please agree the terms and conditions.",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        } else if (phoneNumber.toString().length != 10) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: const Color(0xFF2E3849),
              content: Text(
                "Mobile is Invalid",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        }
      },
      'setBooleanValue': ({args, required registry}) {
        return (bool? onChangedValue) {
          final variableName = args![0];
          registry.setValue(variableName, onChangedValue);
        };
      },
      'verifyOtp': ({args, required registry}) => () {
        var message = 'This is a simple print message';
        if (args?.isEmpty == false) {
          for (var arg in args!) {
            message += ' $arg';
          }
        }
        // ignore: avoid_print
        print(message);
      },
      'resendOtp': ({args, required registry}) => () {
        var message = 'This is a simple print message';
        if (args?.isEmpty == false) {
          for (var arg in args!) {
            message += ' $arg';
          }
        }
        // ignore: avoid_print
        print(message);
      },
      'confirmPin': ({args, required registry}) => () {
        var message = 'This is a simple print message';
        if (args?.isEmpty == false) {
          for (var arg in args!) {
            message += ' $arg';
          }
        }
        // ignore: avoid_print
        print(message);
      },
      'confirm': ({args, required registry}) => () {
        var message = 'This is a simple print message';
        if (args?.isEmpty == false) {
          for (var arg in args!) {
            message += ' $arg';
          }
        }
        // ignore: avoid_print
        print(message);
      },
      'verifyPin': ({args, required registry}) => () {
        var message = 'This is a simple print message';
        if (args?.isEmpty == false) {
          for (var arg in args!) {
            message += ' $arg';
          }
        }
        // ignore: avoid_print
        print(message);
      },
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: widgetData != null
          ? widgetData!.build(context: context)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

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
