import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:miraiurjavi_app/Utils/dynamic_json_references.dart';

final registry = JsonWidgetRegistry.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  JsonWidgetData? widgetData;
  Map<String, dynamic>? json;
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    loadJsonFromFirebase();
    _registerCustomFunction();
  }

  void _registerCustomFunction() {
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
      }
    });

    /*registry.registerFunctions(<String, JsonWidgetFunction>{
      'validateForm': ({args, required registry}) => () {
        final BuildContext context = registry.getValue(args![0]);

        final valid = Form.of(context).validate();
        registry.setValue('form_validation', valid);
        final formKey = registry.getValue('form_validation');
      if (formKey != null && formKey== true) {
        Navigator.of(context).pushNamed('/success');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please correct the form.")),
        );
      }
      },
    });
        registry.registerFunctions(<String, JsonWidgetFunction>{
      'submitLogin': ({
        required args,
        required JsonWidgetRegistry registry,
        context,
      }) {
        final formKey = registry.getValue('formKey') as GlobalKey<FormState>?;

        if (formKey?.currentState?.validate() ?? false) {
          final phone = registry.getValue('first_name');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('first_name: $phone')),
          );

          // Do navigation or API call
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please fill all required fields correctly.'),
            ),
          );
        }
      }
    });

    registry.registerFunctions(<String, JsonWidgetFunction>{
      'logForm': ({args, context, required registry}) {
      // args[0] is the context key
      final contextKey = args!.isNotEmpty ? args[0] as String : null;
      final context = registry.getValue(contextKey);
      print(
        '[Form Validated] Data: $context',
      ); // you can also do navigation here
      // Optionally return something or do navigation:
      // Navigator.of(registry.getBuildContext()!).push(...)
      return true;
    },
      'validateForm': ({args, context, required registry}) {
        return () {
          final formKey = registry.getValue('formKey') as GlobalKey<FormState>?;
          if (formKey != null && formKey.currentState?.validate() == true) {
            Navigator.pushNamed(context, '/success');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please fix form errors")),
            );
          }
        };
      },
      'navigateNamedRoute': ({args, context, required registry}) {
        return () {
          if (args != null && args.isNotEmpty && args[0] is String) {
            Navigator.of(context).pushNamed(args[0]);
          }
        };
      },
      'showSnackBar': ({args, context, required registry}) {
        return () {
          if (args != null && args.isNotEmpty && args[0] is String) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(args[0])));
          }
        };
      },
    });*/
  }

  Future<void> loadJsonFromFirebase() async {
    //for local json
    /*final layoutStr = await rootBundle.loadString('assets/json/json_dynamic_widget/signin.json');
    final layoutJson = json.decode(layoutStr) as Map<String, dynamic>;
    final data = JsonWidgetData.fromDynamic(layoutJson, registry: registry);

    setState(() {
      widgetData = data;
    });
    */
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

  Future<void> _loadJson() async {
    final data = JsonWidgetData.fromDynamic(json, registry: registry);

    setState(() {
      widgetData = data;
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
