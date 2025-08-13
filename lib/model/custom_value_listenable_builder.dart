
class CustomValueListenableBuilder {
  final String valueNotifier;
  final Map<String, dynamic> builder;

  const CustomValueListenableBuilder({
    required this.valueNotifier,
    required this.builder,
  });

  factory CustomValueListenableBuilder.fromJson(Map<String, dynamic> json) {
    return CustomValueListenableBuilder(
      valueNotifier: json['valueNotifier'] as String,
      builder: json['builder'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'valueNotifier': valueNotifier,
      'builder': builder,
    };
  }
}