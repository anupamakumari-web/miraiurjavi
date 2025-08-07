import 'dart:convert';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

final registry = JsonWidgetRegistry.instance;

class PersonalDetailScreen extends StatefulWidget {
  const PersonalDetailScreen({super.key});

  @override
  State<PersonalDetailScreen> createState() => _DynamicFormScreenState();
}

class _DynamicFormScreenState extends State<PersonalDetailScreen> {
  JsonWidgetData? widgetData;

  @override
  void initState() {
    super.initState();
    _registerCustomFunction();
    registry.setValue('currentStep', 0);
    _loadJson();
  }

  void _registerCustomFunction() {
    registry.registerFunctions(<String, JsonWidgetFunction>{
      'submitForm': ({args, required registry}) => () {
        final referral = registry.getValue('referral_code');
        debugPrint(
          'Submitting form: $referral',
        );
        Navigator.of(context).pushNamed('/property_details');
      },
      'nextStep': ({args, required registry}) => () {
        final current = registry.getValue('currentStep') ?? 0;
        registry.setValue('currentStep', current + 1);
        final name = registry.getValue('your_name');
        final brand = registry.getValue('brand_name');
        final units = registry.getValue('total_units');
        final properties = registry.getValue('total_properties');
        final city = registry.getValue('city');
        setState(() {});
        

        debugPrint(
          'Submitting form: $name, $brand, $units, $properties, $city',
        );
      },
      'navigateBack': ({args, required registry}) => () {
        final current = registry.getValue('currentStep') ?? 0;
        if (current > 0) {
          registry.setValue('currentStep', current - 1);
          debugPrint("${registry.getValue('currentStep')}");
        } else {
          Navigator.pop(context);
        }
      },
    });
  }

  Future<void> _loadJson() async {
    //for local json --not uploaded in firebase
    final layoutStr = await rootBundle.loadString(
      'assets/json/json_dynamic_widget/personal_details.json',
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
