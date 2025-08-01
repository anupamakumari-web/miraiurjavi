import 'dart:convert';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
// import 'package:miraiurjavi_app/custom%20widgets/otp_pin_input_builder.dart';

final registry = JsonWidgetRegistry.instance;

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _DynamicFormScreenState();
}

class _DynamicFormScreenState extends State<VerifyOtpScreen> {
  JsonWidgetData? widgetData;

  @override
  void initState() {
    super.initState();
    _loadJson();
    _registerCustomFunction();
  }

  void _registerCustomFunction() {
    // registry.registerCustomBuilders({
    //   'pin_input': JsonWidgetBuilderContainer(
    //     builder: PinInputBuilder.fromDynamic,
    //   ),
    // });
    registry.registerFunctions(<String, JsonWidgetFunction>{
      
      'verifyOtp': ({args, required registry}) => () {
        Navigator.of(context).pushNamed('/setPin');
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
      
    });

   
  }

  Future<void> _loadJson() async {
    // final formKey = GlobalKey<FormState>();
    // registry.setValue('form_context', formKey);

    final layoutStr = await rootBundle.loadString('assets/otp_verify1.json');
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
