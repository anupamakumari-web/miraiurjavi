// Pin Complete Action Data Model
import 'package:flutter/cupertino.dart';
import 'package:stac/stac.dart';

class PinCompleteAction {
  final String message;
  final String? logLevel;
  final String value;

  const PinCompleteAction({
    required this.message,
    this.logLevel,
    required this.value,
  });

  factory PinCompleteAction.fromJson(Map<String, dynamic> json) {
    return PinCompleteAction(
      message: json['message'] as String? ?? 'Pin Completed',
      logLevel: json['logLevel'] as String?,
      value: json['value'] as String? ?? '',
    );
  }
}

// Pin Complete Action Parser Implementation
class PinCompleteActionParser implements StacActionParser<PinCompleteAction> {
  @override
  String get actionType => 'handlePinCompleted';

  @override
  PinCompleteAction getModel(Map<String, dynamic> json) => PinCompleteAction.fromJson(json);

  @override
  Future<void> onCall(BuildContext context, PinCompleteAction model) async {
    print('${model.message}: ${model.value}');
  }
}
