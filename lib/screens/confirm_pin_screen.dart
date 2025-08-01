import 'dart:convert';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

final registry = JsonWidgetRegistry.instance;

class ConfirmPinScreen extends StatefulWidget {
  const ConfirmPinScreen({super.key});

  @override
  State<ConfirmPinScreen> createState() => _DynamicFormScreenState();
}

class _DynamicFormScreenState extends State<ConfirmPinScreen> {
  JsonWidgetData? widgetData;

  @override
  void initState() {
    super.initState();
    _loadJson();
    _registerCustomFunction();
  }

  void _registerCustomFunction() {
    registry.registerFunctions(<String, JsonWidgetFunction>{
      
      'confirm': ({args, required registry}) => () {
        Navigator.of(context).pushNamed('/verifyPin');
      },
      
      
    });

   
  }

  Future<void> _loadJson() async {
    // final formKey = GlobalKey<FormState>();
    // registry.setValue('form_context', formKey);

    final layoutStr = await rootBundle.loadString('assets/confirm_pin.json');
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
