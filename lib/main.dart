// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:miraiurjavi_app/firebase_options.dart';
// import 'package:miraiurjavi_app/screens/login_screen.dart' show LoginSDUIScreen;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(),
//       home: LoginSDUIScreen(),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  await Hive.initFlutter();
  // final registry = JsonWidgetRegistry.instance;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Login',
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      home: SetPinScreen(),
      routes: {
        '/success': (context) => const SuccessPage(),
        '/otpVerification': (context) => const VerifyOtpScreen(),
        '/setPin': (context) => const SetPinScreen(),
        '/confirmPin': (context) => const ConfirmPinScreen(),
        '/verifyPin': (context) => const VerifyPinScreen(),
        '/personal_details': (context) => const PersonalDetailScreen(),
        '/property_details': (context) => const PropertyDetailsScreen()
      },
    );
  }
}
