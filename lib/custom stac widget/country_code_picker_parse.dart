import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

import 'country_code_picker.dart';

// Custom country code Parser
class CustomCountryPickerParser extends StacParser<CustomCountryPicker> {
  const CustomCountryPickerParser();

  @override
  String get type => 'country_picker';

  @override
  CustomCountryPicker getModel(Map<String, dynamic> json) =>
      CustomCountryPicker.fromJson(json);

  @override
  Widget parse(BuildContext context, CustomCountryPicker model) {
    return _CountryPickerFormField(
      label: model.label,
      initialCountryCode: model.initialCountryCode,
      showPhoneCode: model.showPhoneCode,
      showSearch: model.showSearch,
      onChanged: model.onChanged,
      onCountrySelected: model.onCountrySelected,
    );
  }
}

class _CountryPickerFormField extends StatefulWidget {
  final String? label;
  final String? initialCountryCode;
  final bool showPhoneCode;
  final bool showSearch;
  final String? onChanged;
  final String? onCountrySelected;

  const _CountryPickerFormField({
    Key? key,
    this.label,
    this.initialCountryCode,
    this.showPhoneCode = false,
    this.showSearch = true,
    this.onChanged,
    this.onCountrySelected,
  }) : super(key: key);

  @override
  State<_CountryPickerFormField> createState() =>
      _CountryPickerFormFieldState();
}

class _CountryPickerFormFieldState extends State<_CountryPickerFormField> {
  Country? selectedCountry;

  @override
  void initState() {
    super.initState();
    if (widget.initialCountryCode != null) {
      selectedCountry = Country.parse(
        widget.initialCountryCode!,
      );
    }
  }

  void _openCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: widget.showPhoneCode,
      showSearch: widget.showSearch,
      onSelect: (Country country) {
        setState(() {
          selectedCountry = country;
        });

        // Action events
        if (widget.onCountrySelected != null) {
          Stac.onCallFromJson({
            'actionType': widget.onCountrySelected!,
            'value': country.countryCode,
          }, context);
        }

        if (widget.onChanged != null) {
          Stac.onCallFromJson({
            'actionType': widget.onChanged!,
            'value': country.phoneCode,
          }, context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _openCountryPicker,
      child: Row(
        children: [
          if (selectedCountry != null)
            Text(
              '${selectedCountry!.flagEmoji} ${widget.showPhoneCode ? '+${selectedCountry!.phoneCode}' : selectedCountry!.name}',
            )
          else
            const Text('Tap to select'),
          const Spacer(),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}
