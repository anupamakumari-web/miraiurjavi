// import 'package:flutter_bloc/flutter_bloc.dart';

// class StepperCubit extends Cubit<int> {
//   final int totalSteps;

//   StepperCubit({required this.totalSteps}) : super(0);

//   void nextStep() {
//     if (state < totalSteps - 1) {
//       emit(state + 1);
//     }
//   }

//   void previousStep() {
//     if (state > 0) {
//       emit(state - 1);
//     }
//   }

//   bool isLastStep() => state == totalSteps - 1;
// }
