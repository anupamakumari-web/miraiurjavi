import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:miraiurjavi_app/Utils/dynamic_json_references.dart';
import 'package:miraiurjavi_app/custom%20builder/pin_input_builder.dart';

final registry = JsonWidgetRegistry.instance;

class VerifyPinScreen extends StatefulWidget {
  const VerifyPinScreen({super.key});

  @override
  State<VerifyPinScreen> createState() => _DynamicFormScreenState();
}

class _DynamicFormScreenState extends State<VerifyPinScreen> {
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
    registry.registerCustomBuilders({
      'pin_input': JsonWidgetBuilderContainer(
        builder: PinInputBuilder.fromDynamic,
      ),
    });
    registry.registerFunctions(<String, JsonWidgetFunction>{
      'verifyPin': ({args, required registry}) => () {
        Navigator.of(context).pushNamed('/personal_details');
      },
      'onChangedValue': ({args, required registry}) => (String val) {
        print("PIN changed: $val");
        registry.setValue('pin_value', val);
      },
    });
  }

  Future<void> loadJsonFromFirebase() async {
    //for local json
    /*final layoutStr = await rootBundle.loadString('assets/json/json_dynamic_widget/verify_pin.json');
    final layoutJson = json.decode(layoutStr) as Map<String, dynamic>;
    final data = JsonWidgetData.fromDynamic(layoutJson, registry: registry);

    setState(() {
      widgetData = data;
    });*/
  
  try {
      final docRef = FirebaseFirestore.instance
          .collection('sdui_schemas')
          .doc('authentication')
          .collection('screens')
          .doc('verify_4_digit_pin')
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
        screen: 'verify_4_digit_pin',
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