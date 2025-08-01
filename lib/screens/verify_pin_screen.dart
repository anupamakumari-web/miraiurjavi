import 'dart:convert';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

final registry = JsonWidgetRegistry.instance;

class VerifyPinScreen extends StatefulWidget {
  const VerifyPinScreen({super.key});

  @override
  State<VerifyPinScreen> createState() => _DynamicFormScreenState();
}

class _DynamicFormScreenState extends State<VerifyPinScreen> {
  JsonWidgetData? widgetData;

  @override
  void initState() {
    super.initState();
    _loadJson();
    _registerCustomFunction();
  }

  void _registerCustomFunction() {
    registry.registerFunctions(<String, JsonWidgetFunction>{
      
      'verifyPin': ({args, required registry}) => () {
        Navigator.of(context).pushNamed('/personal_details');
      },
      
      
    });

   
  }

  Future<void> _loadJson() async {
    // final formKey = GlobalKey<FormState>();
    // registry.setValue('form_context', formKey);

    final layoutStr = await rootBundle.loadString('assets/verify_pin.json');
    final layoutJson = json.decode(layoutStr) as Map<String, dynamic>;
    final data = JsonWidgetData.fromDynamic(layoutJson, registry: registry);

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


class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Success")),
      body: const Center(child: Text("Form submitted successfully!")),
    );
  }
}