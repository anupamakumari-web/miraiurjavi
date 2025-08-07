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
    });
  }

  Future<void> _loadJson() async {
    //for local json --working on it
    final layoutStr = await rootBundle.loadString(
      'assets/json/json_dynamic_widget/property_details.json',
    );
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
