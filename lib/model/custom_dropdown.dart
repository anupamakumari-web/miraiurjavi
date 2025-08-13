import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

class CustomDropdown {
  final StacInputDecoration? decoration;
  final double? width;
  final List<CustomDropdownEntry> entries;
  final String? value;
  final String? onChanged;

  const CustomDropdown({
    this.decoration,
    this.width,
    required this.entries,
    this.value,
    this.onChanged,
  });

  factory CustomDropdown.fromJson(Map<String, dynamic> json) {
    return CustomDropdown(
      decoration: json['decoration'] != null
          ? StacInputDecoration.fromJson(json['decoration'] as Map<String, dynamic>)
          : null,
      width: (json['width'] as num?)?.toDouble(),
      entries: (json['dropdownMenuEntries'] as List<dynamic>? ?? [])
          .map((e) => CustomDropdownEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      value: json['value'] as String?,
      onChanged: json['onChanged'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'decoration': decoration?.toJson(),
      'onChanged': onChanged,
      'width': width,
      'dropdownMenuEntries': entries.map((e) => e.toJson()).toList(),
      'value': value,
    };
  }
}

class CustomDropdownEntry {
  final String value;
  final String label;
  final IconData? leadingIcon;

  CustomDropdownEntry({
    required this.value,
    required this.label,
    this.leadingIcon,
  });

  factory CustomDropdownEntry.fromJson(Map<String, dynamic> json) {
    return CustomDropdownEntry(
      value: json['value'] as String,
      label: json['label'] as String,
      leadingIcon: json['leadingIcon'] != null
          ? _parseIconData(json['leadingIcon'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'label': label,
      'leadingIcon': leadingIcon?.codePoint,
    };
  }

  static IconData? _parseIconData(dynamic iconJson) {
    if (iconJson is Map<String, dynamic> && iconJson['iconData'] is String) {
      switch (iconJson['iconData']) {
        case 'home':
          return Icons.home;
        case 'settings':
          return Icons.settings;
        case 'favorite':
          return Icons.favorite;
        default:
          return null;
      }
    }
    return null;
  }
}