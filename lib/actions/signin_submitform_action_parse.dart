import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac/src/parsers/stac_form/stac_form_scope.dart';

class SigninSubmitFormActionParser extends StacActionParser<StacFormValidate> {
  @override
  String get actionType => 'signin_submit_form';

  @override
  StacFormValidate getModel(Map<String, dynamic> json) => StacFormValidate.fromJson(json);

  @override
  Future<void> onCall(BuildContext context, StacFormValidate model) async {
    final form = StacFormScope.of(context);
    if (form == null) return;

    final values = form.formData as Map<String, dynamic>? ?? {};

    final checkboxValue = values['checkbox_1'] == true;

    final isValid = form.formKey.currentState?.validate() ?? false;

    if (isValid && checkboxValue) {
      return Stac.onCallFromJson(model.isValid, context);
    } else if (!checkboxValue) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please accept terms and condition'), behavior: SnackBarBehavior.floating));
      return Stac.onCallFromJson(model.isNotValid, context);
    } else {
      return Stac.onCallFromJson(model.isNotValid, context);
    }
  }
}
