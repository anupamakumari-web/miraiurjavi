import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac/src/parsers/stac_form/stac_form_scope.dart';

class SubmitFormAction {
  const SubmitFormAction();

  factory SubmitFormAction.fromJson(Map<String, dynamic> json) {
    return const SubmitFormAction();
  }
}

class SubmitFormActionParser extends StacActionParser<SubmitFormAction> {
  @override
  String get actionType => 'submit_form';

  @override
  SubmitFormAction getModel(Map<String, dynamic> json) =>
      SubmitFormAction.fromJson(json);

  @override
  Future<void> onCall(BuildContext context, SubmitFormAction model) async {
    final form = StacFormScope.of(context);
    if (form == null) return;

    final values = form.formData as Map<String, dynamic>? ?? {};

    final checkboxValue = values['checkbox_1'] == true;

    final isValid = form.formKey.currentState?.validate() ?? false;

    if (isValid) {
      if (!checkboxValue) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You must agree to the T&C and Privacy Policy'),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Form is valid'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Form is not valid'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
