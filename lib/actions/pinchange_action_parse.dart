// Pin Change Action Data Model
import 'package:flutter/cupertino.dart';
import 'package:stac/stac.dart';

class PinChangeAction {
  final String message;
  final String? logLevel;
  final String value;

  const PinChangeAction({
    required this.message,
    this.logLevel,
    required this.value,
  });

  factory PinChangeAction.fromJson(Map<String, dynamic> json) {
    return PinChangeAction(
      message: json['message'] as String? ?? 'Pin changed',
      logLevel: json['logLevel'] as String?,
      value: json['value'] as String? ?? '',
    );
  }
}

// Pin Change Action Parser Implementation
class PinChangeActionParser implements StacActionParser<PinChangeAction> {
  @override
  String get actionType => 'pinChange';

  @override
  PinChangeAction getModel(Map<String, dynamic> json) => PinChangeAction.fromJson(json);

  @override
  Future<void> onCall(BuildContext context, PinChangeAction model) async {
    print('${model.message}: ${model.value}');
  }
}
