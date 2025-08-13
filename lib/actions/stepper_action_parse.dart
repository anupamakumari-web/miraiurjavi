// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:miraiurjavi_app/cubit/stepper_cubit.dart';
// import 'package:stac/stac.dart';
// import 'package:stac/src/parsers/stac_form/stac_form_scope.dart';

// class SubmitFormAction {
//   const SubmitFormAction();

//   factory SubmitFormAction.fromJson(Map<String, dynamic> json) {
//     return const SubmitFormAction();
//   }
// }
// class StepperNextActionParser extends StacActionParser<SubmitFormAction> {
//   const StepperNextActionParser();

//   @override
//   String get actionType => 'stepperNext';

//   @override
//   SubmitFormAction getModel(Map<String, dynamic> json) =>
//       SubmitFormAction.fromJson(json);

//   @override
//   FutureOr onCall(BuildContext context, SubmitFormAction model) {
//     context.read<StepperCubit>().nextStep();
//   }
// }