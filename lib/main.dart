import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:miraiurjavi_app/actions/pinchange_action_parse.dart';
import 'package:miraiurjavi_app/actions/pincomplete_action_parse.dart';
import 'package:miraiurjavi_app/actions/signin_submitform_action_parse.dart';
import 'package:miraiurjavi_app/actions/stepper_action_parse.dart';
import 'package:miraiurjavi_app/custom%20stac%20widget/country_code_picker_parse.dart';
import 'package:miraiurjavi_app/custom%20stac%20widget/custom_dropdown_parse.dart';
import 'package:miraiurjavi_app/custom%20stac%20widget/custom_pinput_parse.dart';
import 'package:miraiurjavi_app/custom%20stac%20widget/custom_stepper_parse.dart';
import 'package:miraiurjavi_app/custom%20stac%20widget/custom_value_listenable_builder_parse.dart';
import 'package:miraiurjavi_app/custom%20stac%20widget/dashed_circular_progress_bar_parse.dart';
import 'package:stac/stac.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart'
    show JsonWidgetRegistry, JsonWidgetFunction;
import 'package:miraiurjavi_app/custom%20builder/circle_avatar_builder.dart';
import 'package:miraiurjavi_app/screens/confirm_pin_screen.dart';
import 'package:miraiurjavi_app/screens/login_screen.dart';
import 'package:miraiurjavi_app/screens/personal_details.dart';
import 'package:miraiurjavi_app/screens/property_details.dart';
import 'package:miraiurjavi_app/screens/property_step1.dart';
import 'package:miraiurjavi_app/screens/set_pin_screen.dart';
import 'package:miraiurjavi_app/screens/verify_otp_screen.dart';
import 'package:miraiurjavi_app/screens/verify_pin_screen.dart';
import 'test_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await Hive.initFlutter();
  await Stac.initialize(
    parsers: [
      CustomCountryPickerParser(),
      CustomPinputParser(),
      CustomStepperParser(),
      CustomDropdownParser(),
      CustomValueListenableBuilderParser({
        'progressNotifier': ValueNotifier<double>(50),
      }),
      CustomDashedCircularProgressBarParser(),
    ],
    actionParsers: [
      PinChangeActionParser(),
      SigninSubmitFormActionParser(),
      PinCompleteActionParser(),
      // StepperNextActionParser(),
    ],
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins', useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: Stac.fromAssets('assets/json/stac_json/signin.json'),
      routes: {
        '/otpVerification': (context) => const VerifyOtpScreen(),
        '/setPin': (context) => const SetPinScreen(),
        '/confirmPin': (context) => const ConfirmPinScreen(),
        '/verifyPin': (context) => const VerifyPinScreen(),
        '/personal_details': (context) => const PersonalDetailScreen(),
        '/property_details': (context) => const PropertyDetailsScreen(),
      },
    );
  }
}
