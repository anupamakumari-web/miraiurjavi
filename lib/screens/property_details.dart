import 'dart:convert';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

final registry = JsonWidgetRegistry.instance;

class PropertyDetailsScreen extends StatefulWidget {
  const PropertyDetailsScreen({super.key});

  @override
  State<PropertyDetailsScreen> createState() => _DynamicFormScreenState();
}

class _DynamicFormScreenState extends State<PropertyDetailsScreen> {
  JsonWidgetData? widgetData;

  @override
  void initState() {
    super.initState();
    _loadJson();
    _registerCustomFunction();
  }

  void _registerCustomFunction() {
    registry.registerFunctions(<String, JsonWidgetFunction>{
      
      'confirmPin': ({args, required registry}) => () {
        Navigator.of(context).pushNamed('/confirmPin');
      },
      
      
    });

   
  }

  Future<void> _loadJson() async {
    // final formKey = GlobalKey<FormState>();
    // registry.setValue('form_context', formKey);

    final layoutStr = await rootBundle.loadString('assets/property_details.json');
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
