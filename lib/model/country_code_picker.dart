class CustomCountryPicker {
  final String? label;
  final String? initialCountryCode;
  final bool showPhoneCode;
  final bool showSearch;
  final String? onChanged;
  final String? onCountrySelected;

  const CustomCountryPicker({
    this.label,
    this.initialCountryCode,
    this.showPhoneCode = false,
    this.showSearch = true,
    this.onChanged,
    this.onCountrySelected,
  });

  factory CustomCountryPicker.fromJson(Map<String, dynamic> json) {
    return CustomCountryPicker(
      label: json['label'] as String?,
      initialCountryCode: json['initialCountryCode'] as String?,
      showPhoneCode: json['showPhoneCode'] as bool? ?? false,
      showSearch: json['showSearch'] as bool? ?? true,
      onChanged: json['onChanged'] as String?,
      onCountrySelected: json['onCountrySelected'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'label': label,
        'initialCountryCode': initialCountryCode,
        'showPhoneCode': showPhoneCode,
        'showSearch': showSearch,
        'onChanged': onChanged,
        'onCountrySelected': onCountrySelected,
      };
}
