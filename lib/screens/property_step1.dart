import 'dart:convert';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:miraiurjavi_app/custom%20builder/circle_avatar_builder.dart';

final registry = JsonWidgetRegistry.instance;

class PropertyStep1Screen extends StatefulWidget {
  const PropertyStep1Screen({super.key});

  @override
  State<PropertyStep1Screen> createState() => _DynamicFormScreenState();
}

class _DynamicFormScreenState extends State<PropertyStep1Screen> {
  JsonWidgetData? widgetData;
  final registry = JsonWidgetRegistry.instance;

  @override
  void initState() {
    super.initState();
    _loadJson();
    registerCustomWidgets(registry);
  }

  void registerCustomWidgets(JsonWidgetRegistry registry) {
    registry.registerCustomBuilders({
      'circle_avatar': JsonWidgetBuilderContainer(
        builder: CircleAvatarBuilder.fromDynamic,
      ),
    });
    registry.registerFunctions(<String, JsonWidgetFunction>{
    
      'save_as_draft': ({args, required registry}) => () {
        var message = 'This is a simple print message';
        if (args?.isEmpty == false) {
          for (var arg in args!) {
            message += ' $arg';
          }
        }
        // ignore: avoid_print
        print(message);
      },
      'next_step': ({args, required registry}) => () {
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

  Future<void> _loadJson() async {
    //for local json --working on it
    final layoutStr = await rootBundle.loadString('assets/property_step1.json');
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
