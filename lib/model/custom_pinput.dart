// Data model for Pinput configuration
class CustomPinput {
  final int length;
  final bool obscureText;
  final bool readOnly;
  final bool autofocus;
  final String? hint;
  final String? obscuringCharacter;
  final String? validator;
  final String? onChanged;
  final String? onCompleted;
  final String? onSubmitted;
  final CustomPinputTheme? theme;
  final String pinputType;

  const CustomPinput({
    this.length = 4,
    this.obscureText = false,
    this.readOnly = false,
    this.autofocus = false,
    this.hint,
    this.obscuringCharacter,
    this.validator,
    this.onChanged,
    this.onCompleted,
    this.onSubmitted,
    this.theme,
    this.pinputType = 'default',
  });

  factory CustomPinput.fromJson(Map<String, dynamic> json) {
    return CustomPinput(
      length: json['length'] as int? ?? 4,
      obscureText: json['obscureText'] as bool? ?? false,
      readOnly: json['readOnly'] as bool? ?? false,
      autofocus: json['autofocus'] as bool? ?? false,
      hint: json['hint'] as String?,
      obscuringCharacter: json['obscuringCharacter'] as String?,
      validator: json['validator'] as String?,
      onChanged: json['onChanged'] as String?,
      onCompleted: json['onCompleted'] as String?,
      onSubmitted: json['onSubmitted'] as String?,
      theme: json['theme'] != null ? CustomPinputTheme.fromJson(json['theme'] as Map<String, dynamic>) : null,
      pinputType: json['pinputType'] as String? ?? 'default',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'length': length,
      'obscureText': obscureText,
      'readOnly': readOnly,
      'autofocus': autofocus,
      'hint': hint,
      'obscuringCharacter': obscuringCharacter,
      'validator': validator,
      'onChanged': onChanged,
      'onCompleted': onCompleted,
      'onSubmitted': onSubmitted,
      'theme': theme?.toJson(),
      'pinputType': pinputType,
    };
  }
}

// Theme configuration for Pinput
class CustomPinputTheme {
  final String? width;
  final String? height;
  final String? textStyle;
  final String? decoration;
  final CustomPinputDecoration? defaultPinTheme;
  final CustomPinputDecoration? focusedPinTheme;
  final CustomPinputDecoration? submittedPinTheme;
  final CustomPinputDecoration? followingPinTheme;
  final CustomPinputDecoration? disabledPinTheme;
  final CustomPinputDecoration? errorPinTheme;

  const CustomPinputTheme({
    this.width,
    this.height,
    this.textStyle,
    this.decoration,
    this.defaultPinTheme,
    this.focusedPinTheme,
    this.submittedPinTheme,
    this.followingPinTheme,
    this.disabledPinTheme,
    this.errorPinTheme,
  });

  factory CustomPinputTheme.fromJson(Map<String, dynamic> json) {
    return CustomPinputTheme(
      width: json['width'] as String?,
      height: json['height'] as String?,
      textStyle: json['textStyle'] as String?,
      decoration: json['decoration'] as String?,
      defaultPinTheme: json['defaultPinTheme'] != null ? CustomPinputDecoration.fromJson(json['defaultPinTheme'] as Map<String, dynamic>) : null,
      focusedPinTheme: json['focusedPinTheme'] != null ? CustomPinputDecoration.fromJson(json['focusedPinTheme'] as Map<String, dynamic>) : null,
      submittedPinTheme: json['submittedPinTheme'] != null ? CustomPinputDecoration.fromJson(json['submittedPinTheme'] as Map<String, dynamic>) : null,
      followingPinTheme: json['followingPinTheme'] != null ? CustomPinputDecoration.fromJson(json['followingPinTheme'] as Map<String, dynamic>) : null,
      disabledPinTheme: json['disabledPinTheme'] != null ? CustomPinputDecoration.fromJson(json['disabledPinTheme'] as Map<String, dynamic>) : null,
      errorPinTheme: json['errorPinTheme'] != null ? CustomPinputDecoration.fromJson(json['errorPinTheme'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'textStyle': textStyle,
      'decoration': decoration,
      'defaultPinTheme': defaultPinTheme?.toJson(),
      'focusedPinTheme': focusedPinTheme?.toJson(),
      'submittedPinTheme': submittedPinTheme?.toJson(),
      'followingPinTheme': followingPinTheme?.toJson(),
      'disabledPinTheme': disabledPinTheme?.toJson(),
      'errorPinTheme': errorPinTheme?.toJson(),
    };
  }
}

// Pin decoration configuration
class CustomPinputDecoration {
  final String? color;
  final String? borderColor;
  final String? borderWidth;
  final String? borderRadius;
  final String? backgroundColor;
  final String? textStyle;

  const CustomPinputDecoration({
    this.color,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.backgroundColor,
    this.textStyle,
  });

  factory CustomPinputDecoration.fromJson(Map<String, dynamic> json) {
    return CustomPinputDecoration(
      color: json['color'] as String?,
      borderColor: json['borderColor'] as String?,
      borderWidth: json['borderWidth'] as String?,
      borderRadius: json['borderRadius'] as String?,
      backgroundColor: json['backgroundColor'] as String?,
      textStyle: json['textStyle'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'color': color,
      'borderColor': borderColor,
      'borderWidth': borderWidth,
      'borderRadius': borderRadius,
      'backgroundColor': backgroundColor,
      'textStyle': textStyle,
    };
  }
}
