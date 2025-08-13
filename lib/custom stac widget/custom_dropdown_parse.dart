import 'package:flutter/material.dart';
import 'package:miraiurjavi_app/model/custom_dropdown.dart';
import 'package:stac/stac.dart';

class CustomDropdownParser extends StacParser<CustomDropdown> {
  const CustomDropdownParser();

  @override
  String get type => 'dropdownMenu';

  @override
  CustomDropdown getModel(Map<String, dynamic> json) =>
      CustomDropdown.fromJson(json);

  @override
  Widget parse(BuildContext context, CustomDropdown model) {
    return _CustomDropdownWidget(model: model);
  }
}

class _CustomDropdownWidget extends StatefulWidget {
  final CustomDropdown model;
  const _CustomDropdownWidget({required this.model});

  @override
  State<_CustomDropdownWidget> createState() => _CustomDropdownWidgetState();
}

class _CustomDropdownWidgetState extends State<_CustomDropdownWidget> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.model.value;
  }

  @override
  Widget build(BuildContext context) {
    final model = widget.model;
    return DropdownButtonFormField<String>(
      decoration: model.decoration?.parse(context),
      value: selectedValue,
      items: model.entries
          .map(
            (entry) => DropdownMenuItem<String>(
              value: entry.value,
              child: Row(
                children: [
                  if (entry.leadingIcon != null)
                    Icon(entry.leadingIcon, size: 18),
                  if (entry.leadingIcon != null) SizedBox(width: 8),
                  Text(entry.label),
                ],
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
        if (model.onChanged != null) {
          Stac.onCallFromJson({
            'actionType': model.onChanged!,
            'value': value,
          }, context);
        }
      },
    );
  }
}
