import 'dart:convert';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:miraiurjavi_app/custom%20widgets/pin_input_builder.dart';

final registry = JsonWidgetRegistry.instance;

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({super.key});

  @override
  State<SetPinScreen> createState() => _DynamicFormScreenState();
}

class _DynamicFormScreenState extends State<SetPinScreen> {
  JsonWidgetData? widgetData;

  @override
  void initState() {
    super.initState();
    _loadJson();
    _registerCustomFunction();
  }

  void _registerCustomFunction() {
    registry.registerCustomBuilders({
      'pin_input': JsonWidgetBuilderContainer(
        builder: PinInputBuilder.fromDynamic,
      ),
    });
    registry.registerFunctions(<String, JsonWidgetFunction>{
      // 'updateOtp': ({args, required registry}) => () {
      //   final value = args![0]['value'] as String? ?? '';
      //   registry.setValue('otp_value', value);
      //   final values = registry.values;

      //   final phone = registry.getValue('phone_input');
      //   final termsAccepted = registry.getValue('terms_checkbox');

      //   debugPrint('📞 Phone: $phone');
      //   debugPrint('✅ Terms Accepted: $termsAccepted');

      //   // ❗Validate manually since there's no automatic formState validate
      //   if ((phone?.toString().isEmpty ?? true)) {
      //     debugPrint("❌ Phone is required");
      //     return;
      //   }

      //   if (termsAccepted != true) {
      //     debugPrint("❌ You must accept terms");
      //     return;
      //   }
      // },
      'confirmPin': ({args, required registry}) => () {
        final otpValue = registry.getValue("pin_value");
        print("Entered OTP: $otpValue");
        Navigator.of(context).pushNamed('/confirmPin');
      },

      'onChangedValue': ({args, required registry}) => (String val) {
        print("PIN changed: $val");
        registry.setValue('pin_value', val);
      },
    });
  }

  Future<void> _loadJson() async {
    // final formKey = GlobalKey<FormState>();
    // registry.setValue('form_context', formKey);

    final layoutStr = await rootBundle.loadString('assets/set_pin.json');
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
