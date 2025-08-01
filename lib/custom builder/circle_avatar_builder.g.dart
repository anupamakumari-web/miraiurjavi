// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'circle_avatar_builder.dart';

// **************************************************************************
// Generator: JsonWidgetLibraryBuilder
// **************************************************************************

// ignore_for_file: avoid_init_to_null
// ignore_for_file: deprecated_member_use
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_constructors_in_immutables
// ignore_for_file: prefer_final_locals
// ignore_for_file: prefer_if_null_operators
// ignore_for_file: prefer_single_quotes
// ignore_for_file: unused_local_variable

class CircleAvatarBuilder extends _CircleAvatarBuilder {
  const CircleAvatarBuilder({required super.args});

  static const kType = 'circle_avatar';

  /// Constant that can be referenced for the builder's type.
  @override
  String get type => kType;

  /// Static function that is capable of decoding the widget from a dynamic JSON
  /// or YAML set of values.
  static CircleAvatarBuilder fromDynamic(
    dynamic map, {
    JsonWidgetRegistry? registry,
  }) => CircleAvatarBuilder(args: map);

  @override
  CircleAvatarBuilderModel createModel({
    ChildWidgetBuilder? childBuilder,
    required JsonWidgetData data,
  }) {
    final model = CircleAvatarBuilderModel.fromDynamic(
      args,
      registry: data.jsonWidgetRegistry,
    );

    return model;
  }

  @override
  _CircleAvatar buildCustom({
    ChildWidgetBuilder? childBuilder,
    required BuildContext context,
    required JsonWidgetData data,
    Key? key,
  }) {
    final model = createModel(childBuilder: childBuilder, data: data);

    return _CircleAvatar(
      backgroundColor: model.backgroundColor,
      foregroundColor: model.foregroundColor,
      key: key,
      radius: model.radius,
      child: model.child?.build(childBuilder: childBuilder, context: context),
    );
  }
}

class JsonCircleAvatar extends JsonWidgetData {
  JsonCircleAvatar({
    Map<String, dynamic> args = const {},
    JsonWidgetRegistry? registry,
    this.backgroundColor,
    this.foregroundColor,
    this.radius,
    this.child,
  }) : super(
         jsonWidgetArgs: CircleAvatarBuilderModel.fromDynamic(
           {
             'backgroundColor': backgroundColor,
             'foregroundColor': foregroundColor,
             'radius': radius,
             'child': child,

             ...args,
           },
           args: args,
           registry: registry,
         ),
         jsonWidgetBuilder: () => CircleAvatarBuilder(
           args: CircleAvatarBuilderModel.fromDynamic(
             {
               'backgroundColor': backgroundColor,
               'foregroundColor': foregroundColor,
               'radius': radius,
               'child': child,

               ...args,
             },
             args: args,
             registry: registry,
           ),
         ),
         jsonWidgetType: CircleAvatarBuilder.kType,
       );

  final Color? backgroundColor;

  final Color? foregroundColor;

  final double? radius;

  final JsonWidgetData? child;
}

class CircleAvatarBuilderModel extends JsonWidgetBuilderModel {
  const CircleAvatarBuilderModel(
    super.args, {
    this.backgroundColor,
    this.foregroundColor,
    this.radius,
    this.child,
  });

  final Color? backgroundColor;

  final Color? foregroundColor;

  final double? radius;

  final JsonWidgetData? child;

  static CircleAvatarBuilderModel fromDynamic(
    dynamic map, {
    Map<String, dynamic> args = const {},
    JsonWidgetRegistry? registry,
  }) {
    final result = maybeFromDynamic(map, args: args, registry: registry);

    if (result == null) {
      throw Exception(
        '[CircleAvatarBuilder]: requested to parse from dynamic, but the input is null.',
      );
    }

    return result;
  }

  static CircleAvatarBuilderModel? maybeFromDynamic(
    dynamic map, {
    Map<String, dynamic> args = const {},
    JsonWidgetRegistry? registry,
  }) {
    CircleAvatarBuilderModel? result;

    if (map != null) {
      if (map is String) {
        map = yaon.parse(map, normalize: true);
      }

      if (map is CircleAvatarBuilderModel) {
        result = map;
      } else {
        registry ??= JsonWidgetRegistry.instance;
        map = registry.processArgs(map, <String>{}).value;
        result = CircleAvatarBuilderModel(
          args,
          backgroundColor: () {
            dynamic parsed = ThemeDecoder.decodeColor(
              map['backgroundColor'],
              validate: false,
            );

            return parsed;
          }(),
          foregroundColor: () {
            dynamic parsed = ThemeDecoder.decodeColor(
              map['foregroundColor'],
              validate: false,
            );

            return parsed;
          }(),
          radius: () {
            dynamic parsed = JsonClass.maybeParseDouble(map['radius']);

            return parsed;
          }(),
          child: () {
            dynamic parsed = JsonWidgetData.maybeFromDynamic(
              map['child'],
              registry: registry,
            );

            return parsed;
          }(),
        );
      }
    }

    return result;
  }

  @override
  Map<String, dynamic> toJson() {
    return JsonClass.removeNull({
      'backgroundColor': ThemeEncoder.encodeColor(backgroundColor),
      'foregroundColor': ThemeEncoder.encodeColor(foregroundColor),
      'radius': radius,
      'child': child?.toJson(),

      ...args,
    });
  }
}

class CircleAvatarSchema {
  static const id =
      'https://peiffer-innovations.github.io/flutter_json_schemas/schemas/miraiurjavi_app/circle_avatar.json';

  static final schema = <String, Object>{
    r'$schema': 'http://json-schema.org/draft-07/schema#',
    r'$id': id,
    'title': '_CircleAvatar',
    'type': 'object',
    'additionalProperties': false,
    'properties': {
      'backgroundColor': SchemaHelper.objectSchema(ColorSchema.id),
      'foregroundColor': SchemaHelper.objectSchema(ColorSchema.id),
      'radius': SchemaHelper.numberSchema,
      'child': SchemaHelper.objectSchema(JsonWidgetDataSchema.id),
    },
    'required': [],
  };
}
